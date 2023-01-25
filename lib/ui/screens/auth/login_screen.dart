import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/services/fireauth.dart';
import 'package:serv_expert_webclient/ui/screens/auth/login_screen_controller.dart';
import 'package:serv_expert_webclient/ui/screens/auth/login_screen_state.dart';

final loginScreenController = StateNotifierProvider.autoDispose<LoginScreenController, LoginScreenState>((ref) {
  FireAuthService fireAuthService = ref.read(fireAuthServiceProvider);
  return LoginScreenController(fireAuthService: fireAuthService);
});

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(loginScreenController.notifier).updateState();
    });
  }

  @override
  Widget build(BuildContext context) {
    LoginScreenState loginState = ref.watch(loginScreenController);

    ref.listen<LoginScreenState>(loginScreenController, (p, n) {
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
      if (n is LSSAuthorized) {
        context.router.replaceNamed('/home2/b');
      }
    });

    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              switchInCurve: Curves.easeIn,
              switchOutCurve: Curves.easeOut,
              transitionBuilder: (child, animation) => SlideTransition(
                position: animation.drive(Tween(begin: const Offset(1, 0), end: Offset.zero)),
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

  Widget content(LoginScreenState loginState) {
    if (loginState is LSSUnauthorized) {
      return const AuthStage();
    }

    if (loginState is LSSsmsSent) {
      return const SmsSentStage();
    }

    return const CircularProgressIndicator();
  }
}

class AuthStage extends ConsumerStatefulWidget {
  const AuthStage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<AuthStage> createState() => _AuthStageState();
}

class _AuthStageState extends ConsumerState<AuthStage> {
  final formKey = GlobalKey<FormState>();
  String phone = '';

  onContinue() {
    bool? valid = formKey.currentState?.validate();
    if (valid == true) {
      ref.read(loginScreenController.notifier).signInWithPhone(phone);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'LOG IN',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          SizedBox(
            width: 600,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some numbers';
                  }
                  return null;
                },
                onFieldSubmitted: (value) {
                  onContinue();
                },
                onChanged: (value) {
                  phone = value;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    hintText: "Phone number",
                    fillColor: Colors.white70),
              ),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          SizedBox(
            width: 600,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  onContinue();
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
                      'CONTINUE',
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
          ),
        ],
      ),
    );
  }
}

class SmsSentStage extends ConsumerStatefulWidget {
  const SmsSentStage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<SmsSentStage> createState() => _SmsSentStageState();
}

class _SmsSentStageState extends ConsumerState<SmsSentStage> {
  final formKey = GlobalKey<FormState>();
  String smsCode = '';

  onContinue() {
    bool? valid = formKey.currentState?.validate();
    if (valid == true) {
      ref.read(loginScreenController.notifier).confirmSmsCode(smsCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'SMS',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          SizedBox(
            width: 600,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some numbers';
                  }
                  return null;
                },
                onFieldSubmitted: (value) {
                  onContinue();
                },
                onChanged: (value) {
                  smsCode = value;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    hintText: "sms code",
                    fillColor: Colors.white70),
              ),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          SizedBox(
            width: 600,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  onContinue();
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
                      'CONTINUE',
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
          ),
        ],
      ),
    );
  }
}
