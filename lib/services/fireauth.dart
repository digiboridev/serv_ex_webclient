import 'package:firebase_auth/firebase_auth.dart';

class FireAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // User? get user => _auth.currentUser;
  // Stream<User?> get userStream => _auth.userChanges().asBroadcastStream();

  /// Returns true if user is authorized
  bool get authorized => _auth.currentUser != null;

  /// Returns current user id or null if user is not authorized
  String? get uid => _auth.currentUser?.uid;

  /// Returns current user email or null if user is not authorized
  String? get email => _auth.currentUser?.email;

  /// Returns current user phone number or null if user is not authorized
  String? get phoneNumber => _auth.currentUser?.phoneNumber;

  /// Returns current user display name or null if user is not authorized
  String? get displayName => _auth.currentUser?.displayName;

  // Uses by phone sign in for web
  ConfirmationResult? _phoneConfirmationResult;

  Future signInAnonymously() async {
    return await _auth.signInAnonymously();
  }

  Future signInWithPhoneNumberWeb(String phoneNumber) async {
    _phoneConfirmationResult = await _auth.signInWithPhoneNumber(phoneNumber);
  }

  Future confirmPhoneNumberWeb(String smsCode) async {
    if (_phoneConfirmationResult is ConfirmationResult) {
      UserCredential credential = await _phoneConfirmationResult!.confirm(smsCode);
      return credential;
    } else {
      throw Exception('Phone confirmation result is null, please call signInWithPhoneNumberWeb first');
    }
  }

  Future<void> reload() async {
    return await _auth.currentUser?.reload();
  }

  Future<void> signOut() async {
    return await _auth.signOut();
  }

  Future<void> delete() async {
    return await _auth.currentUser?.delete();
  }
}
