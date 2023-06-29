import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:serv_expert_webclient/services/api_client.dart';
import 'package:serv_expert_webclient/services/auth_data_repository.dart';

abstract class AuthService {
  /// Returns true if user is authorized
  bool get authorized;

  /// Returns current user id or null if user is not authorized
  String? get userId;

  /// Returns current user email or null if user is not authorized
  String? get email;

  /// Returns current user phone number or null if user is not authorized
  String? get phoneNumber;

  /// Returns current user display name or null if user is not authorized
  String? get displayName;

  /// Sign in with phone number for web
  Future signInWithPhoneNumber(String phoneNumber);

  /// Confirm phone number for web
  Future<String?> confirmPhoneNumber(String smsCode);

  /// Sign in with Google
  Future<String?> signInWithGoogle({required String code});

  /// Submit registration data
  Future<String?> submitRegistrationData({required String phone, required String firstName, required String lastName, required String email});

  /// Sign out
  Future<void> signOut();
}

class AuthServiceHttpImpl extends AuthService {
  AuthServiceHttpImpl({required this.apiClient});

  final ApiClient apiClient;
  final AuthDataRepository _authDataRepository = AuthDataRepository();

  @override
  bool get authorized => _authDataRepository.authData != null;

  @override
  String? get userId => _authDataRepository.authData?.entityId;

  @override
  String? get displayName => 'asd';

  @override
  String? get email => 'asd';

  @override
  String? get phoneNumber => 'qwe';

  @override
  Future<String?> signInWithGoogle({required String code}) async {
    var res = await apiClient.post('auth/client/google-signin', data: {'code': code});
    if (res['status'] == 'authorized') {
      await _authDataRepository.setAuthData(AuthData.fromMap(res['authData']));
      await _authDataRepository.setAccessToken(res['accessToken']);
      await _authDataRepository.setRefreshToken(res['refreshToken']);
      return 'authorized';
    }

    if (res['status'] == 'registration_required') {
      _registrationToken = res['registrationToken'];
      return 'registration_required';
    }

    return null;
  }

  /// Token uses for phone code confirmation
  String? _phoneToken;

  /// Token uses for multistep registration flow
  String? _registrationToken;

  @override
  Future signInWithPhoneNumber(String phoneNumber) async {
    var res = await apiClient.post('auth/client/phone-signin', data: {'phoneNumber': phoneNumber});
    debugPrint(res.toString());

    _phoneToken = res['token'];
  }

  @override
  Future<String?> confirmPhoneNumber(String smsCode) async {
    assert(_phoneToken != null);

    var res = await apiClient.post('auth/client/verify-code', data: {'token': _phoneToken, 'code': smsCode});
    debugPrint(res.toString());

    if (res['status'] == 'authorized') {
      await _authDataRepository.setAuthData(AuthData.fromMap(res['authData']));
      await _authDataRepository.setAccessToken(res['accessToken']);
      await _authDataRepository.setRefreshToken(res['refreshToken']);
      return 'authorized';
    }

    if (res['status'] == 'registration_required') {
      _registrationToken = res['registrationToken'];
      return 'registration_required';
    }

    return null;
  }

  @override
  Future<String?> submitRegistrationData({required String phone, required String firstName, required String lastName, required String email}) async {
    assert(_registrationToken != null);

    var res = await apiClient.post('auth/client/register',
        data: {'registrationToken': _registrationToken, 'phone': phone, 'firstName': firstName, 'lastName': lastName, 'email': email});

    if (res['status'] == 'authorized') {
      await _authDataRepository.setAuthData(AuthData.fromMap(res['authData']));
      await _authDataRepository.setAccessToken(res['accessToken']);
      await _authDataRepository.setRefreshToken(res['refreshToken']);
      return 'authorized';
    }
    return null;
  }

  @override
  Future<void> signOut() async {
    await _authDataRepository.drop();
  }
}
