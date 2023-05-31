import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:serv_expert_webclient/core/app_colors.dart';
import 'package:serv_expert_webclient/utils/ui_utils.dart';
import 'package:serv_expert_webclient/widgets/fillable_scrollable_wrapper.dart';
import 'package:serv_expert_webclient/auth/auth_screen.dart';
import 'package:serv_expert_webclient/widgets/headline.dart';
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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MinSpacer(
            flex: whenLayout<int>(mobile: 2, tablet: 1),
            minHeight: 32,
          ),
          const Headline(text: 'SMS'),
          SizedBox(
            height: whenLayout<double>(mobile: 84.ms, tablet: 72.ts),
          ),
          SizedBox(
            child: codeField(),
          ),
          SizedBox(
            height: whenLayout<double>(mobile: 32.ms, tablet: 32.ts),
          ),
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
          const MinSpacer(
            minHeight: 32,
            flex: 1,
          ),
        ],
      ),
    );
  }

  Pinput codeField() {
    return Pinput(
      defaultPinTheme: PinTheme(
        margin: EdgeInsets.symmetric(
          horizontal: whenLayout<double>(mobile: 2.ms, tablet: 4.ts),
        ),
        height: whenLayout<double>(mobile: 44.ms, tablet: 60.ts),
        width: whenLayout<double>(mobile: 44.ms, tablet: 60.ts),
        textStyle: TextStyle(
          fontSize: whenLayout<double>(mobile: 16.ms, tablet: 24.ts),
          fontWeight: FontWeight.w400,
          color: AppColors.black,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.gray, width: whenLayout<double>(mobile: 1.ms, tablet: 1.ts)),
          borderRadius: BorderRadius.circular(whenLayout<double>(mobile: 8.ms, tablet: 12.ts)),
        ),
      ),
      length: 4,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some numbers';
        }
        if (value.length < 4) {
          return 'Please enter 4 digits';
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
