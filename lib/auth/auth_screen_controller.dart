import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/core/log.dart';
import 'package:serv_expert_webclient/data/exceptions.dart';
import 'package:serv_expert_webclient/data/models/client/client.dart';
import 'package:serv_expert_webclient/data/models/client/client_contact.dart';
import 'package:serv_expert_webclient/data/models/company/company.dart';
import 'package:serv_expert_webclient/data/reposiotories/clients_repository.dart';
import 'package:serv_expert_webclient/data/reposiotories/companies_repository.dart';
import 'package:serv_expert_webclient/services/auth_service.dart';
import 'package:serv_expert_webclient/auth/auth_screen_state.dart';

class AuthScreenController extends StateNotifier<AuthScreenState> {
  AuthScreenController({
    required AuthService authService,
    required ClientsRepository clientsRepository,
    required CompaniesRepository companiesRepository,
  })  : _authService = authService,
        _clientsRepository = clientsRepository,
        _companiesRepository = companiesRepository,
        super(const ASSLoading());

  final AuthService _authService;
  final ClientsRepository _clientsRepository;
  final CompaniesRepository _companiesRepository;

  Future updateState() async {
    // state = ASSsmsSent(phone: '123123123');
    // state = ASSClientDetails(phone: '', firstName: '', lastName: '', email: '');
    // state = ASSClientContacts();
    // state = ASSCompanyCreate();
    // state = ASSCompanyMembers(membersIds: [], companyId: 'companyId');
    // return;
    log('ASC updateState begin, current state: $state');

    bool authorized = _authService.authorized;

    log('Authorized: $authorized');

    if (!authorized) {
      state = const ASSUnauthorized();
    } else {
      try {
        await _clientsRepository.clientById(id: _authService.uid!, forceNetwork: true);
        state = const ASSAuthorized();
      } on UnexistedResource {
        state = ASSClientDetails(
          phone: _authService.phoneNumber,
          email: _authService.email,
          firstName: _authService.displayName?.split(' ').first,
          lastName: _authService.displayName?.split(' ').last,
        );
      } catch (e) {
        log(e);
        state = const ASSDataError();
      }
    }

    log('ASC updateState end, current state: $state');
  }

  signInWithPhone({required String phone}) async {
    AuthScreenState currentState = state;
    if (currentState is! ASSUnauthorized) throw Exception('Wrong state');
    if (currentState.busy) throw Exception('Controller is busy');

    log('signInWithPhone($phone)');

    state = const ASSUnauthorized(busy: true);
    try {
      await _authService.signInWithPhoneNumberWeb(phone);
      log('signInWithPhone($phone) sent sms');

      state = ASSsmsSent(phone: phone);
    } catch (e) {
      log(e);
      state = ASSUnauthorized(error: e.toString());
    }
  }

  signInWithGoogle() async {
    AuthScreenState currentState = state;
    if (currentState is! ASSUnauthorized) throw Exception('Wrong state');
    if (currentState.busy) throw Exception('Controller is busy');

    log('signInWithGoogle()');

    state = const ASSUnauthorized(busy: true);
    try {
      await _authService.signInWithGoogle();
      log('signInWithGoogle() signed in');
      await updateState();
    } catch (e) {
      log(e);
      state = ASSUnauthorized(error: e.toString());
    }
  }

  confirmSmsCode({required String smsCode}) async {
    AuthScreenState currentState = state;
    if (currentState is! ASSsmsSent) throw Exception('Wrong state');
    if (currentState.busy) throw Exception('Controller is busy');

    log('confirmSmsCode($smsCode)');

    state = currentState.copyWith(busy: true, error: '');
    try {
      await _authService.confirmPhoneNumberWeb(smsCode);
      log('confirmSmsCode($smsCode) confirmed');

      await updateState();
    } catch (e) {
      log(e);
      state = currentState.copyWith(busy: false, error: e.toString());
    }
  }

  submitClientDetails({required String firstName, required String lastName, required String email, required String phone}) async {
    AuthScreenState currentState = state;
    if (currentState is! ASSClientDetails) throw Exception('Wrong state');
    if (currentState.busy) throw Exception('Controller is busy');

    log('submitClientDetails($firstName, $lastName, $email, $phone)');

    state = currentState.copyWith(busy: true, error: '');

    try {
      Client newClient = Client(id: _authService.uid!, firstName: firstName, lastName: lastName, email: email, phone: phone);
      await _clientsRepository.setClient(newClient);
      log('submitClientDetails($firstName, $lastName, $email, $phone) submitted');

      state = const ASSClientContacts();
    } catch (e) {
      log(e);
      state = currentState.copyWith(busy: false, error: e.toString());
    }
  }

  submitClientContacts({required List<ClientContact> contacts}) async {
    AuthScreenState currentState = state;
    if (currentState is! ASSClientContacts) throw Exception('Wrong state');
    if (currentState.busy) throw Exception('Controller is busy');

    log('submitClientContacts($contacts)');

    state = currentState.copyWith(busy: true, error: '');

    try {
      await _clientsRepository.updateClientContacts(id: _authService.uid!, contacts: contacts);
      log('submitClientContacts($contacts) submitted');

      state = const ASSCompanyCreate();
    } catch (e) {
      log(e);
      state = currentState.copyWith(busy: false, error: e.toString());
    }
  }

  submitCompanyCreate({required String publicId, required String companyName, required String companyEmail}) async {
    AuthScreenState currentState = state;
    if (currentState is! ASSCompanyCreate) throw Exception('Wrong state');
    if (currentState.busy) throw Exception('Controller is busy');

    log('submitCompanyCreate($publicId, $companyName, $companyEmail)');

    state = currentState.copyWith(busy: true, error: '');

    try {
      Company company =
          await _companiesRepository.createCompany(publicId: publicId, companyName: companyName, companyEmail: companyEmail, memberId: _authService.uid!);
      log('submitCompanyCreate($publicId, $companyName, $companyEmail) submitted');
      state = ASSCompanyMembers(companyId: company.id, membersIds: company.membersIds);
    } catch (e) {
      log(e);
      state = currentState.copyWith(busy: false, error: e.toString());
    }
  }

  skipCompanyCreate() async {
    AuthScreenState currentState = state;
    if (currentState is! ASSCompanyCreate) throw Exception('Wrong state');
    if (currentState.busy) throw Exception('Controller is busy');

    log('skipCompanyRegistration()');
    state = const ASSAuthorized();
  }

  submitCompanyMembersIds({required List<String> membersIds}) async {
    AuthScreenState currentState = state;
    if (currentState is! ASSCompanyMembers) throw Exception('Wrong state');
    if (currentState.busy) throw Exception('Controller is busy');

    log('submitCompanyMembersIds($membersIds)');

    state = currentState.copyWith(busy: true, error: '');

    try {
      await _companiesRepository.updateCompanyMembers(companyId: currentState.companyId, membersIds: membersIds);
      log('submitCompanyMembersIds($membersIds) submitted');
      state = const ASSAuthorized();
    } catch (e) {
      log(e);
      state = currentState.copyWith(busy: false, error: e.toString());
    }
  }
}
