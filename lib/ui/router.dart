// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/main.dart';
import 'package:serv_expert_webclient/ui/app_wrapper.dart';
import 'package:serv_expert_webclient/ui/contrributor_controller.dart';
import 'package:serv_expert_webclient/ui/router.gr.dart';
import 'package:serv_expert_webclient/ui/screens/auth/auth_screen.dart';
import 'package:serv_expert_webclient/ui/screens/auth/subpages/sign_in.dart';
import 'package:serv_expert_webclient/ui/screens/auth/subpages/client_contacts.dart';
import 'package:serv_expert_webclient/ui/screens/auth/subpages/client_details.dart';
import 'package:serv_expert_webclient/ui/screens/auth/subpages/company_registration.dart';
import 'package:serv_expert_webclient/ui/screens/auth/subpages/data_error.dart';
import 'package:serv_expert_webclient/ui/screens/auth/subpages/confirm_phone.dart';
import 'package:serv_expert_webclient/ui/screens/auth/subpages/success.dart';
import 'package:serv_expert_webclient/ui/screens/auth/subpages/company_members.dart';
import 'package:serv_expert_webclient/ui/screens/contributor_select_screen.dart';
import 'package:serv_expert_webclient/ui/screens/home_screen.dart';
import 'package:serv_expert_webclient/ui/screens/profile/profile_screen.dart';
import 'package:serv_expert_webclient/ui/screens/profile/subpages/client_info.dart';
import 'package:serv_expert_webclient/ui/screens/profile/subpages/companies_info.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route,Screen',
  routes: <AutoRoute>[
    AutoRoute(
      path: '/auth',
      page: AuthScreen,
      children: [
        AutoRoute(name: 'asSignIn', path: 'signin', page: AuthSignIn, usesPathAsKey: true),
        AutoRoute(name: 'asConfirmPhone', path: 'confirm_phone', page: AuthConfirmPhone, usesPathAsKey: true),
        AutoRoute(name: 'asClientDetails', path: 'client_details', page: AuthClientDetails, usesPathAsKey: true),
        AutoRoute(name: 'asClientContacts', path: 'client_contacts', page: AuthClientContacts, usesPathAsKey: true),
        AutoRoute(name: 'asCompanyCreate', path: 'company_create', page: AuthCompanyCreate, usesPathAsKey: true),
        AutoRoute(name: 'asCompanyMembers', path: 'company_members', page: AuthCompanyMembers, usesPathAsKey: true),
        AutoRoute(name: 'asDataError', path: 'data_error', page: AuthDataError, usesPathAsKey: true),
        AutoRoute(name: 'asSuccess', path: 'succes', page: AuthSucces, usesPathAsKey: true),
      ],
    ),
    AutoRoute(
      name: 'app',
      path: '/',
      page: AppWrapper,
      guards: [AppGuard],
      children: [
        RedirectRoute(path: '', redirectTo: 'home'),
        AutoRoute(path: 'contributor_select', page: ContributorSelectScreen),
        AutoRoute(path: 'home', page: HomeScreen, guards: [ContributorGuard]),
        AutoRoute(
          path: 'profile',
          page: ProfileScreen,
          guards: [ContributorGuard],
          children: [
            RedirectRoute(path: '', redirectTo: 'client_info'),
            AutoRoute(path: 'client_info', page: ClientInfoPage),
            AutoRoute(path: 'companies_info', page: CompaniesInfoPage),
          ],
        ),
        AutoRoute(path: 'b', page: SB),
      ],
    ),
  ],
)
// extend the generated private router
class $AppRouter {}

class SB extends ConsumerWidget {
  const SB({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ContributorState contributorState = ref.watch(contributorControllerProvider);

    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('V: 0.0.6'),
            Text(context.router.root.stack.toString()),
            Text('Authorized: ${ref.read(fireAuthServiceProvider).authorized}'),
            Text(ref.read(fireAuthServiceProvider).uid.toString()),
            Text(ref.read(fireAuthServiceProvider).email.toString()),
            Text(ref.read(fireAuthServiceProvider).phoneNumber.toString()),
            Text(contributorState.toString()),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () async {
                ref.read(contributorControllerProvider.notifier).clearContributor();
              },
              child: const Text('Unassign contributor'),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () async {
                ref.read(fireAuthServiceProvider).signOut();
                context.router.replaceAll([const AuthScreenRoute()]);
              },
              child: const Text('Sign out'),
            ),
          ],
        ),
      ),
    );
  }
}

class AppGuard extends AutoRouteGuard {
  WidgetRef ref;
  AppGuard({
    required this.ref,
  });

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    bool isUserAuthorized = ref.read(fireAuthServiceProvider).authorized;
    if (isUserAuthorized) {
      resolver.next(true);
    } else {
      resolver.next(false);
      router.replaceAll([const AuthScreenRoute()]);
    }
  }
}

class ContributorGuard extends AutoRouteGuard {
  WidgetRef ref;
  ContributorGuard({
    required this.ref,
  });

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    ContributorState contributorState = ref.read(contributorControllerProvider);
    if (contributorState is CSUnassigned) {
      resolver.next(false);
      router.replace(const ContributorSelectScreenRoute());
    } else {
      resolver.next(true);
    }
  }
}
