import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/core/app_colors.dart';
import 'package:serv_expert_webclient/core/log.dart';
import 'package:serv_expert_webclient/core/text_styles.dart';
import 'package:serv_expert_webclient/data/dto/repair_service/new_order.dart';
import 'package:serv_expert_webclient/global_providers.dart';
import 'package:serv_expert_webclient/router.gr.dart';
import 'package:serv_expert_webclient/services/rs_orders_service.dart';
import 'package:serv_expert_webclient/widgets/fillable_scrollable_wrapper.dart';
import 'package:serv_expert_webclient/widgets/loading_wrapper.dart';
import 'package:serv_expert_webclient/widgets/min_spacer.dart';

class RSOrderHasPasswordScreen extends ConsumerStatefulWidget {
  const RSOrderHasPasswordScreen({
    required this.newOrder,
    super.key,
  });

  final RSNewOrderDTO newOrder;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RSOrderHasPasswordScreenState();
}

class _RSOrderHasPasswordScreenState extends ConsumerState<RSOrderHasPasswordScreen> {
  bool busy = false;

  onChoose(bool hasPassword) async {
    if (busy) return;
    RSNewOrderDTO newOrder = widget.newOrder..hasPassword = hasPassword;
    if (hasPassword) {
      context.router.navigate(RSOrderPasswordTypeScreenRoute(newOrder: newOrder));
    } else {
      RSOrdersService ordersService = ref.read(rsOrdersServiceProvider);

      setState(() => busy = true);

      try {
        await ordersService.createOrder(order: newOrder);
        if (mounted) {
          context.router.navigate(const RSOrderSubmittedScreenRoute());
        }
      } catch (e) {
        log(e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            action: SnackBarAction(
              label: 'Dismiss',
              onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
            ),
          ),
        );
      }

      setState(() => busy = false);
    }
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
                'ORDER HAS PASSWORD',
                style: AppTextStyles.headline,
              ),
              const MinSpacer(
                minHeight: 32,
              ),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  hasPassTile(),
                  noPassTile(),
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

  Widget hasPassTile() {
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
          onTap: () => onChoose(true),
          child: const Center(
            child: Text('Has Password', style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
        ),
      ),
    );
  }

  Widget noPassTile() {
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
          onTap: () => onChoose(false),
          child: const Center(
            child: Text('No password', style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
        ),
      ),
    );
  }
}
