import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:serv_expert_webclient/data/exceptions.dart';

abstract class AuthService {
  /// Returns true if user is authorized
  bool get authorized;

  /// Returns current user id or null if user is not authorized
  String? get uid;

  /// Returns current user email or null if user is not authorized
  String? get email;

  /// Returns current user phone number or null if user is not authorized
  String? get phoneNumber;

  /// Returns current user display name or null if user is not authorized
  String? get displayName;

  /// Sign in anonymously
  Future signInAnonymously();

  /// Sign in with phone number for web
  Future signInWithPhoneNumberWeb(String phoneNumber);

  /// Confirm phone number for web
  Future confirmPhoneNumberWeb(String smsCode);

  /// Sign in with Google
  Future signInWithGoogle();

  // Sign in with login and password
  Future signInWithCustomJWT({required String login, required String password});

  /// Reload user data
  Future<void> reload();

  /// Sign out
  Future<void> signOut();

  /// Delete user
  Future<void> delete();
}

class FireAuthServiceImpl implements AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  bool get authorized => _auth.currentUser != null;

  @override
  String? get uid => _auth.currentUser?.uid;

  @override
  String? get email => _auth.currentUser?.email;

  @override
  String? get phoneNumber => _auth.currentUser?.phoneNumber;

  @override
  String? get displayName => _auth.currentUser?.displayName;

  ConfirmationResult? _phoneConfirmationResult;

  @override
  Future signInAnonymously() async {
    return await _auth.signInAnonymously();
  }

  @override
  Future signInWithPhoneNumberWeb(String phoneNumber) async {
    _phoneConfirmationResult = await _auth.signInWithPhoneNumber(phoneNumber);
  }

  @override
  Future confirmPhoneNumberWeb(String smsCode) async {
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
    googleProvider.addScope('https://www.googleapis.com/auth/contacts.readonly');
    googleProvider.setCustomParameters({'login_hint': 'user@example.com'});
    return await FirebaseAuth.instance.signInWithRedirect(googleProvider);
  }

  @override
  Future signInWithCustomJWT({required String login, required String password}) async {
    try {
      var result = await FirebaseFunctions.instanceFor(region: 'europe-west1').httpsCallable('auth_custom_jwt').call({
        'login': login,
        'password': password,
      });

      await FirebaseAuth.instance.signInWithCustomToken(result.data['token']);
    } catch (e) {
      if (e is FirebaseFunctionsException && e.code == 'invalid-argument') {
        throw InvalidArgument(e.message ?? 'Invalid argument');
      }
      throw UnknownException(e.toString());
    }
  }

  @override
  Future<void> reload() async {
    return await _auth.currentUser?.reload();
  }

  @override
  Future<void> signOut() async {
    return await _auth.signOut();
  }

  @override
  Future<void> delete() async {
    return await _auth.currentUser?.delete();
  }
}
