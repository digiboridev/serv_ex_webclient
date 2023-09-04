// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/foundation.dart';
import 'package:serv_expert_webclient/data/exceptions.dart';
import 'package:serv_expert_webclient/data/reposiotories/auth_data_repository.dart';
import 'package:serv_expert_webclient/utils/sse_connection.dart';

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
    } on DioException catch (e) {
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
    } on DioException catch (e) {
      // Refresh access token if it's expired
      if (e.response?.statusCode == 401 && _authDataRepository.refreshToken != null) {
        String? newAccessToken = await _refreshAccessTokenRace(_authDataRepository.refreshToken!);
        if (newAccessToken != null) return post<R, D>(path, data: data, queryParameters: queryParameters);
      }

      // Throw understandable exception
      throw _mapError(e);
    }
  }

  Stream<Map<String, dynamic>> sse(String path, {Map<String, dynamic>? queryParameters}) {
    return SSEConnection.connect(url: 'http://localhost:3000$path?${queryParameters?.entries.map((e) => '${e.key}=${e.value}').join('&')}', headers: _headers);
  }

  Map<String, String> get _headers {
    if (_authDataRepository.accessToken != null) {
      return {'authorization': 'Bearer ${_authDataRepository.accessToken}'};
    } else {
      return {};
    }
  }

  /// Map DioError to domain exceptions
  Exception _mapError(DioException e) {
    var response = e.response;
    // Return connection error if if the request can't reach to the HTTP server
    if (response == null) return ConnectionError(e.message ?? 'Connection error');

    // Parse error message
    String message;
    if (response.data is Map && response.data.containsKey('message')) {
      message = response.data['message'];
    } else if (response.data is String) {
      message = response.data;
    } else {
      message = response.data?.toString() ?? 'Unknown error';
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
      default:
        return UnknownException(message);
    }
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
