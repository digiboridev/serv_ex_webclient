import 'package:flutter/material.dart';
import 'package:serv_expert_webclient/core/app_colors.dart';
import 'package:serv_expert_webclient/utils/ui_utils.dart';

class Headline extends StatelessWidget {
  const Headline({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context);
    return Text(
      text,
      style: TextStyle(
        fontSize: whenLayout<double>(mobile: 24.ms, tablet: 32.ts),
        fontWeight: FontWeight.w700,
        color: AppColors.black,
      ),
    );
  }
}
