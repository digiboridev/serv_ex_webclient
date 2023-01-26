import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/data/exceptions.dart';
import 'package:serv_expert_webclient/data/models/client/client.dart';
import 'package:serv_expert_webclient/data/models/client/client_contact.dart';
import 'package:serv_expert_webclient/data/reposiotories/clients_repository.dart';
import 'package:serv_expert_webclient/services/fireauth.dart';
import 'package:serv_expert_webclient/ui/screens/auth/auth_screen_state.dart';

class AuthScreenController extends StateNotifier<AuthScreenState> {
  AuthScreenController({
    required FireAuthService fireAuthService,
    required ClientsRepository clientsRepository,
  })  : _fireAuthService = fireAuthService,
        _clientsRepository = clientsRepository,
        super(const ASSLoading());

  final FireAuthService _fireAuthService;
  final ClientsRepository _clientsRepository;

  Future updateState() async {
    bool authorized = _fireAuthService.authorized;

    if (!authorized) {
      state = const ASSUnauthorized();
    } else {
      state = const ASSLoading();
      try {
        await _clientsRepository.clientById(id: _fireAuthService.uid!, forceNetwork: true);
        state = const ASSAuthorized();
      } on UnexistedResource {
        state = ASSClientDetails(
          phone: _fireAuthService.phoneNumber,
          email: _fireAuthService.email,
          firstName: _fireAuthService.displayName?.split(' ').first,
          lastName: _fireAuthService.displayName?.split(' ').last,
        );
      } catch (e) {
        state = const ASSUpdateError();
      }
    }
  }

  signInWithPhone({required String phone}) async {
    AuthScreenState currentState = state;
    if (currentState is! ASSUnauthorized) throw Exception('Wrong state');
    if (currentState.busy) throw Exception('Controller is busy');

    state = const ASSUnauthorized(busy: true);
    try {
      await _fireAuthService.signInWithPhoneNumberWeb(phone);
      state = ASSsmsSent(phone: phone);
    } catch (e) {
      state = ASSUnauthorized(error: e.toString());
    }
  }

  confirmSmsCode({required String smsCode}) async {
    AuthScreenState currentState = state;
    if (currentState is! ASSsmsSent) throw Exception('Wrong state');
    if (currentState.busy) throw Exception('Controller is busy');

    state = currentState.copyWith(busy: true, error: '');
    try {
      await _fireAuthService.confirmPhoneNumberWeb(smsCode);
      updateState();
    } catch (e) {
      state = currentState.copyWith(busy: false, error: e.toString());
    }
  }

  submitClientDetails({required String firstName, required String lastName, required String email, required String phone}) async {
    AuthScreenState currentState = state;
    if (currentState is! ASSClientDetails) throw Exception('Wrong state');
    if (currentState.busy) throw Exception('Controller is busy');

    state = currentState.copyWith(busy: true, error: '');

    try {
      Client newClient = Client(id: _fireAuthService.uid!, firstName: firstName, lastName: lastName, email: email, phone: phone);
      await _clientsRepository.setClient(newClient);
      state = const ASSClientContacts();
    } catch (e) {
      state = currentState.copyWith(busy: false, error: e.toString());
    }
  }

  submitClientContacts({required List<ClientContact> contacts}) async {
    AuthScreenState currentState = state;
    if (currentState is! ASSClientContacts) throw Exception('Wrong state');
    if (currentState.busy) throw Exception('Controller is busy');

    state = currentState.copyWith(busy: true, error: '');

    try {
      await _clientsRepository.updateClientContacts(id: _fireAuthService.uid!, contacts: contacts);
      state = const ASSAuthorized();
    } catch (e) {
      state = currentState.copyWith(busy: false, error: e.toString());
    }
  }
}
