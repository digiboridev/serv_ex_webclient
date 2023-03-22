import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hand_signature/signature.dart';
import 'package:serv_expert_webclient/core/app_colors.dart';
import 'package:serv_expert_webclient/widgets/headline.dart';
import 'package:serv_expert_webclient/widgets/min_spacer.dart';
import 'package:serv_expert_webclient/widgets/regular_button.dart';

class SignForm extends ConsumerStatefulWidget {
  const SignForm({required this.onSubmit, this.sign, super.key});

  final Function(String) onSubmit;
  final String? sign;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignFormState();
}

class _SignFormState extends ConsumerState<SignForm> {
  final control = HandSignatureControl();
  String? localSign;

  clear() {
    control.isFilled;
    control.clear();
  }

  @override
  void initState() {
    super.initState();
    if (widget.sign != null) {
      localSign = widget.sign;
      control.importData(jsonDecode(widget.sign!));
    }
    control.addListener(() {
      localSign = jsonEncode(control.toMap());
      setState(() {});
    });
  }

  onSubmit() {
    if (localSign == null) return;
    if (!canSubmit) return;

    widget.onSubmit(localSign!);
  }

  bool get canSubmit {
    return control.isFilled && widget.sign != localSign;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Headline(text: 'Signature form'),
          SizedBox(height: 32),
          Row(
            children: [
              Container(
                height: 200,
                width: 546,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: HandSignature(
                  control: control,
                  color: Colors.red,
                  type: SignatureDrawType.shape,
                ),
              ),
              ElevatedButton(
                onPressed: clear,
                child: Text('Clear'),
              ),
            ],
          ),
          MinSpacer(
            minHeight: 32,
          ),
          SizedBox(
            width: 546,
            child: RegularButton(
              onTap: canSubmit ? onSubmit : null,
              text: 'Sign',
              color: canSubmit ? AppColors.primary : AppColors.gray,
            ),
          ),
          SizedBox(height: 32)
        ],
      ),
    );
  }
}
