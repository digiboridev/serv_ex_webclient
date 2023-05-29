// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:serv_expert_webclient/data/exceptions.dart';
import 'package:serv_expert_webclient/services/auth_data_repository.dart';
import 'package:serv_expert_webclient/utils/map_value.dart';

class ApiClient {
  ApiClient() {
    // _storage = GetStorage();
    // _accessToken = _storage.read<String?>('access_token');
    // _refreshToken = _storage.read<String?>('refresh_token');
    // _userId = _storage.read<String?>('user_id');

    _dio = Dio(BaseOptions(baseUrl: 'http://localhost:3000/'));
    _dio.interceptors.add(_interceptor);
  }

  late final Dio _dio;
  // late final GetStorage _storage;

  // String? _accessToken;
  // String? _refreshToken;
  // String? _userId;
  // String? _registrationToken;

  // bool get authorized => _accessToken != null && _refreshToken != null && _userId != null;
  // String? get userId => _userId;

  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      Response r = await _dio.post(
        path,
        queryParameters: queryParameters,
        options: Options(
          headers: headers ?? _headers,
        ),
      );
      return r.data;
    } on DioError catch (e) {
      throw _mapError(e);
    }
  }

  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      Response r = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers ?? _headers,
        ),
      );
      return r.data;
    } on DioError catch (e) {
      throw _mapError(e);
    }
  }

  Interceptor get _interceptor => InterceptorsWrapper(
        // onResponse: (e, handler) {
        //   if (e.data is Map && e.data.containsKey('accessToken')) _setAccessToken(e.data['accessToken']);
        //   if (e.data is Map && e.data.containsKey('refreshToken')) _setRefreshToken(e.data['refreshToken']);
        //   if (e.data is Map && e.data.containsKey('userId')) _setUserId(e.data['userId']);
        //   if (e.data is Map && e.data.containsKey('registrationToken')) _setRegistrationToken(e.data['registrationToken']);
        //   return handler.next(e);
        // },
        onError: (e, handler) async {
          if (e.response?.statusCode == 401 && e.response?.data == 'jwt expired') {
            debugPrint('jwt expired');
            AuthData? authData = AuthDataRepository().getAuthData();
            if (authData != null) {
              // bool success = await refreshTokens();
              var r = await _dio.post('auth/refresh-token', data: {'grant_type': 'refresh_token', 'refresh_token': authData.refreshToken});

              if (r.statusCode == 200) {
                AuthData authData = AuthData.fromMap(r.data);
                await AuthDataRepository().saveAuthData(authData);

                return handler.resolve(
                  await _dio.request(
                    e.requestOptions.path,
                    data: e.requestOptions.data,
                    queryParameters: e.requestOptions.queryParameters,
                    options: Options(headers: _headers, method: e.requestOptions.method),
                  ),
                );
              }
            }
          }
          return handler.next(e);
        },
      );

  // Future<bool> refreshTokens() async {
  //   try {
  //     var r = await _dio.post(
  //       'auth/refresh-token',
  //       data: {
  //         'grant_type': 'refresh_token',
  //         'refresh_token': _refreshToken,
  //       },
  //     );
  //     var accessToken = getMapValue<String>(r.data, 'accessToken');
  //     if (accessToken != null) {
  //       _setAccessToken(accessToken);
  //       debugPrint('Tokens refreshed');
  //       return true;
  //     } else {
  //       debugPrint('Failed refreshing tokens');
  //       return false;
  //     }
  //   } catch (_) {
  //     debugPrint('Error refreshing tokens');
  //     return false;
  //   }
  // }

  // _setAccessToken(String token) {
  //   _accessToken = token;
  //   _storage.write('accessToken', _accessToken);
  //   debugPrint('Access token set');
  // }

  // _setRefreshToken(String token) {
  //   _refreshToken = token;
  //   _storage.write('refreshToken', _refreshToken);
  //   debugPrint('Refresh token set');
  // }

  // _setUserId(String id) {
  //   _userId = id;
  //   _storage.write('userId', _userId);
  //   debugPrint('User id set');
  // }

  // _setRegistrationToken(String token) {
  //   _registrationToken = token;
  //   debugPrint('Registration token set');
  // }

  // clearData() {
  //   _accessToken = null;
  //   _refreshToken = null;
  //   _userId = null;
  //   _registrationToken = null;
  //   _storage.remove('accessToken');
  //   _storage.remove('refreshToken');
  //   _storage.remove('userId');
  //   debugPrint('data cleared');
  // }

  // Map<String, dynamic> get _headers => {'authorization': 'Bearer $_accessToken'};
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
