// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/data/exceptions.dart';
import 'package:serv_expert_webclient/data/models/client/client.dart';
import 'package:serv_expert_webclient/data/models/company/company.dart';
import 'package:serv_expert_webclient/data/reposiotories/clients_repository.dart';
import 'package:serv_expert_webclient/data/reposiotories/companies_repository.dart';
import 'package:serv_expert_webclient/main.dart';
import 'package:serv_expert_webclient/services/fireauth.dart';

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

abstract class ContributorState {}

class CSUnassigned extends ContributorState {}

class CSAssignedAsCompany extends ContributorState {
  final Company company;
  CSAssignedAsCompany(this.company);
}

class CSAssignedAsClient extends ContributorState {
  final Client client;
  CSAssignedAsClient(this.client);
}

final contributorProvider = StateProvider.autoDispose<ContributorState>((ref) {
  return CSUnassigned();
});

class AppWrapper extends ConsumerWidget {
  const AppWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<Client> client = ref.watch(currentClientStreamProvider);
    AsyncValue<List<Company>> companies = ref.watch(companiesStreamProvider);
    // ignore: unused_local_variable
    ContributorState contributorState = ref.watch(contributorProvider);

    if (client is AsyncError) {
      return Column(
        children: [
          Text('${client.error}'),
          ElevatedButton(
            onPressed: () => ref.refresh(currentClientStreamProvider),
            child: const Text('retry'),
          ),
        ],
      );
    }
    if (companies is AsyncError) {
      return Column(
        children: [
          Text('${companies.error}'),
          ElevatedButton(
            onPressed: () => ref.refresh(companiesStreamProvider),
            child: const Text('retry'),
          ),
        ],
      );
    }

    if (client is AsyncLoading || companies is AsyncLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return const AutoRouter();
  }
}
