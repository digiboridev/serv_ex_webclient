// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:serv_expert_webclient/auth/auth_screen.dart';
import 'package:serv_expert_webclient/core/app_colors.dart';
import 'package:serv_expert_webclient/utils/ui_utils.dart';
import 'package:serv_expert_webclient/utils/validators.dart';
import 'package:serv_expert_webclient/widgets/fillable_scrollable_wrapper.dart';
import 'package:serv_expert_webclient/widgets/headline.dart';
import 'package:serv_expert_webclient/widgets/min_spacer.dart';
import 'package:serv_expert_webclient/widgets/regular_button.dart';

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
          const Headline(text: 'LOG IN'),
          SizedBox(height: whenLayout<double>(mobile: 84.ms, tablet: 72.ts)),
          SizedBox(width: whenLayout<double>(mobile: 345.ms, tablet: 546.ts), child: phoneField()),
          SizedBox(height: whenLayout<double>(mobile: 32.ms, tablet: 32.ts)),
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
          SizedBox(height: whenLayout<double>(mobile: 32.ms, tablet: 32.ts)),
          socialButtons(iconSize: whenLayout<double>(mobile: 56.ms, tablet: 64.ts)),
          const MinSpacer(flex: 1, minHeight: 32),
        ],
      ),
    );
  }

  TextFormField phoneField() {
    return TextFormField(
      scrollPadding: EdgeInsets.zero,
      initialValue: phone,
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
          phone = value;
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
        labelText: 'Phone number',
        fillColor: Colors.white70,
      ),
    );
  }

  Widget socialButtons({required double iconSize}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () => onSignInWithGoogle(),
          child: SvgPicture.asset(
            'assets/icons/google_auth.svg',
            width: iconSize,
          ),
        ),
      ],
    );
  }
}
