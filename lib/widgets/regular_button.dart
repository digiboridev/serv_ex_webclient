import 'package:flutter/material.dart';
import 'package:serv_expert_webclient/core/app_colors.dart';

class RegularButton extends StatelessWidget {
  const RegularButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.disabled = false,
    this.color = AppColors.primary,
    this.disabledColor = AppColors.primaryDisabled,
    this.textStyle = const TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w700,
    ),
  }) : super(key: key);

  final VoidCallback onTap;
  final String text;
  final bool disabled;
  final Color color;
  final Color disabledColor;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      elevation: 10,
      shadowColor: disabled ? disabledColor : color,
      color: disabled ? disabledColor : color,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: disabled ? null : onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Text(
            text,
            style: textStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
