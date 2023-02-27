import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/core/text_styles.dart';
import 'package:serv_expert_webclient/core/validators.dart';
import 'package:serv_expert_webclient/widgets/fillable_scrollable_wrapper.dart';
import 'package:serv_expert_webclient/auth/auth_screen.dart';
import 'package:serv_expert_webclient/widgets/layouter.dart';
import 'package:serv_expert_webclient/widgets/min_spacer.dart';
import 'package:serv_expert_webclient/widgets/regular_button.dart';

class AuthAppUserDetails extends ConsumerStatefulWidget {
  const AuthAppUserDetails({
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
  ConsumerState<AuthAppUserDetails> createState() => _AppUserDetailsSubpageState();
}

class _AppUserDetailsSubpageState extends ConsumerState<AuthAppUserDetails> {
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
      ref.read(authScreenControllerProvider.notifier).submitAppUserDetails(
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
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Container(
        color: Colors.white,
        child: Form(
          key: formKey,
          child: Layouter(mobileLayout: mobileBody, tabletLayout: tabletBody),
        ),
      ),
    );
  }

  Widget get mobileBody {
    return FillableScrollableWrapper(
      child: Column(
        children: [
          const MinSpacer(
            minHeight: 32,
            flex: 2,
          ),
          const Text('USER DETAILS', style: AppTextStyles.headline),
          const SizedBox(
            height: 86,
          ),
          SizedBox(
            width: 345,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: firstnameField(textStyle: AppTextStyles.formText),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            width: 345,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: lastnameField(textStyle: AppTextStyles.formText),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            width: 345,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: phoneField(textStyle: AppTextStyles.formText),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            width: 345,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: emailField(textStyle: AppTextStyles.formText),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          SizedBox(
            width: 345,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: RegularButton(
                text: 'CONTINUE',
                textStyle: AppTextStyles.btnText,
                onTap: onContinue,
              ),
            ),
          ),
          const MinSpacer(
            minHeight: 32,
            flex: 1,
          ),
        ],
      ),
    );
  }

  Widget get tabletBody {
    return FillableScrollableWrapper(
      child: Column(
        children: [
          const MinSpacer(
            minHeight: 32,
          ),
          const Text('USER DETAILS', style: AppTextStyles.headlineTablet),
          const SizedBox(
            height: 72,
          ),
          SizedBox(width: 546, child: firstnameField(textStyle: AppTextStyles.formTextTablet)),
          const SizedBox(
            height: 16,
          ),
          SizedBox(width: 546, child: lastnameField(textStyle: AppTextStyles.formTextTablet)),
          const SizedBox(
            height: 16,
          ),
          SizedBox(width: 546, child: phoneField(textStyle: AppTextStyles.formTextTablet)),
          const SizedBox(
            height: 16,
          ),
          SizedBox(width: 546, child: emailField(textStyle: AppTextStyles.formTextTablet)),
          const SizedBox(
            height: 32,
          ),
          SizedBox(
            width: 546,
            child: RegularButton(
              text: 'CONTINUE',
              textStyle: AppTextStyles.btnTextTablet,
              onTap: onContinue,
            ),
          ),
          const MinSpacer(
            minHeight: 32,
          ),
        ],
      ),
    );
  }

  Widget firstnameField({required TextStyle textStyle}) {
    return TextFormField(
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
        setState(() {
          firstNameValue = value;
        });
      },
      style: textStyle,
      decoration: InputDecoration(
        counter: const SizedBox(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        labelText: 'First name',
        fillColor: Colors.white70,
      ),
    );
  }

  Widget lastnameField({required TextStyle textStyle}) {
    return TextFormField(
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
        setState(() {
          lastNameValue = value;
        });
      },
      style: textStyle,
      decoration: InputDecoration(
        counter: const SizedBox(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        labelText: 'Last name',
        fillColor: Colors.white70,
      ),
    );
  }

  Widget emailField({required TextStyle textStyle}) {
    return TextFormField(
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
        setState(() {
          emailValue = value;
        });
      },
      style: textStyle,
      decoration: InputDecoration(
        counter: const SizedBox(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        labelText: 'Email',
        fillColor: Colors.white70,
      ),
    );
  }

  Widget phoneField({required TextStyle textStyle}) {
    return TextFormField(
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
        setState(() {
          phoneValue = value;
        });
      },
      style: textStyle,
      decoration: InputDecoration(
        counter: const SizedBox(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        labelText: 'Phone',
        fillColor: Colors.white70,
      ),
    );
  }
}
