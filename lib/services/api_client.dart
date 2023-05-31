// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/foundation.dart';
import 'package:serv_expert_webclient/data/exceptions.dart';
import 'package:serv_expert_webclient/services/auth_data_repository.dart';

class ApiClient {
  ApiClient() {
    _dio = Dio(BaseOptions(baseUrl: 'http://localhost:3000/'));
    _dio.interceptors.add(AuthInterceptor());
    _dio.interceptors.add(RetryInterceptor(dio: _dio));
  }
  late final Dio _dio;

  Future<R> get<R>(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      var r = await _dio.get(path, queryParameters: queryParameters);
      return r.data as R;
    } on DioError catch (e) {
      throw _mapError(e);
    }
  }

  Future<R> post<R, D>(String path, {D? data, Map<String, dynamic>? queryParameters}) async {
    try {
      var r = await _dio.post(path, data: data, queryParameters: queryParameters);
      return r.data as R;
    } on DioError catch (e) {
      throw _mapError(e);
    }
  }

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

    return UnknownException(e.message ?? 'Unknown error');
  }
}

class AuthInterceptor extends QueuedInterceptor {
  final _authDataRepository = AuthDataRepository();

  // Add authorization header to every request if token is available
  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    AuthData? authData = _authDataRepository.authData;
    if (authData != null) {
      options.headers['authorization'] = 'Bearer ${authData.accessToken}';
    }
    handler.next(options);
  }

  // Refresh token if it is expired
  @override
  onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 && err.response?.data == 'jwt expired') {
      debugPrint('jwt expired');

      AuthData? authData = _authDataRepository.authData;

      if (authData != null) {
        debugPrint('refreshing token');

        Dio tokendio = Dio(BaseOptions(baseUrl: 'http://localhost:3000/'));

        var r = await tokendio.post('auth/refresh-token', data: {'grant_type': 'refresh_token', 'refresh_token': authData.refreshToken});

        if (r.statusCode == 200) {
          AuthData authData = AuthData.fromMap(r.data);
          await _authDataRepository.saveAuthData(authData);
          debugPrint('token refreshed');

          var reRequest = await tokendio.request(
            err.requestOptions.path,
            data: err.requestOptions.data,
            queryParameters: err.requestOptions.queryParameters,
            options: Options(headers: {'authorization': 'Bearer ${authData.accessToken}'}, method: err.requestOptions.method),
          );
          return handler.resolve(reRequest);
        } else {
          debugPrint('refresh token failed');
          await _authDataRepository.deleteAuthData();
        }
      }
    }
    return handler.next(err);
  }
}
