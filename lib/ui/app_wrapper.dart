// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/data/exceptions.dart';
import 'package:serv_expert_webclient/data/models/client/client.dart';
import 'package:serv_expert_webclient/data/reposiotories/clients_repository.dart';
import 'package:serv_expert_webclient/main.dart';
import 'package:serv_expert_webclient/services/fireauth.dart';

final currentClientProvider = FutureProvider.autoDispose<Client>((ref) async {
  FireAuthService fireAuthService = ref.read(fireAuthServiceProvider);
  ClientsRepository clientsRepository = ref.read(clientsRepositoryProvider);

  if (!fireAuthService.authorized) throw const Unauthorized('You have to be authorized to get this resource');

  return await clientsRepository.clientById(id: fireAuthService.uid!, forceNetwork: true);
});

class AppWrapper extends StatelessWidget {
  const AppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          AsyncValue<Client> client = ref.watch(currentClientProvider);

          if (client is AsyncLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (client is AsyncData<Client>) {
            print(client.value);
            return child!;
          }

          if (client is AsyncError) {
            if (client.error is Unauthorized) {
              return const Center(
                child: Text('Unauthorized'),
              );
            }
            return Column(
              children: [
                Text('${client.error}'),
                // retry button
                ElevatedButton(
                  onPressed: () {
                    ref.refresh(currentClientProvider);
                  },
                  child: const Text('retry'),
                ),
              ],
            );
          }

          return const SizedBox();
        },
        child: Column(
          children: [
            GestureDetector(
                onTap: () {
                  context.router.replaceNamed('/home');
                },
                child: const Text('Home')),
            const Expanded(child: AutoRouter()),
          ],
        ),
      ),
    );
  }
}
