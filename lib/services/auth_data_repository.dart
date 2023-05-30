// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:get_storage/get_storage.dart';

class AuthDataRepository {
  AuthDataRepository();
  final GetStorage _storage = GetStorage();

  AuthData? get authData {
    final Map<String, dynamic>? authDataMap = _storage.read<Map<String, dynamic>>('authData');
    if (authDataMap == null) return null;
    return AuthData.fromMap(authDataMap);
  }

  Future<void> saveAuthData(AuthData authData) async {
    await _storage.write('authData', authData.toMap());
  }

  Future<void> deleteAuthData() async {
    await _storage.remove('authData');
  }
}

class AuthData {
  AuthData({
    required this.accessToken,
    required this.refreshToken,
    required this.userId,
  });

  final String accessToken;
  final String refreshToken;
  final String userId;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'userId': userId,
    };
  }

  factory AuthData.fromMap(Map<String, dynamic> map) {
    return AuthData(
      accessToken: map['accessToken'] as String,
      refreshToken: map['refreshToken'] as String,
      userId: map['userId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthData.fromJson(String source) => AuthData.fromMap(json.decode(source) as Map<String, dynamic>);
}
