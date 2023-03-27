import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hand_signature/signature.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/sign.dart';
import 'package:serv_expert_webclient/widgets/headline.dart';

class SignView extends ConsumerStatefulWidget {
  const SignView({this.signnature, super.key});

  final RSOrderSign? signnature;
  // final Function() onSubmit;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignFormState();
}

class _SignFormState extends ConsumerState<SignView> {
  final nameController = HandSignatureControl();
  final signController = HandSignatureControl();

  String? namePath;
  String? signPath;

  @override
  void initState() {
    super.initState();
    if (widget.signnature != null) {
      namePath = widget.signnature!.namePath;
      nameController.importData(jsonDecode(namePath!));

      signPath = widget.signnature!.signPath;
      signController.importData(jsonDecode(signPath!));
    }
  }

  @override
  void didUpdateWidget(covariant SignView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.signnature != null) {
      namePath = widget.signnature!.namePath;
      nameController.importData(jsonDecode(namePath!));

      signPath = widget.signnature!.signPath;
      signController.importData(jsonDecode(signPath!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const Headline(text: 'Signature'),
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
                child: IgnorePointer(
                  child: HandSignature(
                    control: nameController,
                    color: Colors.red,
                    type: SignatureDrawType.shape,
                  ),
                ),
              ),
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
                child: IgnorePointer(
                  child: HandSignature(
                    control: signController,
                    color: Colors.red,
                    type: SignatureDrawType.shape,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
