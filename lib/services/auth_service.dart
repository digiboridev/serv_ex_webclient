// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:firebase_auth/firebase_auth.dart';
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
  Future confirmPhoneNumber(String smsCode);

  /// Sign in with Google
  Future signInWithGoogle();

  /// Sign out
  Future<void> signOut();
}

class FireAuthServiceImpl implements AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  bool get authorized => _auth.currentUser != null;

  @override
  String? get userId => _auth.currentUser?.uid;

  @override
  String? get email => _auth.currentUser?.email;

  @override
  String? get phoneNumber => _auth.currentUser?.phoneNumber;

  @override
  String? get displayName => _auth.currentUser?.displayName;

  ConfirmationResult? _phoneConfirmationResult;

  @override
  Future signInWithPhoneNumber(String phoneNumber) async {
    _phoneConfirmationResult = await _auth.signInWithPhoneNumber(phoneNumber);
  }

  @override
  Future confirmPhoneNumber(String smsCode) async {
    if (_phoneConfirmationResult is ConfirmationResult) {
      UserCredential credential = await _phoneConfirmationResult!.confirm(smsCode);
      return credential;
    } else {
      throw Exception('Phone confirmation result is null, please call signInWithPhoneNumberWeb first');
    }
  }

  @override
  Future signInWithGoogle() async {
    GoogleAuthProvider googleProvider = GoogleAuthProvider();
    // googleProvider.addScope('https://www.googleapis.com/auth/contacts.readonly');
    // googleProvider.setCustomParameters({'login_hint': 'user@example.com'});
    return await FirebaseAuth.instance.signInWithPopup(googleProvider);
  }

  @override
  Future<void> signOut() async {
    return await _auth.signOut();
  }
}

class AuthServiceHttpImpl extends AuthService {
  AuthServiceHttpImpl({required this.apiClient});

  final ApiClient apiClient;
  final AuthDataRepository _authDataRepository = AuthDataRepository();

  @override
  bool get authorized => _authDataRepository.getAuthData() != null;

  @override
  String? get userId => _authDataRepository.getAuthData()?.userId;

  @override
  String? get displayName => 'asd';

  @override
  String? get email => 'asd';

  @override
  String? get phoneNumber => 'qwe';

  @override
  Future signInWithGoogle() {
    throw UnimplementedError();
  }

  String? _phoneToken;

  @override
  Future signInWithPhoneNumber(String phoneNumber) async {
    var res = await apiClient.post('auth/phone-signin', data: {'phoneNumber': phoneNumber});
    debugPrint(res.toString());
    _phoneToken = res['token'];
  }

  @override
  Future confirmPhoneNumber(String smsCode) async {
    var res = await apiClient.post('auth/verify-code', data: {'token': _phoneToken, 'code': smsCode});
    debugPrint(res.toString());
  }

  @override
  Future<void> signOut() async {
    _authDataRepository.deleteAuthData();
  }
}
