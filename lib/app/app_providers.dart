import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/data/exceptions.dart';
import 'package:serv_expert_webclient/data/models/client/client.dart';
import 'package:serv_expert_webclient/data/models/company/company.dart';
import 'package:serv_expert_webclient/data/reposiotories/clients_repository.dart';
import 'package:serv_expert_webclient/data/reposiotories/companies_repository.dart';
import 'package:serv_expert_webclient/global_providers.dart';
import 'package:serv_expert_webclient/services/auth_service.dart';
import 'package:serv_expert_webclient/app/contributor_controller.dart';

final currentClientStreamProvider = StreamProvider.autoDispose<Client>((ref) {
  AuthService authService = ref.read(authServiceProvider);
  ClientsRepository clientsRepository = ref.read(clientsRepositoryProvider);

  if (!authService.authorized) throw const Unauthorized('You have to be authorized to get this resource');

  String clientId = authService.uid!;

  return clientsRepository.clientByIdStream(id: clientId);
});

final companiesStreamProvider = StreamProvider.autoDispose<List<Company>>((ref) {
  AuthService authService = ref.read(authServiceProvider);
  CompaniesRepository companiesRepository = ref.read(companiesRepositoryProvider);

  if (!authService.authorized) throw const Unauthorized('You have to be authorized to get this resource');

  String clientId = authService.uid!;

  return companiesRepository.companiesByMemberIdStream(memberId: clientId);
});

final contributorControllerProvider = StateNotifierProvider.autoDispose<ContributorController, ContributorState>((ref) {
  return ContributorController(ref: ref);
});
