// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/foundation.dart';
import 'package:serv_expert_webclient/data/exceptions.dart';
import 'package:serv_expert_webclient/services/auth_data_repository.dart';

class ApiClient {
  ApiClient() : _dio = Dio(BaseOptions(baseUrl: 'http://localhost:3000/')) {
    _dio.interceptors.add(RetryInterceptor(dio: _dio));
  }

  final Dio _dio;
  final _authDataRepository = AuthDataRepository();
  Completer<String?>? _refreshCompleter;

  Future<R> get<R>(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      var r = await _dio.get(path, queryParameters: queryParameters, options: Options(headers: _headers));
      return r.data as R;
    } on DioError catch (e) {
      // Refresh access token if it's expired
      if (e.response?.statusCode == 401 && _authDataRepository.refreshToken != null) {
        String? newAccessToken = await _refreshAccessTokenRace(_authDataRepository.refreshToken!);
        if (newAccessToken != null) return get<R>(path, queryParameters: queryParameters);
      }

      // Throw understandable exception
      throw _mapError(e);
    }
  }

  Future<R> post<R, D>(String path, {D? data, Map<String, dynamic>? queryParameters}) async {
    try {
      var r = await _dio.post(path, data: data, queryParameters: queryParameters, options: Options(headers: _headers));
      return r.data as R;
    } on DioError catch (e) {
      // Refresh access token if it's expired
      if (e.response?.statusCode == 401 && _authDataRepository.refreshToken != null) {
        String? newAccessToken = await _refreshAccessTokenRace(_authDataRepository.refreshToken!);
        if (newAccessToken != null) return post<R, D>(path, data: data, queryParameters: queryParameters);
      }

      // Throw understandable exception
      throw _mapError(e);
    }
  }

  Map<String, dynamic> get _headers => {'Content-Type': 'application/json', 'authorization': 'Bearer ${_authDataRepository.accessToken}'};

  /// Map DioError to domain exceptions
  Exception _mapError(DioError e) {
    // Connection errors
    if (e.type == DioErrorType.connectionError ||
        e.type == DioErrorType.receiveTimeout ||
        e.type == DioErrorType.sendTimeout ||
        e.type == DioErrorType.connectionTimeout) {
      return ConnectionError(e.message ?? 'Connection error');
    }

    // Known server errors
    var response = e.response;
    if (response != null) {
      // Parse error message
      String message;
      if (response.data is Map && response.data.containsKey('message')) {
        message = response.data['message'];
      } else {
        message = response.data.toString();
      }
      // Map status code to exception
      switch (response.statusCode) {
        case 400:
          return InvalidArgument(message);
        case 401:
          return Unauthorized(message);
        case 403:
          return PermissionDenied(message);
        case 404:
          return UnexistedResource(message);
        case 500:
          return ServerError(message);
      }
    }

    // Unknown error
    return UnknownException(e.message ?? 'Unknown error');
  }

  /// Wrapper for refreshAccessToken that prevents multiple simultaneous calls
  Future<String?> _refreshAccessTokenRace(String refreshToken) async {
    if (_refreshCompleter == null) {
      _refreshCompleter = Completer<String?>();
      _refreshAccessToken(refreshToken).then((value) {
        _refreshCompleter!.complete(value);
        _refreshCompleter = null;
      });
    }
    return _refreshCompleter!.future;
  }

  /// Refresh access token using refresh token
  /// Returns new access token or null if refresh token is invalid
  Future<String?> _refreshAccessToken(String refreshToken) async {
    debugPrint('refreshing token');
    try {
      var r = await Dio(BaseOptions(baseUrl: 'http://localhost:3000/'))
          .post<Map<String, dynamic>>('auth/refresh-token', data: {'grant_type': 'refresh_token', 'refresh_token': refreshToken});

      if (r.data != null) {
        await _authDataRepository.setAccessToken(r.data!['accessToken']);
        await _authDataRepository.setRefreshToken(r.data!['refreshToken']);
        await _authDataRepository.setAuthData(AuthData.fromMap(r.data!['authData']));
        debugPrint('token refreshed');
        return r.data!['accessToken'];
      }
    } catch (e) {
      debugPrint('refresh token failed');
      debugPrint(e.toString());
      await _authDataRepository.drop();
    }

    return null;
  }
}

// class AuthInterceptor extends QueuedInterceptor {
//   final _authDataRepository = AuthDataRepository();

//   @override
//   onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
//     String? accessToken = _authDataRepository.accessToken;
//     String? refreshToken = _authDataRepository.refreshToken;

//     if (accessToken == null && refreshToken != null) {
//       try {
//         accessToken = await refreshAccessToken(refreshToken);
//       } catch (_) {}
//     }

//     if (accessToken != null) {
//       options.headers['authorization'] = 'Bearer $accessToken';
//     }

//     handler.next(options);
//   }

//   @override
//   onError(DioError err, ErrorInterceptorHandler handler) async {
//     if (err.response?.statusCode == 401 && err.response?.data == 'jwt expired') {
//       debugPrint('jwt expired');

//       String? refreshToken = _authDataRepository.refreshToken;
//       if (refreshToken != null) {
//         String? newAccessToken = await refreshAccessToken(refreshToken);

//         // Retry request with new access token
//         if (newAccessToken != null) {
//           try {
//             var reRequest =
//                 await Dio(BaseOptions(baseUrl: 'http://localhost:3000/')).fetch(err.requestOptions..headers['authorization'] = 'Bearer $newAccessToken');
//             return handler.resolve(reRequest);
//           } on DioError catch (e) {
//             debugPrint(e.toString());
//             return handler.reject(e);
//           }
//         }
//       }
//     }
//     return handler.next(err);
//   }

//   Future<String?> refreshAccessToken(String refreshToken) async {
//     debugPrint('refreshing token');

//     try {
//       var r = await Dio(BaseOptions(baseUrl: 'http://localhost:3000/'))
//           .post<Map<String, dynamic>>('auth/refresh-token', data: {'grant_type': 'refresh_token', 'refresh_token': refreshToken});

//       if (r.data != null) {
//         await _authDataRepository.setAccessToken(r.data!['accessToken']);
//         await _authDataRepository.setRefreshToken(r.data!['refreshToken']);
//         await _authDataRepository.setAuthData(AuthData.fromMap(r.data!['authData']));
//         debugPrint('token refreshed');
//         return r.data!['accessToken'];
//       }
//     } catch (e) {
//       debugPrint('refresh token failed');
//       debugPrint(e.toString());
//       await _authDataRepository.drop();
//     }

//     return null;
//   }
// }
