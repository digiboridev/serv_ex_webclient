import 'package:flutter/material.dart';
import 'package:serv_expert_webclient/core/app_colors.dart';

class RegularButton extends StatelessWidget {
  const RegularButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.color = AppColors.primary,
    this.borderColor,
    this.textStyle = const TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w700,
    ),
    this.borderRadius = const BorderRadius.all(Radius.circular(32)),
    this.padding = const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
  }) : super(key: key);

  final VoidCallback? onTap;
  final String text;
  final Color color;
  final Color? borderColor;
  final TextStyle textStyle;
  final BorderRadiusGeometry borderRadius;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: borderRadius,
      clipBehavior: Clip.antiAlias,
      color: color,
      elevation: 10,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          border: borderColor != null ? Border.all(color: borderColor!, width: 1) : null,
        ),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: padding,
            child: Text(
              text,
              style: textStyle,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
