// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/core/log.dart';
import 'package:serv_expert_webclient/data/reposiotories/clients_repository.dart';
import 'package:serv_expert_webclient/data/reposiotories/companies_repository.dart';
import 'package:serv_expert_webclient/main.dart';
import 'package:serv_expert_webclient/services/fireauth.dart';
import 'package:serv_expert_webclient/ui/router.gr.dart';
import 'package:serv_expert_webclient/ui/screens/auth/auth_screen_controller.dart';
import 'package:serv_expert_webclient/ui/screens/auth/auth_screen_state.dart';
import 'package:serv_expert_webclient/ui/screens/auth/subpages/sign_in.dart';
import 'package:serv_expert_webclient/ui/screens/auth/subpages/client_contacts.dart';
import 'package:serv_expert_webclient/ui/screens/auth/subpages/client_details.dart';
import 'package:serv_expert_webclient/ui/screens/auth/subpages/company_registration.dart';
import 'package:serv_expert_webclient/ui/screens/auth/subpages/data_error.dart';
import 'package:serv_expert_webclient/ui/screens/auth/subpages/confirm_phone.dart';
import 'package:serv_expert_webclient/ui/screens/auth/subpages/success.dart';

final authScreenControllerProvider = StateNotifierProvider.autoDispose<AuthScreenController, AuthScreenState>((ref) {
  FireAuthService fireAuthService = ref.read(fireAuthServiceProvider);
  ClientsRepository clientsRepository = ref.read(clientsRepositoryProvider);
  CompaniesRepository companiesRepository = ref.read(companiesRepositoryProvider);

  return AuthScreenController(fireAuthService: fireAuthService, clientsRepository: clientsRepository, companiesRepository: companiesRepository);
});

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({this.returnUrl, this.onAuthComplete, super.key});

  final String? returnUrl;
  final VoidCallback? onAuthComplete;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(authScreenControllerProvider.notifier).updateState();
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthScreenState loginState = ref.watch(authScreenControllerProvider);

    ref.listen<AuthScreenState>(authScreenControllerProvider, (p, n) {
      // Handle errors
      if (n.error.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(n.error),
            action: SnackBarAction(
              label: 'Dismiss',
              onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
            ),
          ),
        );
      }
      // Handle auth complete
      if (n is ASSAuthorized) {
        widget.onAuthComplete?.call();
      }
    });

    return WillPopScope(
      onWillPop: () async {
        log('object');
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            // SizedBox.expand(
            //   child: AnimatedSwitcher(
            //     duration: const Duration(milliseconds: 300),
            //     switchInCurve: Curves.easeOutExpo,
            //     switchOutCurve: Curves.easeInExpo,
            //     transitionBuilder: (child, animation) => SlideTransition(
            //       position: animation.drive(Tween(begin: const Offset(1, 0), end: const Offset(0, 0))),
            //       child: child,
            //     ),
            //     child: content(loginState),
            //   ),
            // ),
            SizedBox.expand(
              child: AutoRouter.declarative(
                  onPopRoute: (route, results) {
                    log('asdasd');
                  },
                  routes: (_) => [
                        const SignIn(),
                        if (loginState is ASSsmsSent) AsConfirmPhone(phone: loginState.phone),
                        if (loginState is ASSClientDetails)
                          AsClientDetails(
                            phone: loginState.phone,
                            email: loginState.email,
                            firstName: loginState.firstName,
                            lastName: loginState.lastName,
                          ),
                        if (loginState is ASSClientContacts) const AsClientContacts(),
                        if (loginState is ASSCompanyCreate) const AsCompanyCreate(),
                        if (loginState is ASSDataError) AsDataError(error: loginState.error),
                        if (loginState is ASSAuthorized) const AsSuccess(),
                      ]),
            ),
            // Handle busy state
            if (loginState.busy || loginState is ASSLoading)
              AbsorbPointer(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget content(AuthScreenState loginState) {
    if (loginState is ASSAuthorized) {
      return const AuthSucces();
    }
    if (loginState is ASSDataError) {
      return AuthDataError(
        error: loginState.error,
      );
    }

    if (loginState is ASSUnauthorized) {
      return const AuthSignIn();
    }

    if (loginState is ASSsmsSent) {
      return AuthConfirmPhone(phone: loginState.phone);
    }

    if (loginState is ASSClientDetails) {
      return AuthClientDetails(
        phone: loginState.phone,
        email: loginState.email,
        firstName: loginState.firstName,
        lastName: loginState.lastName,
      );
    }

    if (loginState is ASSClientContacts) {
      return const ClientContactsSubpage();
    }

    if (loginState is ASSCompanyCreate) {
      return const AuthCompanyCreate();
    }

    return const SizedBox();
  }
}
