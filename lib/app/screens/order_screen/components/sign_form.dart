import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hand_signature/signature.dart';
import 'package:serv_expert_webclient/core/app_colors.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/sign.dart';
import 'package:serv_expert_webclient/widgets/headline.dart';
import 'package:serv_expert_webclient/widgets/min_spacer.dart';
import 'package:serv_expert_webclient/widgets/regular_button.dart';

class SignForm extends ConsumerStatefulWidget {
  const SignForm({required this.onSubmit, this.signnature, super.key});

  final Function(RSOrderSign) onSubmit;
  final RSOrderSign? signnature;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignFormState();
}

class _SignFormState extends ConsumerState<SignForm> {
  final nameController = HandSignatureControl();
  final signController = HandSignatureControl();

  String? namePath;
  String? signPath;

  clearName() {
    nameController.clear();
  }

  clearSign() {
    signController.clear();
  }

  @override
  void initState() {
    super.initState();
    if (widget.signnature != null) {
      namePath = widget.signnature!.namePath;
      nameController.importData(jsonDecode(namePath!));

      signPath = widget.signnature!.signPath;
      signController.importData(jsonDecode(signPath!));
    }

    nameController.addListener(() {
      namePath = jsonEncode(nameController.toMap());
      setState(() {});
    });

    signController.addListener(() {
      signPath = jsonEncode(signController.toMap());
      setState(() {});
    });
  }

  bool get canSubmit {
    bool nameModified = widget.signnature?.namePath != namePath;
    bool signModified = widget.signnature?.signPath != signPath;
    return (signController.isFilled && nameController.isFilled) && (nameModified || signModified);
  }

  onSubmit() {
    if (!canSubmit) return;

    RSOrderSign sign = RSOrderSign(
      namePath: namePath!,
      signPath: signPath!,
    );

    widget.onSubmit(sign);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const Headline(text: 'Signature form'),
          const SizedBox(height: 32),
          const Text('Name'),
          const SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 200,
                width: 546,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: HandSignature(
                  control: nameController,
                  color: Colors.red,
                  type: SignatureDrawType.shape,
                ),
              ),
              IconButton(onPressed: clearName, icon: const Icon(Icons.refresh))
            ],
          ),
          const SizedBox(height: 16),
          const Text('Signature'),
          const SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 200,
                width: 546,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: HandSignature(
                  control: signController,
                  color: Colors.red,
                  type: SignatureDrawType.shape,
                ),
              ),
              IconButton(onPressed: clearSign, icon: const Icon(Icons.refresh))
            ],
          ),
          const MinSpacer(
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
          const SizedBox(height: 32)
        ],
      ),
    );
  }
}
