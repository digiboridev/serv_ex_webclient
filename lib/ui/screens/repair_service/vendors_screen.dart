import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/data/models/repair_service/vendor.dart';
import 'package:serv_expert_webclient/ui/components/fillable_scrollable_wrapper.dart';
import 'package:serv_expert_webclient/ui/components/header.dart';
import 'package:serv_expert_webclient/ui/router.gr.dart';
import 'package:serv_expert_webclient/ui/screens/repair_service/providers/vendors_provider.dart';

class RepairServiceVendorsScreen extends ConsumerStatefulWidget {
  const RepairServiceVendorsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RepairServiceVendorsScreenState();
}

class _RepairServiceVendorsScreenState extends ConsumerState<RepairServiceVendorsScreen> {
  @override
  Widget build(BuildContext context) {
    AsyncValue<List<RSVendor>> vendorsData = ref.watch(vendorsProvider);

    return Container(
      color: Colors.white,
      child: FillableScrollableWrapper(
        child: Column(
          children: [
            const Header(),
            const SizedBox(
              height: 32,
            ),
            const Text(
              'VENDORS',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
            Expanded(
              child: vendorsData.when(
                data: (vendors) {
                  return FadeIn(child: content(vendors));
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => Center(child: Text(error.toString())),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
          ],
        ),
      ),
    );
  }

  Widget content(List<RSVendor> vendors) {
    return Column(
      children: [
        const Spacer(),
        Column(
          children: vendors.map((vendor) => vendorTile(vendor)).toList(),
        ),
        const Spacer()
      ],
    );
  }

  Widget vendorTile(RSVendor vendor) {
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
            context.router.navigate(RSVendorCategoriesScreenRoute(vendorId: vendor.id));
          },
          child: Center(
            child: Text(vendor.name, style: const TextStyle(color: Colors.white, fontSize: 24)),
          ),
        ),
      ),
    );
  }
}
