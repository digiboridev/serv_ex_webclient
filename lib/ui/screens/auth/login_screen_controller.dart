import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/services/fireauth.dart';
import 'package:serv_expert_webclient/ui/screens/auth/login_screen_state.dart';

class LoginScreenController extends StateNotifier<LoginScreenState> {
  LoginScreenController({
    required FireAuthService fireAuthService,
  })  : _fireAuthService = fireAuthService,
        super(const LSSInitial());

  final FireAuthService _fireAuthService;

  updateState() {
    bool authorized = _fireAuthService.authorized;
    if (!authorized) {
      state = const LSSUnauthorized();
    } else {
      state = const LSSAuthorized();
    }
  }

  signInWithPhone(String phone) async {
    state = state.copyWith(busy: true);

    try {
      await _fireAuthService.signInWithPhoneNumberWeb(phone);
      state = LSSsmsSent(phone: phone);
    } catch (e) {
      state = state.copyWith(busy: false, error: e.toString());
    }
  }

  confirmSmsCode(String smsCode) async {
    state = state.copyWith(busy: true);

    try {
      await _fireAuthService.confirmPhoneNumberWeb(smsCode);
      state = const LSSAuthorized();
    } catch (e) {
      state = state.copyWith(busy: false, error: e.toString());
    }
  }
}
