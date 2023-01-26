// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:serv_expert_webclient/data/reposiotories/clients_repository.dart';
import 'package:serv_expert_webclient/services/fireauth.dart';
import 'package:serv_expert_webclient/ui/screens/auth/login_screen_controller.dart';
import 'package:serv_expert_webclient/ui/screens/auth/login_screen_state.dart';

final loginScreenControllerProvider = StateNotifierProvider.autoDispose<LoginScreenController, LoginScreenState>((ref) {
  FireAuthService fireAuthService = ref.read(fireAuthServiceProvider);
  ClientsRepository clientsRepository = ref.read(clientsRepositoryProvider);

  return LoginScreenController(fireAuthService: fireAuthService, clientsRepository: clientsRepository);
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
      ref.read(loginScreenControllerProvider.notifier).updateState();
    });
  }

  @override
  Widget build(BuildContext context) {
    LoginScreenState loginState = ref.watch(loginScreenControllerProvider);

    ref.listen<LoginScreenState>(loginScreenControllerProvider, (p, n) {
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

  Widget content(LoginScreenState loginState) {
    return SmsSentSubpage(phone: '123S');

    if (loginState is LSSLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (loginState is LSSUpdateError) {
      return ErrorSubpage(
        error: loginState.error,
      );
    }

    if (loginState is LSSUnauthorized) {
      return const AuthSubpage();
    }

    if (loginState is LSSsmsSent) {
      return SmsSentSubpage(phone: loginState.phone);
    }

    if (loginState is LSSClientDetails) {
      return ClientDetailsSubpage(
        phone: loginState.phone,
        email: loginState.email,
        firstName: loginState.firstName,
        lastName: loginState.lastName,
      );
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
    ref.read(loginScreenControllerProvider.notifier).updateState();
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

class AuthSubpage extends ConsumerStatefulWidget {
  const AuthSubpage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<AuthSubpage> createState() => _AuthSubpageState();
}

class _AuthSubpageState extends ConsumerState<AuthSubpage> {
  final formKey = GlobalKey<FormState>();
  String phone = '';

  onContinue() {
    bool? valid = formKey.currentState?.validate();
    if (valid == true) {
      ref.read(loginScreenControllerProvider.notifier).signInWithPhone(phone);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
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
                maxLength: 20,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter phone';
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
                    counter: const SizedBox(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    labelText: "Phone number",
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

class SmsSentSubpage extends ConsumerStatefulWidget {
  const SmsSentSubpage({
    Key? key,
    required this.phone,
  }) : super(key: key);

  final String phone;

  @override
  ConsumerState<SmsSentSubpage> createState() => _SmsSentSubpageState();
}

class _SmsSentSubpageState extends ConsumerState<SmsSentSubpage> {
  final formKey = GlobalKey<FormState>();
  String smsCode = '';

  onContinue() {
    bool? valid = formKey.currentState?.validate();
    if (valid == true) {
      ref.read(loginScreenControllerProvider.notifier).confirmSmsCode(smsCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
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
                keyboardType: TextInputType.number,
                maxLength: 6,
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    counter: const SizedBox(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    labelText: "sms code",
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

class ClientDetailsSubpage extends ConsumerStatefulWidget {
  const ClientDetailsSubpage({
    Key? key,
    this.phone,
    this.firstName,
    this.lastName,
    this.email,
  }) : super(key: key);

  final String? phone;
  final String? firstName;
  final String? lastName;
  final String? email;

  @override
  ConsumerState<ClientDetailsSubpage> createState() => _ClientDetailsSubpageState();
}

class _ClientDetailsSubpageState extends ConsumerState<ClientDetailsSubpage> {
  final formKey = GlobalKey<FormState>();

  String phoneValue = '';
  String firstNameValue = '';
  String lastNameValue = '';
  String emailValue = '';

  // If value verified, u cant edit it
  bool isPhoneVerified = false;
  bool isEmailVerified = false;

  onContinue() {
    bool? valid = formKey.currentState?.validate();
    if (valid == true) {
      // ref.read(loginScreenControllerProvider.notifier).confirmSmsCode(smsCode);
    }
  }

  @override
  void initState() {
    super.initState();
    initValues();
  }

  initValues() {
    if (widget.phone != null) {
      phoneValue = widget.phone!;
      isPhoneVerified = true;
    }
    if (widget.email != null) {
      emailValue = widget.email!;
      isEmailVerified = true;
    }

    firstNameValue = widget.firstName ?? '';
    lastNameValue = widget.lastName ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'CLIENT DETAILS',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          firstnameField(),
          const SizedBox(
            height: 16,
          ),
          lastnameField(),
          const SizedBox(
            height: 16,
          ),
          phoneField(),
          const SizedBox(
            height: 16,
          ),
          emailField(),
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

  Widget firstnameField() {
    return SizedBox(
      width: 600,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextFormField(
          initialValue: firstNameValue,
          keyboardType: TextInputType.name,
          maxLength: 20,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter first name';
            }
            return null;
          },
          onFieldSubmitted: (value) {
            onContinue();
          },
          onChanged: (value) {
            firstNameValue = value;
          },
          decoration: InputDecoration(
              counter: const SizedBox(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              filled: true,
              hintStyle: TextStyle(color: Colors.grey[800]),
              labelText: "First name",
              fillColor: Colors.white70),
        ),
      ),
    );
  }

  Widget lastnameField() {
    return SizedBox(
      width: 600,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextFormField(
          initialValue: lastNameValue,
          keyboardType: TextInputType.name,
          maxLength: 20,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter last name';
            }
            return null;
          },
          onFieldSubmitted: (value) {
            onContinue();
          },
          onChanged: (value) {
            lastNameValue = value;
          },
          decoration: InputDecoration(
              counter: const SizedBox(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              filled: true,
              hintStyle: TextStyle(color: Colors.grey[800]),
              labelText: "Last name",
              fillColor: Colors.white70),
        ),
      ),
    );
  }

  Widget emailField() {
    return SizedBox(
      width: 600,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextFormField(
          initialValue: emailValue,
          enabled: isEmailVerified ? false : true,
          keyboardType: TextInputType.emailAddress,
          maxLength: 20,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter email';
            }
            return null;
          },
          onFieldSubmitted: (value) {
            onContinue();
          },
          onChanged: (value) {
            emailValue = value;
          },
          decoration: InputDecoration(
              counter: const SizedBox(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              filled: true,
              hintStyle: TextStyle(color: Colors.grey[800]),
              labelText: "Email",
              fillColor: Colors.white70),
        ),
      ),
    );
  }

  Widget phoneField() {
    return SizedBox(
      width: 600,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextFormField(
          initialValue: phoneValue,
          enabled: isPhoneVerified ? false : true,
          keyboardType: TextInputType.phone,
          maxLength: 20,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter phone';
            }
            return null;
          },
          onFieldSubmitted: (value) {
            onContinue();
          },
          onChanged: (value) {
            phoneValue = value;
          },
          decoration: InputDecoration(
              counter: const SizedBox(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              filled: true,
              hintStyle: TextStyle(color: Colors.grey[800]),
              labelText: "Phone",
              fillColor: Colors.white70),
        ),
      ),
    );
  }
}
