import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/core/app_colors.dart';
import 'package:serv_expert_webclient/utils/ui_utils.dart';
import 'package:serv_expert_webclient/utils/validators.dart';
import 'package:serv_expert_webclient/widgets/fillable_scrollable_wrapper.dart';
import 'package:serv_expert_webclient/auth/auth_screen.dart';
import 'package:serv_expert_webclient/widgets/headline.dart';
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
    MediaQuery.of(context);

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Container(
        color: Colors.white,
        child: Form(
          key: formKey,
          child: body,
        ),
      ),
    );
  }

  Widget get body {
    return FillableScrollableWrapper(
      child: Column(
        children: [
          MinSpacer(flex: whenLayout<int>(mobile: 2, tablet: 1), minHeight: 32),
          const Headline(text: 'USER DETAILS'),
          SizedBox(height: whenLayout<double>(mobile: 84.ms, tablet: 72.ts)),
          SizedBox(width: whenLayout<double>(mobile: 345.ms, tablet: 546.ts), child: firstnameField()),
          SizedBox(height: whenLayout<double>(mobile: 16.ms, tablet: 24.ts)),
          SizedBox(width: whenLayout<double>(mobile: 345.ms, tablet: 546.ts), child: lastnameField()),
          SizedBox(height: whenLayout<double>(mobile: 16.ms, tablet: 24.ts)),
          SizedBox(width: whenLayout<double>(mobile: 345.ms, tablet: 546.ts), child: phoneField()),
          SizedBox(height: whenLayout<double>(mobile: 16.ms, tablet: 24.ts)),
          SizedBox(width: whenLayout<double>(mobile: 345.ms, tablet: 546.ts), child: emailField()),
          SizedBox(height: whenLayout<double>(mobile: 32.ms, tablet: 48.ts)),
          SizedBox(
            width: whenLayout<double>(mobile: 345.ms, tablet: 546.ts),
            child: RegularButton(
              text: 'CONTINUE',
              textStyle: TextStyle(
                fontSize: whenLayout<double>(mobile: 18.ms, tablet: 24.ts),
                fontWeight: FontWeight.w500,
                color: AppColors.white,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: whenLayout<double>(mobile: 16.ms, tablet: 24.ts),
                vertical: whenLayout<double>(mobile: 12.ms, tablet: 18.ts),
              ),
              onTap: onContinue,
            ),
          ),
          const MinSpacer(flex: 1, minHeight: 32),
        ],
      ),
    );
  }

  Widget firstnameField() {
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
      style: TextStyle(
        fontSize: whenLayout(mobile: 16.ms, tablet: 24.ts),
        fontWeight: FontWeight.w400,
        color: AppColors.black,
      ),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: whenLayout(mobile: 16.ms, tablet: 24.ts),
          vertical: whenLayout(mobile: 16.ms, tablet: 24.ts),
        ),
        counter: const SizedBox(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(whenLayout(mobile: 8.ms, tablet: 12.ts)),
        ),
        filled: true,
        labelText: 'First name',
        fillColor: Colors.white70,
      ),
    );
  }

  Widget lastnameField() {
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
      style: TextStyle(
        fontSize: whenLayout(mobile: 16.ms, tablet: 24.ts),
        fontWeight: FontWeight.w400,
        color: AppColors.black,
      ),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: whenLayout(mobile: 16.ms, tablet: 24.ts),
          vertical: whenLayout(mobile: 16.ms, tablet: 24.ts),
        ),
        counter: const SizedBox(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(whenLayout(mobile: 8.ms, tablet: 12.ts)),
        ),
        filled: true,
        labelText: 'Last name',
        fillColor: Colors.white70,
      ),
    );
  }

  Widget emailField() {
    return TextFormField(
      initialValue: emailValue,
      enabled: isEmailVerified ? false : true,
      keyboardType: TextInputType.emailAddress,
      maxLength: 30,
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
      style: TextStyle(
        fontSize: whenLayout(mobile: 16.ms, tablet: 24.ts),
        fontWeight: FontWeight.w400,
        color: AppColors.black,
      ),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: whenLayout(mobile: 16.ms, tablet: 24.ts),
          vertical: whenLayout(mobile: 16.ms, tablet: 24.ts),
        ),
        counter: const SizedBox(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(whenLayout(mobile: 8.ms, tablet: 12.ts)),
        ),
        filled: true,
        labelText: 'Email',
        fillColor: Colors.white70,
      ),
    );
  }

  Widget phoneField() {
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
      style: TextStyle(
        fontSize: whenLayout(mobile: 16.ms, tablet: 24.ts),
        fontWeight: FontWeight.w400,
        color: AppColors.black,
      ),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: whenLayout(mobile: 16.ms, tablet: 24.ts),
          vertical: whenLayout(mobile: 16.ms, tablet: 24.ts),
        ),
        counter: const SizedBox(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(whenLayout(mobile: 8.ms, tablet: 12.ts)),
        ),
        filled: true,
        labelText: 'Phone',
        fillColor: Colors.white70,
      ),
    );
  }
}
