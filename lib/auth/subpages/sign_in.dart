import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:serv_expert_webclient/auth/auth_screen.dart';
import 'package:serv_expert_webclient/core/text_styles.dart';
import 'package:serv_expert_webclient/core/validators.dart';
import 'package:serv_expert_webclient/widgets/fillable_scrollable_wrapper.dart';
import 'package:serv_expert_webclient/widgets/layouter.dart';
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
    return Container(
      color: Colors.white,
      child: Form(
        key: formKey,
        child: Layouter(
          mobileLayout: mobileBody,
          tabletLayout: tabletBody,
        ),
      ),
    );
  }

  Widget get mobileBody {
    return FillableScrollableWrapper(
      child: Column(
        children: [
          const MinSpacer(
            flex: 3,
            minHeight: 32,
          ),
          const Text('LOG IN', style: AppTextStyles.headline),
          const SizedBox(
            height: 84,
          ),
          SizedBox(
            width: 375,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: phoneField(textStyle: AppTextStyles.formText),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          SizedBox(
            width: 375,
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
            height: 38,
          ),
          socialButtons(iconSize: 56),
          const MinSpacer(
            flex: 1,
            minHeight: 32,
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
            minHeight: 64,
          ),
          const Text('LOG IN', style: AppTextStyles.headlineTablet),
          const SizedBox(
            height: 72,
          ),
          SizedBox(
            width: 546,
            child: phoneField(textStyle: AppTextStyles.formTextTablet),
          ),
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
            height: 32,
          ),
          socialButtons(iconSize: 64),
          const MinSpacer(
            minHeight: 64,
          ),
        ],
      ),
    );
  }

  TextFormField phoneField({required TextStyle textStyle}) {
    return TextFormField(
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
      style: textStyle,
      decoration: InputDecoration(
        counter: const SizedBox(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        // hintStyle: TextStyle(color: Colors.grey[800]),
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
