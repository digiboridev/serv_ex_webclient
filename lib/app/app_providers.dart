import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/data/exceptions.dart';
import 'package:serv_expert_webclient/data/models/user/app_user.dart';
import 'package:serv_expert_webclient/data/models/company/company.dart';
import 'package:serv_expert_webclient/data/reposiotories/user_repository.dart';
import 'package:serv_expert_webclient/data/reposiotories/companies_repository.dart';
import 'package:serv_expert_webclient/global_providers.dart';
import 'package:serv_expert_webclient/services/auth_service.dart';
import 'package:serv_expert_webclient/app/controllers/contributor_controller.dart';

final currentAppUserStreamProvider = StreamProvider.autoDispose<AppUser>((ref) async* {
  UserRepository userRepository = ref.read(userRepositoryProvider);

  // Just pooling
  // TODO - socket or graphql subscription
  while (true) {
    await Future.delayed(Duration(seconds: 5));
    AppUser appUser = await userRepository.appUser();
    yield appUser;
  }
});

final companiesStreamProvider = StreamProvider.autoDispose<List<Company>>((ref) {
  AuthService authService = ref.read(authServiceProvider);
  CompaniesRepository companiesRepository = ref.read(companiesRepositoryProvider);

  if (!authService.authorized) throw const Unauthorized('You have to be authorized to get this resource');

  String appUserId = authService.userId!;

  return companiesRepository.companiesByMemberIdStream(memberId: appUserId);
});

final contributorControllerProvider = StateNotifierProvider.autoDispose<ContributorController, ContributorState>((ref) {
  return ContributorController(ref: ref);
});
