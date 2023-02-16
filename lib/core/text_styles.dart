import 'package:flutter/material.dart';
import 'package:serv_expert_webclient/core/app_colors.dart';

abstract class AppTextStyles {
  static const TextStyle headline = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.black,
  );

  static const TextStyle headlineTablet = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.black,
  );

  static const TextStyle btnText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
  );

  static const TextStyle btnTextTablet = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
  );

  static const TextStyle formText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
  );
  static const TextStyle formTextTablet = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
  );
}
