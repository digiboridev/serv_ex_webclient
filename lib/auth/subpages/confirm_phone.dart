import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:serv_expert_webclient/core/app_colors.dart';
import 'package:serv_expert_webclient/core/text_styles.dart';
import 'package:serv_expert_webclient/widgets/fillable_scrollable_wrapper.dart';
import 'package:serv_expert_webclient/auth/auth_screen.dart';
import 'package:serv_expert_webclient/widgets/layouter.dart';
import 'package:serv_expert_webclient/widgets/min_spacer.dart';
import 'package:serv_expert_webclient/widgets/regular_button.dart';

class AuthConfirmPhone extends ConsumerStatefulWidget {
  const AuthConfirmPhone({
    Key? key,
    required this.phone,
  }) : super(key: key);

  final String phone;

  @override
  ConsumerState<AuthConfirmPhone> createState() => _SmsSentSubpageState();
}

class _SmsSentSubpageState extends ConsumerState<AuthConfirmPhone> {
  final formKey = GlobalKey<FormState>();
  String smsCode = '';

  onContinue() {
    bool? valid = formKey.currentState?.validate();
    if (valid == true) {
      ref.read(authScreenControllerProvider.notifier).confirmSmsCode(smsCode: smsCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Form(
        key: formKey,
        child: Layouter(mobileLayout: mobileBody, tabletLayout: tabletBody),
      ),
    );
  }

  Widget get mobileBody {
    return FillableScrollableWrapper(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const MinSpacer(
            minHeight: 32,
            flex: 3,
          ),
          const Text('SMS', style: AppTextStyles.headline),
          const SizedBox(
            height: 84,
          ),
          SizedBox(
            child: codeField(mobile: true),
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
          const MinSpacer(
            minHeight: 32,
            flex: 2,
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
          const Text('SMS', style: AppTextStyles.headlineTablet),
          const SizedBox(
            height: 72,
          ),
          SizedBox(
            child: codeField(mobile: false),
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
          const MinSpacer(
            minHeight: 64,
          ),
        ],
      ),
    );
  }

  Pinput codeField({required bool mobile}) {
    PinTheme mobileTheme = PinTheme(
      height: 44,
      width: 44,
      textStyle: AppTextStyles.formText,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.gray, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
    );

    PinTheme tabletTheme = PinTheme(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: 60,
      width: 60,
      textStyle: AppTextStyles.formTextTablet,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.gray, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
    );

    return Pinput(
      defaultPinTheme: mobile ? mobileTheme : tabletTheme,
      length: 6,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some numbers';
        }
        return null;
      },
      onChanged: (value) {
        smsCode = value;
      },
      onSubmitted: (value) {
        onContinue();
      },
      onCompleted: (value) {
        onContinue();
      },
    );
  }
}

