import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/core/app_colors.dart';
import 'package:serv_expert_webclient/core/text_styles.dart';
import 'package:serv_expert_webclient/core/validators.dart';
import 'package:serv_expert_webclient/widgets/fillable_scrollable_wrapper.dart';
import 'package:serv_expert_webclient/auth/auth_screen.dart';
import 'package:serv_expert_webclient/widgets/layouter.dart';
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
          const Text('COMPANY REGISTRATION', style: AppTextStyles.headline),
          const SizedBox(
            height: 86,
          ),
          SizedBox(
            width: 345,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: publicIdField(textStyle: AppTextStyles.formText),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            width: 345,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: nameField(textStyle: AppTextStyles.formText),
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
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            width: 345,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: RegularButton(
                color: AppColors.white,
                borderColor: AppColors.primary,
                text: 'SKIP',
                textStyle: AppTextStyles.btnText.copyWith(color: AppColors.primary),
                onTap: onSkip,
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
          const Text('COMPANY REGISTRATION', style: AppTextStyles.headlineTablet),
          const SizedBox(
            height: 86,
          ),
          SizedBox(width: 546, child: publicIdField(textStyle: AppTextStyles.formTextTablet)),
          const SizedBox(
            height: 16,
          ),
          SizedBox(width: 546, child: nameField(textStyle: AppTextStyles.formTextTablet)),
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
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            width: 546,
            child: RegularButton(
              color: AppColors.white,
              borderColor: AppColors.primary,
              text: 'SKIP',
              textStyle: AppTextStyles.btnTextTablet.copyWith(color: AppColors.primary),
              onTap: onSkip,
            ),
          ),
          const MinSpacer(
            minHeight: 32,
          ),
        ],
      ),
    );
  }

  Widget publicIdField({required TextStyle textStyle}) {
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
      style: textStyle,
      decoration: InputDecoration(
        counter: const SizedBox(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        labelText: 'ID',
        fillColor: Colors.white70,
      ),
    );
  }

  Widget nameField({required TextStyle textStyle}) {
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
      style: textStyle,
      decoration: InputDecoration(
        counter: const SizedBox(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        labelText: 'Company name',
        fillColor: Colors.white70,
      ),
    );
  }

  Widget emailField({required TextStyle textStyle}) {
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
}
