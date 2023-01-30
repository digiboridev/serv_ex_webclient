import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/core/validators.dart';
import 'package:serv_expert_webclient/ui/screens/auth/auth_screen.dart';

class CompanyRegistrationSubpage extends ConsumerStatefulWidget {
  const CompanyRegistrationSubpage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<CompanyRegistrationSubpage> createState() => _CompanyRegistrationSubpageState();
}

class _CompanyRegistrationSubpageState extends ConsumerState<CompanyRegistrationSubpage> {
  final formKey = GlobalKey<FormState>();

  String publicId = '';
  String companyName = '';
  String companyEmail = '';

  onContinue() {
    bool? valid = formKey.currentState?.validate();
    if (valid == true) {
      formKey.currentState?.save();
      ref.read(authScreenControllerProvider.notifier).submitCompanyRegistration(
            publicId: publicId,
            companyName: companyName,
            companyEmail: companyEmail,
          );
    }
  }

  onSkip() {
    ref.read(authScreenControllerProvider.notifier).skipCompanyRegistration();
  }

  @override
  void initState() {
    super.initState();
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
            'COMPANY REGISTRATION',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          publicIdField(),
          const SizedBox(
            height: 16,
          ),
          nameField(),
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
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            width: 600,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  onSkip();
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
                      'SKIP',
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

  Widget publicIdField() {
    return SizedBox(
      width: 600,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextFormField(
          keyboardType: TextInputType.name,
          maxLength: 20,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter id';
            }

            return null;
          },
          onFieldSubmitted: (value) {
            onContinue();
          },
          onChanged: (value) {
            publicId = value;
          },
          decoration: InputDecoration(
              counter: const SizedBox(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              filled: true,
              hintStyle: TextStyle(color: Colors.grey[800]),
              labelText: "ID",
              fillColor: Colors.white70),
        ),
      ),
    );
  }

  Widget nameField() {
    return SizedBox(
      width: 600,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextFormField(
          keyboardType: TextInputType.name,
          maxLength: 20,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter name';
            }
            if (!AppValidators.isValidName(value)) {
              return 'Please enter correct name';
            }
            return null;
          },
          onFieldSubmitted: (value) {
            onContinue();
          },
          onChanged: (value) {
            companyName = value;
          },
          decoration: InputDecoration(
              counter: const SizedBox(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              filled: true,
              hintStyle: TextStyle(color: Colors.grey[800]),
              labelText: "Company name",
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
            companyEmail = value;
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
}
