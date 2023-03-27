import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/core/app_colors.dart';
import 'package:serv_expert_webclient/core/text_styles.dart';
import 'package:serv_expert_webclient/data/dto/repair_service/new_order.dart';
import 'package:serv_expert_webclient/router.gr.dart';
import 'package:serv_expert_webclient/widgets/fillable_scrollable_wrapper.dart';
import 'package:serv_expert_webclient/widgets/loading_wrapper.dart';
import 'package:serv_expert_webclient/widgets/min_spacer.dart';

class RSOrderPasswordTypeScreen extends ConsumerStatefulWidget {
  const RSOrderPasswordTypeScreen({
    required this.newOrder,
    super.key,
  });

  final RSNewOrderDTO newOrder;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RSOrderPasswordTypeScreenState();
}

class _RSOrderPasswordTypeScreenState extends ConsumerState<RSOrderPasswordTypeScreen> {
  bool busy = false;

  onChoose(DevicePasswordType type) async {
    RSNewOrderDTO newOrder = widget.newOrder..passwordType = type;
    context.router.navigate(RSOrderPasswordScreenRoute(newOrder: newOrder));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FillableScrollableWrapper(
        child: LoadingWrapper(
          busy: busy,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => context.router.pop(),
                    ),
                  ],
                ),
              ),
              const MinSpacer(
                minHeight: 32,
              ),
              const Text(
                'PASSWORD TYPE',
                style: AppTextStyles.headline,
              ),
              const MinSpacer(
                minHeight: 32,
              ),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  patternTile(),
                  numericTile(),
                ],
              ),
              const MinSpacer(
                minHeight: 32,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget patternTile() {
    return Container(
      width: 300,
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 8),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.primary,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onChoose(DevicePasswordType.pattern),
          child: const Center(
            child: Text('Pattern', style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
        ),
      ),
    );
  }

  Widget numericTile() {
    return Container(
      width: 300,
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 8),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.primary,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onChoose(DevicePasswordType.numeric),
          child: const Center(
            child: Text('Numeric', style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
        ),
      ),
    );
  }
}
