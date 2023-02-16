import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/data/dto/repair_service/new_order.dart';
import 'package:serv_expert_webclient/router.gr.dart';
import 'package:serv_expert_webclient/widgets/fillable_scrollable_wrapper.dart';
import 'package:serv_expert_webclient/widgets/min_spacer.dart';

class RSOrderWarantyScreen extends ConsumerStatefulWidget {
  const RSOrderWarantyScreen({
    required this.newOrder,
    super.key,
  });

  final RSNewOrderDTO newOrder;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RSOrderWarantyScreenState();
}

class _RSOrderWarantyScreenState extends ConsumerState<RSOrderWarantyScreen> {
  onChoose(bool hasWaranty) {
    RSNewOrderDTO newOrder = widget.newOrder..hasWaranty = hasWaranty;
    context.router.navigate(RSOrderHasPasswordScreenRoute(newOrder: newOrder));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FillableScrollableWrapper(
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
              'ORDER WARANTY',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
            const MinSpacer(
              minHeight: 32,
            ),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                hasWarantyTile(),
                noWarantyTile(),
              ],
            ),
            const MinSpacer(
              minHeight: 32,
            ),
          ],
        ),
      ),
    );
  }

  Widget hasWarantyTile() {
    return Container(
      width: 300,
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 8),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.deepPurple,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onChoose(true),
          child: const Center(
            child: Text('Has waranty', style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
        ),
      ),
    );
  }

  Widget noWarantyTile() {
    return Container(
      width: 300,
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 8),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.deepPurple,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onChoose(false),
          child: const Center(
            child: Text('No waranty', style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
        ),
      ),
    );
  }
}
