// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/data/reposiotories/clients_repository.dart';
import 'package:serv_expert_webclient/main.dart';
import 'package:serv_expert_webclient/services/fireauth.dart';
import 'package:serv_expert_webclient/ui/screens/auth/auth_screen_controller.dart';
import 'package:serv_expert_webclient/ui/screens/auth/auth_screen_state.dart';
import 'package:serv_expert_webclient/ui/screens/auth/subpages/auth.dart';
import 'package:serv_expert_webclient/ui/screens/auth/subpages/client_contacts.dart';
import 'package:serv_expert_webclient/ui/screens/auth/subpages/client_details.dart';
import 'package:serv_expert_webclient/ui/screens/auth/subpages/sms_sent.dart';

final authScreenControllerProvider = StateNotifierProvider.autoDispose<AuthScreenController, AuthScreenState>((ref) {
  FireAuthService fireAuthService = ref.read(fireAuthServiceProvider);
  ClientsRepository clientsRepository = ref.read(clientsRepositoryProvider);

  return AuthScreenController(fireAuthService: fireAuthService, clientsRepository: clientsRepository);
});

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({this.returnUrl, super.key});

  final String? returnUrl;

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
        context.router.replaceNamed(widget.returnUrl ?? '/b');
      }
    });

    return Scaffold(
      body: Stack(
        children: [
          // content(loginState),
          SizedBox.expand(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              switchInCurve: Curves.easeOutExpo,
              switchOutCurve: Curves.easeInExpo,
              transitionBuilder: (child, animation) => SlideTransition(
                position: animation.drive(Tween(begin: const Offset(1, 0), end: const Offset(0, 0))),
                child: child,
              ),
              child: content(loginState),
            ),
          ),
          // Handle busy state
          if (loginState.busy)
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

  Widget content(AuthScreenState loginState) {
    if (loginState is ASSLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (loginState is ASSUpdateError) {
      return ErrorSubpage(
        error: loginState.error,
      );
    }

    if (loginState is ASSUnauthorized) {
      return const AuthSubpage();
    }

    if (loginState is ASSsmsSent) {
      return SmsSentSubpage(phone: loginState.phone);
    }

    if (loginState is ASSClientDetails) {
      return ClientDetailsSubpage(
        phone: loginState.phone,
        email: loginState.email,
        firstName: loginState.firstName,
        lastName: loginState.lastName,
      );
    }

    if (loginState is ASSClientContacts) {
      return const ClientContactsSubpage();
    }

    return const SizedBox();
  }
}

class ErrorSubpage extends ConsumerStatefulWidget {
  const ErrorSubpage({
    Key? key,
    required this.error,
  }) : super(key: key);

  final String error;

  @override
  ConsumerState<ErrorSubpage> createState() => _ErrorSubpageState();
}

class _ErrorSubpageState extends ConsumerState<ErrorSubpage> {
  onRetry() {
    ref.read(authScreenControllerProvider.notifier).updateState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Error',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            widget.error,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          SizedBox(
            width: 200,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                onRetry();
              },
              child: Ink(
                // width: 600,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    'Retry',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
