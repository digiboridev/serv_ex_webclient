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
import 'package:serv_expert_webclient/ui/contrributor_controller.dart';
import 'package:serv_expert_webclient/ui/router.gr.dart';

final currentClientStreamProvider = StreamProvider.autoDispose<Client>((ref) {
  FireAuthService fireAuthService = ref.read(fireAuthServiceProvider);
  ClientsRepository clientsRepository = ref.read(clientsRepositoryProvider);

  if (!fireAuthService.authorized) throw const Unauthorized('You have to be authorized to get this resource');
  // throw const Unauthorized('You have to be authorized to get this resource');
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

class AppWrapper extends ConsumerWidget {
  const AppWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<Client> client = ref.watch(currentClientStreamProvider);
    AsyncValue<List<Company>> companies = ref.watch(companiesStreamProvider);
    // ignore: unused_local_variable
    ContributorState contributorState = ref.watch(contributorControllerProvider);

    ref.listen(currentClientStreamProvider, (p, n) {
      if (n.error is UnexistedResource) {
        ref.read(fireAuthServiceProvider).signOut();
        context.router.replaceAll([const AuthScreenRoute()]);
      }
    });

    return Scaffold(
      body: SizedBox.expand(
        child: Builder(
          builder: (_) {
            if (client is AsyncError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('${client.error}'),
                  SizedBox(
                    height: 8,
                  ),
                  ElevatedButton(
                    onPressed: () => ref.refresh(currentClientStreamProvider),
                    child: const Text('retry'),
                  ),
                ],
              );
            }
            if (companies is AsyncError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('${companies.error}'),
                  SizedBox(
                    height: 8,
                  ),
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

            return HeroControllerScope(controller: HeroController(), child: const AutoRouter());
          },
        ),
      ),
    );
  }
}
