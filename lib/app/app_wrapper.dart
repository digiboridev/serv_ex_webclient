// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_local_variable
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/data/exceptions.dart';
import 'package:serv_expert_webclient/data/models/user/app_user.dart';
import 'package:serv_expert_webclient/data/models/company/company.dart';
import 'package:serv_expert_webclient/global_providers.dart';
import 'package:serv_expert_webclient/app/app_providers.dart';
import 'package:serv_expert_webclient/app/controllers/contributor_controller.dart';
import 'package:serv_expert_webclient/router.gr.dart';

class AppWrapper extends ConsumerWidget {
  const AppWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<AppUser> appUser = ref.watch(currentAppUserStreamProvider);
    AsyncValue<List<Company>> companies = ref.watch(companiesStreamProvider);
    ContributorState contributorState = ref.watch(contributorControllerProvider);

    // If user is not found or deleted, sign out and redirect to auth screen
    ref.listen(currentAppUserStreamProvider, (p, n) {
      if (n.error is UnexistedResource) {
        ref.read(authServiceProvider).signOut();
        context.router.replaceAll([const AuthScreenRoute()]);
      }
    });

    return Scaffold(
      body: SizedBox.expand(
        child: Builder(
          builder: (_) {
            if (appUser is AsyncError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('${appUser.error}'),
                  const SizedBox(
                    height: 8,
                  ),
                  ElevatedButton(
                    onPressed: () => ref.refresh(currentAppUserStreamProvider),
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
                  const SizedBox(
                    height: 8,
                  ),
                  ElevatedButton(
                    onPressed: () => ref.refresh(companiesStreamProvider),
                    child: const Text('retry'),
                  ),
                ],
              );
            }

            if (appUser is AsyncLoading || companies is AsyncLoading) {
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
