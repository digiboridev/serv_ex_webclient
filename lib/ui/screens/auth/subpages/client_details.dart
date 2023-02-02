import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/core/validators.dart';
import 'package:serv_expert_webclient/ui/components/fillable_scrollable_wrapper.dart';
import 'package:serv_expert_webclient/ui/screens/auth/auth_screen.dart';

class AuthClientDetails extends ConsumerStatefulWidget {
  const AuthClientDetails({
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
  ConsumerState<AuthClientDetails> createState() => _ClientDetailsSubpageState();
}

class _ClientDetailsSubpageState extends ConsumerState<AuthClientDetails> {
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
      ref.read(authScreenControllerProvider.notifier).submitClientDetails(
            phone: phoneValue,
            firstName: firstNameValue,
            lastName: lastNameValue,
            email: emailValue,
          );
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
              const SizedBox(
                height: 32,
              ),
            ],
          ),
        ),
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
            if (!AppValidators.isValidName(value)) {
              return 'Please enter correct first name';
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
            labelText: 'First name',
            fillColor: Colors.white70,
          ),
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
            if (!AppValidators.isValidName(value)) {
              return 'Please enter correct last name';
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
            labelText: 'Last name',
            fillColor: Colors.white70,
          ),
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
            if (!AppValidators.isValidEmail(value)) {
              return 'Please enter correct email';
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
            labelText: 'Email',
            fillColor: Colors.white70,
          ),
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
            if (!AppValidators.isValidPhone(value)) {
              return 'Please enter correct phone';
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
            labelText: 'Phone',
            fillColor: Colors.white70,
          ),
        ),
      ),
    );
  }
}
