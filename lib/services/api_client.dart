// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:serv_expert_webclient/data/exceptions.dart';
import 'package:serv_expert_webclient/services/auth_data_repository.dart';

class ApiClient {
  ApiClient() {
    _dio = Dio(BaseOptions(baseUrl: 'http://localhost:3000/'));
    _dio.interceptors.add(RefreshTokenInterceptor(_dio));
  }
  late final Dio _dio;

  Future<Map<String, dynamic>> get(String path, {Map<String, dynamic>? headers}) async {
    try {
      Response r = await _dio.post(path, options: Options(headers: headers ?? _headers));
      return r.data;
    } on DioError catch (e) {
      throw _mapError(e);
    }
  }

  Future<Map<String, dynamic>> post(String path, {Map<String, dynamic>? data, Map<String, dynamic>? headers}) async {
    try {
      Response r = await _dio.post(path, data: data, options: Options(headers: headers ?? _headers));
      return r.data;
    } on DioError catch (e) {
      throw _mapError(e);
    }
  }

  Map<String, dynamic> get _headers {
    AuthData? authData = AuthDataRepository().getAuthData();
    if (authData == null) {
      return {};
    }
    return {'authorization': 'Bearer ${authData.accessToken}'};
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

class RefreshTokenInterceptor extends Interceptor {
  RefreshTokenInterceptor(this._dio);
  final Dio _dio;

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 && err.response?.data == 'jwt expired') {
      debugPrint('jwt expired');

      AuthData? authData = AuthDataRepository().getAuthData();

      if (authData != null) {
        debugPrint('refreshing token');

        var r = await _dio.post('auth/refresh-token', data: {'grant_type': 'refresh_token', 'refresh_token': authData.refreshToken});

        if (r.statusCode == 200) {
          AuthData authData = AuthData.fromMap(r.data);
          await AuthDataRepository().saveAuthData(authData);
          debugPrint('token refreshed');

          return handler.resolve(
            await _dio.request(
              err.requestOptions.path,
              data: err.requestOptions.data,
              queryParameters: err.requestOptions.queryParameters,
              options: Options(headers: {'authorization': 'Bearer ${authData.accessToken}'}, method: err.requestOptions.method),
            ),
          );
        }
      }
    }
    return handler.next(err);
  }
}
