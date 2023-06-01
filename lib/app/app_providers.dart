import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/data/models/user/app_user.dart';
import 'package:serv_expert_webclient/data/models/company/company.dart';
import 'package:serv_expert_webclient/data/reposiotories/user_repository.dart';
import 'package:serv_expert_webclient/data/reposiotories/companies_repository.dart';
import 'package:serv_expert_webclient/global_providers.dart';
import 'package:serv_expert_webclient/app/controllers/contributor_controller.dart';

final currentAppUserStreamProvider = StreamProvider.autoDispose<AppUser>((ref) async* {
  UserRepository userRepository = ref.read(userRepositoryProvider);

  // Just pooling
  // TODO - socket or graphql subscription
  while (true) {
    AppUser appUser = await userRepository.me();
    yield appUser;
    await Future.delayed(Duration(seconds: 5));
  }
});

final companiesStreamProvider = StreamProvider.autoDispose<List<Company>>((ref) async* {
  CompaniesRepository companiesRepository = ref.read(companiesRepositoryProvider);

  // Just pooling
  // TODO - socket or graphql subscription
  while (true) {
    List<Company> companies = await companiesRepository.userCompanies();
    yield companies;
    await Future.delayed(Duration(seconds: 5));
  }
});

final contributorControllerProvider = StateNotifierProvider.autoDispose<ContributorController, ContributorState>((ref) {
  return ContributorController(ref: ref);
});
