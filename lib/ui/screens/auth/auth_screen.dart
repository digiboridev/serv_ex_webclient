// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/data/reposiotories/clients_repository.dart';
import 'package:serv_expert_webclient/data/reposiotories/companies_repository.dart';
import 'package:serv_expert_webclient/main.dart';
import 'package:serv_expert_webclient/services/fireauth.dart';
import 'package:serv_expert_webclient/ui/router.gr.dart';
import 'package:serv_expert_webclient/ui/screens/auth/auth_screen_controller.dart';
import 'package:serv_expert_webclient/ui/screens/auth/auth_screen_state.dart';

final authScreenControllerProvider = StateNotifierProvider.autoDispose<AuthScreenController, AuthScreenState>((ref) {
  FireAuthService fireAuthService = ref.read(fireAuthServiceProvider);
  ClientsRepository clientsRepository = ref.read(clientsRepositoryProvider);
  CompaniesRepository companiesRepository = ref.read(companiesRepositoryProvider);

  return AuthScreenController(fireAuthService: fireAuthService, clientsRepository: clientsRepository, companiesRepository: companiesRepository);
});

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

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
        context.router.markUrlStateForReplace();
        context.router.replaceAll([const App()]);
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SizedBox.expand(
            child: AutoRouter.declarative(
                routes: (_) => [
                      const AsSignIn(),
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
    );
  }
}
