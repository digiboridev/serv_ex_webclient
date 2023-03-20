import 'package:flutter/material.dart';
import 'package:serv_expert_webclient/core/app_colors.dart';

class StatusTile extends StatelessWidget {
  const StatusTile({
    required this.text,
    this.active = false,
    super.key,
  });

  final String text;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: active ? AppColors.primary : AppColors.white,
        border: Border.all(
          color: active ? AppColors.primary : AppColors.black60,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(color: active ? AppColors.white : AppColors.black, fontWeight: FontWeight.w400, fontSize: 16),
      ),
    );
  }
}
