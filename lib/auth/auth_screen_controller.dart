import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/core/log.dart';
import 'package:serv_expert_webclient/data/dto/repair_service/new_contact.dart';
import 'package:serv_expert_webclient/data/models/company/company.dart';
import 'package:serv_expert_webclient/data/reposiotories/user_repository.dart';
import 'package:serv_expert_webclient/data/reposiotories/companies_repository.dart';
import 'package:serv_expert_webclient/services/auth_service.dart';
import 'package:serv_expert_webclient/auth/auth_screen_state.dart';

class AuthScreenController extends StateNotifier<AuthScreenState> {
  AuthScreenController({
    required AuthService authService,
    required UserRepository userRepository,
    required CompaniesRepository companiesRepository,
  })  : _authService = authService,
        _userRepository = userRepository,
        _companiesRepository = companiesRepository,
        super(const ASSLoading());

  final AuthService _authService;
  final UserRepository _userRepository;
  final CompaniesRepository _companiesRepository;

  Future updateState() async {
    log('ASC updateState begin, current state: $state');

    bool authorized = _authService.authorized;

    log('Authorized: $authorized');

    if (!authorized) {
      state = const ASSUnauthorized();
    } else {
      state = ASSAuthorized();
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
      await _authService.signInWithPhoneNumber(phone);
      log('signInWithPhone($phone) sent sms');
      state = ASSsmsSent(phone: phone);
    } catch (e) {
      log(e);
      state = ASSUnauthorized(error: e.toString());
    }
  }

  signInWithGoogle({required String code}) async {
    AuthScreenState currentState = state;
    if (currentState is! ASSUnauthorized) throw Exception('Wrong state');
    if (currentState.busy) throw Exception('Controller is busy');

    log('signInWithGoogle($code)');

    state = const ASSUnauthorized(busy: true);
    try {
      String? result = await _authService.signInWithGoogle(code: code);
      log('signInWithGoogle($code) result: $result');

      if (result == 'authorized') {
        state = const ASSAuthorized();
      }
      if (result == 'registration_required') {
        state = ASSAppUserDetails(phone: null, firstName: null, lastName: null, email: null);
      }
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
      String? result = await _authService.confirmPhoneNumber(smsCode);
      log('confirmSmsCode($smsCode) confirmed');

      if (result == 'authorized') {
        state = const ASSAuthorized();
      }
      if (result == 'registration_required') {
        state = ASSAppUserDetails(phone: currentState.phone, firstName: null, lastName: null, email: null);
      }
    } catch (e) {
      log(e);
      state = currentState.copyWith(busy: false, error: e.toString());
    }
  }

  submitAppUserDetails({required String firstName, required String lastName, required String email, required String phone}) async {
    AuthScreenState currentState = state;
    if (currentState is! ASSAppUserDetails) throw Exception('Wrong state');
    if (currentState.busy) throw Exception('Controller is busy');

    log('submitAppUserDetails($firstName, $lastName, $email, $phone)');

    state = currentState.copyWith(busy: true, error: '');

    try {
      String? result = await _authService.submitRegistrationData(phone: phone, firstName: firstName, lastName: lastName, email: email);
      log('submitAppUserDetails($firstName, $lastName, $email, $phone) submitted');

      if (result == 'authorized') {
        state = const ASSAppUserContacts();
      }
    } catch (e) {
      log(e);
      state = currentState.copyWith(busy: false, error: e.toString());
    }
  }

  submitAppUserContacts({required List<NewContactDTO> contacts}) async {
    AuthScreenState currentState = state;
    if (currentState is! ASSAppUserContacts) throw Exception('Wrong state');
    if (currentState.busy) throw Exception('Controller is busy');

    log('submitAppUserContacts($contacts)');

    state = currentState.copyWith(busy: true, error: '');

    try {
      if (contacts.isNotEmpty) {
        await _userRepository.updateUserContacts(contacts: contacts);
        log('submitAppUserContacts($contacts) submitted');
      }
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
      Company company = await _companiesRepository.createCompany(publicId: publicId, name: companyName, email: companyEmail);
      log('submitCompanyCreate($publicId, $companyName, $companyEmail) submitted');
      state = ASSCompanyMembers(companyId: company.id, membersIds: []);
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
