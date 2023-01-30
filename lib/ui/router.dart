// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/main.dart';
import 'package:serv_expert_webclient/ui/app_wrapper.dart';
import 'package:serv_expert_webclient/ui/router.gr.dart';
import 'package:serv_expert_webclient/ui/screens/auth/auth_screen.dart';
import 'package:serv_expert_webclient/ui/screens/auth/subpages/sign_in.dart';
import 'package:serv_expert_webclient/ui/screens/auth/subpages/client_contacts.dart';
import 'package:serv_expert_webclient/ui/screens/auth/subpages/client_details.dart';
import 'package:serv_expert_webclient/ui/screens/auth/subpages/company_registration.dart';
import 'package:serv_expert_webclient/ui/screens/auth/subpages/data_error.dart';
import 'package:serv_expert_webclient/ui/screens/auth/subpages/confirm_phone.dart';
import 'package:serv_expert_webclient/ui/screens/auth/subpages/success.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      name: 'auth',
      path: '/auth',
      page: AuthScreen,
      children: [
        AutoRoute(name: 'signIn', path: 'signin', page: AuthSignIn, usesPathAsKey: true),
        AutoRoute(name: 'asConfirmPhone', path: 'confirm_phone', page: AuthConfirmPhone, usesPathAsKey: true),
        AutoRoute(name: 'asClientDetails', path: 'client_details', page: AuthClientDetails, usesPathAsKey: true),
        AutoRoute(name: 'asClientContacts', path: 'client_contacts', page: ClientContactsSubpage, usesPathAsKey: true),
        AutoRoute(name: 'asCompanyCreate', path: 'company_create', page: AuthCompanyCreate, usesPathAsKey: true),
        AutoRoute(name: 'asDataError', path: 'data_error', page: AuthDataError, usesPathAsKey: true),
        AutoRoute(name: 'asSuccess', path: 'succes', page: AuthSucces, usesPathAsKey: true),
      ],
      guards: [AuthGuard],
    ),
    AutoRoute(
      name: 'app',
      path: '/',
      page: AppWrapper,
      guards: [AppGuard],
      children: [
        RedirectRoute(path: '', redirectTo: 'a'),
        AutoRoute(path: 'a', page: SA),
        AutoRoute(path: 'b', page: SB),
      ],
    ),
  ],
)
// extend the generated private router
class $AppRouter {}

class SA extends StatelessWidget {
  const SA({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('SA'),
      ),
    );
  }
}

class SB extends ConsumerWidget {
  const SB({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('SB'),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () async {
                ref.read(fireAuthServiceProvider).signOut().then((value) => context.router.navigateNamed('/'));
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
      // resolver.next(false);
      // router.markUrlStateForReplace();
      // router.replaceAll([Auth(returnUrl: router.currentPath)]);
      router.push(Auth(onAuthComplete: () {
        resolver.next(true);
      }));
    }
  }
}

class AuthGuard extends AutoRouteGuard {
  WidgetRef ref;
  AuthGuard({
    required this.ref,
  });

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    resolver.next(true);

    // bool isUserAuthorized = ref.read(fireAuthServiceProvider).authorized;
    // if (isUserAuthorized) {
    //   resolver.next(false);
    // } else {
    //   resolver.next(true);
    // }
  }
}
