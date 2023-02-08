import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/data/exceptions.dart';
import 'package:serv_expert_webclient/data/models/client/client.dart';
import 'package:serv_expert_webclient/data/models/company/company.dart';
import 'package:serv_expert_webclient/data/reposiotories/clients_repository.dart';
import 'package:serv_expert_webclient/data/reposiotories/companies_repository.dart';
import 'package:serv_expert_webclient/main.dart';
import 'package:serv_expert_webclient/services/fireauth.dart';
import 'package:serv_expert_webclient/ui/contributor_controller.dart';

final currentClientStreamProvider = StreamProvider.autoDispose<Client>((ref) {
  FireAuthService fireAuthService = ref.read(fireAuthServiceProvider);
  ClientsRepository clientsRepository = ref.read(clientsRepositoryProvider);

  if (!fireAuthService.authorized) throw const Unauthorized('You have to be authorized to get this resource');

  String clientId = fireAuthService.uid!;

  return clientsRepository.clientByIdStream(id: clientId);
});

final companiesStreamProvider = StreamProvider.autoDispose<List<Company>>((ref) {
  FireAuthService fireAuthService = ref.read(fireAuthServiceProvider);
  CompaniesRepository companiesRepository = ref.read(companiesRepositoryProvider);

  if (!fireAuthService.authorized) throw const Unauthorized('You have to be authorized to get this resource');

  String clientId = fireAuthService.uid!;

  return companiesRepository.companiesByMemberIdStream(memberId: clientId);
});

final contributorControllerProvider = StateNotifierProvider.autoDispose<ContributorController, ContributorState>((ref) {
  return ContributorController(ref: ref);
});
