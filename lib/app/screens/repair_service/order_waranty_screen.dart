import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/data/dto/new_service_order.dart';
import 'package:serv_expert_webclient/widgets/fillable_scrollable_wrapper.dart';
import 'package:serv_expert_webclient/widgets/min_spacer.dart';

class RSOrderWarantyScreen extends ConsumerStatefulWidget {
  const RSOrderWarantyScreen({
    required this.newServiceOrder,
    super.key,
  });

  final NewServiceOrder newServiceOrder;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RSOrderWarantyScreenState();
}

class _RSOrderWarantyScreenState extends ConsumerState<RSOrderWarantyScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FillableScrollableWrapper(
        child: Column(
          children: [
            SizedBox(
              height: 32,
            ),
            Text(
              'ORDER WARANTY',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
            MinSpacer(
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
            MinSpacer(
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
          onTap: () {
            context.router.navigateBack();
            // context.router.navigate(const RepairServiceVendorsScreenRoute());
          },
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
          onTap: () {
            // context.router.navigate(const RepairServiceVendorsScreenRoute());
          },
          child: const Center(
            child: Text('No waranty', style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
        ),
      ),
    );
  }
}
