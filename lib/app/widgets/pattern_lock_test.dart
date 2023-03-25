import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/app/widgets/pattern_lock/pattern_lock.dart';
import 'package:serv_expert_webclient/core/app_colors.dart';
import 'package:serv_expert_webclient/core/log.dart';

class PatternLockTest extends ConsumerStatefulWidget {
  const PatternLockTest({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PatternLockTestState();
}

class _PatternLockTestState extends ConsumerState<PatternLockTest> {
  List<int> points = [];

  reset() {
    setState(() => points = []);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 400,
          height: 400,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.1),
                offset: const Offset(0, 4),
                blurRadius: 8,
              ),
            ],
          ),
          child: PatternLock(
            selectedColor: AppColors.primary,
            initialPoints: points,
            dimension: 3,
            onInputComplete: (List<int> s) {
              setState(() => points = s);
            },
          ),
        ),
        SizedBox(height: 8),
        TextButton(
          onPressed: points.isNotEmpty ? reset : null,
          child: Text('RESET', style: TextStyle(fontWeight: FontWeight.w500, color: points.isNotEmpty ? AppColors.primary : AppColors.primaryDisabled)),
        ),
      ],
    );
  }
}
