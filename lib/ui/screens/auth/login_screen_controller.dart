import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/data/exceptions.dart';
import 'package:serv_expert_webclient/data/reposiotories/clients_repository.dart';
import 'package:serv_expert_webclient/services/fireauth.dart';
import 'package:serv_expert_webclient/ui/screens/auth/login_screen_state.dart';

class LoginScreenController extends StateNotifier<LoginScreenState> {
  LoginScreenController({
    required FireAuthService fireAuthService,
    required ClientsRepository clientsRepository,
  })  : _fireAuthService = fireAuthService,
        _clientsRepository = clientsRepository,
        super(const LSSLoading());

  final FireAuthService _fireAuthService;
  final ClientsRepository _clientsRepository;

  Future updateState() async {
    bool authorized = _fireAuthService.authorized;

    if (!authorized) {
      state = const LSSUnauthorized();
    } else {
      state = const LSSLoading();
      try {
        await _clientsRepository.clientById(id: _fireAuthService.uid!, forceNetwork: true);
      } on UnexistedResource {
        state = LSSClientDetails(
          phone: _fireAuthService.phoneNumber,
          email: _fireAuthService.email,
          firstName: _fireAuthService.displayName?.split(' ').first,
          lastName: _fireAuthService.displayName?.split(' ').last,
        );
      } catch (e) {
        state = const LSSUpdateError();
      }
    }
  }

  signInWithPhone(String phone) async {
    LoginScreenState currentState = state;
    if (currentState is! LSSUnauthorized) throw Exception('Wrong state');
    if (currentState.busy) throw Exception('Controller is busy');

    state = const LSSUnauthorized(busy: true);
    try {
      await _fireAuthService.signInWithPhoneNumberWeb(phone);
      state = LSSsmsSent(phone: phone);
    } catch (e) {
      state = LSSUnauthorized(error: e.toString());
    }
  }

  confirmSmsCode(String smsCode) async {
    LoginScreenState currentState = state;
    if (currentState is! LSSsmsSent) throw Exception('Wrong state');
    if (currentState.busy) throw Exception('Controller is busy');

    state = LSSsmsSent(busy: true, phone: currentState.phone);
    try {
      await _fireAuthService.confirmPhoneNumberWeb(smsCode);
      updateState();
    } catch (e) {
      state = LSSsmsSent(error: e.toString(), phone: currentState.phone);
    }
  }
}
