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

class AuthCompanyCreate extends ConsumerStatefulWidget {
  const AuthCompanyCreate({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<AuthCompanyCreate> createState() => _CompanyRegistrationSubpageState();
}

class _CompanyRegistrationSubpageState extends ConsumerState<AuthCompanyCreate> {
  final formKey = GlobalKey<FormState>();

  String publicId = '';
  String companyName = '';
  String companyEmail = '';

  onContinue() {
    bool? valid = formKey.currentState?.validate();
    if (valid == true) {
      formKey.currentState?.save();
      ref.read(authScreenControllerProvider.notifier).submitCompanyCreate(
            publicId: publicId,
            companyName: companyName,
            companyEmail: companyEmail,
          );
    }
  }

  onSkip() {
    ref.read(authScreenControllerProvider.notifier).skipCompanyCreate();
  }

  @override
  void initState() {
    super.initState();
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
          const Headline(text: 'COMPANY REGISTRATION'),
          SizedBox(height: whenLayout<double>(mobile: 84.ms, tablet: 72.ts)),
          SizedBox(width: whenLayout<double>(mobile: 345.ms, tablet: 546.ts), child: publicIdField()),
          SizedBox(height: whenLayout<double>(mobile: 8.ms, tablet: 16.ts)),
          SizedBox(width: whenLayout<double>(mobile: 345.ms, tablet: 546.ts), child: nameField()),
          SizedBox(height: whenLayout<double>(mobile: 8.ms, tablet: 16.ts)),
          SizedBox(width: whenLayout<double>(mobile: 345.ms, tablet: 546.ts), child: emailField()),
          SizedBox(height: whenLayout<double>(mobile: 16.ms, tablet: 24.ts)),
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
          SizedBox(height: whenLayout<double>(mobile: 16.ms, tablet: 24.ts)),
          SizedBox(
            width: whenLayout<double>(mobile: 345.ms, tablet: 546.ts),
            child: RegularButton(
              color: AppColors.white,
              borderColor: AppColors.primary,
              text: 'SKIP',
              textStyle: TextStyle(
                fontSize: whenLayout<double>(mobile: 18.ms, tablet: 24.ts),
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: whenLayout<double>(mobile: 16.ms, tablet: 24.ts),
                vertical: whenLayout<double>(mobile: 12.ms, tablet: 18.ts),
              ),
              onTap: onContinue,
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

  Widget publicIdField() {
    return TextFormField(
      initialValue: publicId,
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
        setState(() {
          publicId = value;
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
        labelText: 'ID',
        fillColor: Colors.white70,
      ),
    );
  }

  Widget nameField() {
    return TextFormField(
      initialValue: companyName,
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
        setState(() {
          companyName = value;
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
        labelText: 'Company name',
        fillColor: Colors.white70,
      ),
    );
  }

  Widget emailField() {
    return TextFormField(
      initialValue: companyEmail,
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
          companyEmail = value;
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
}
