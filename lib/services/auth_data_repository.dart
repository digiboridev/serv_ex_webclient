import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:get_storage/get_storage.dart';

class AuthDataRepository {
  factory AuthDataRepository() => instance;
  static final AuthDataRepository instance = AuthDataRepository._();
  AuthDataRepository._() {
    init();
  }

  final GetStorage _storage = GetStorage();

  String? _accessToken;
  String? _refreshToken;
  AuthData? _authData;

  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;
  AuthData? get authData => _authData;

  init() {
    final String? refLocal = _storage.read<String>('refreshToken');
    if (refLocal != null) _refreshToken = refLocal;

    final Map<String, dynamic>? authLocal = _storage.read<Map<String, dynamic>>('authData');
    if (authLocal != null) _authData = AuthData.fromMap(authLocal);
  }

  Future setAuthData(AuthData authData) async {
    _authData = authData;
    await _storage.write('authData', authData.toMap());
  }

  Future setAccessToken(String accessToken) async {
    _accessToken = accessToken;
  }

  Future<void> setRefreshToken(String refreshToken) async {
    _refreshToken = refreshToken;
    await _storage.write('refreshToken', refreshToken);
  }

  Future<void> drop() async {
    _accessToken = null;
    _refreshToken = null;
    _authData = null;
    await _storage.remove('authData');
    await _storage.remove('refreshToken');
  }

  invalidateAccess() {
    _accessToken = null;
  }
}

class AuthData extends Equatable {
  const AuthData({
    required this.companiesIds,
    required this.entityId,
  });

  final List<String> companiesIds;
  final String entityId;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'companiesIds': companiesIds,
      'entityId': entityId,
    };
  }

  factory AuthData.fromMap(Map<String, dynamic> map) {
    return AuthData(
      companiesIds: List<String>.from((map['companiesIds'])),
      entityId: map['entityId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthData.fromJson(String source) => AuthData.fromMap(json.decode(source) as Map<String, dynamic>);

  AuthData copyWith({
    List<String>? companiesIds,
    String? entityId,
  }) {
    return AuthData(
      companiesIds: companiesIds ?? this.companiesIds,
      entityId: entityId ?? this.entityId,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [companiesIds, entityId];
}
