import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/core/validators.dart';
import 'package:serv_expert_webclient/ui/components/fillable_scrollable_wrapper.dart';
import 'package:serv_expert_webclient/ui/screens/auth/auth_screen.dart';

class AuthSignIn extends ConsumerStatefulWidget {
  const AuthSignIn({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<AuthSignIn> createState() => _AuthSubpageState();
}

class _AuthSubpageState extends ConsumerState<AuthSignIn> {
  final formKey = GlobalKey<FormState>();
  String phone = '';

  onContinue() {
    bool? valid = formKey.currentState?.validate();
    if (valid == true) {
      ref.read(authScreenControllerProvider.notifier).signInWithPhone(phone: phone);
    }
  }

  onSignInWithGoogle() {
    ref.read(authScreenControllerProvider.notifier).signInWithGoogle();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Form(
        key: formKey,
        child: FillableScrollableWrapper(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 32,
              ),
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
                // height: 60,
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

                      if (!AppValidators.isValidPhone(value)) {
                        return 'Please enter correct phone';
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
                      labelText: 'Phone number',
                      fillColor: Colors.white70,
                    ),
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
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
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
              ),
              GestureDetector(
                onTap: () => onSignInWithGoogle(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.g_mobiledata,
                      size: 64,
                      color: Colors.blue,
                    ),
                    Text(
                      'Sign in with Google',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 32,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
