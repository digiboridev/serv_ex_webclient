import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/data/models/repair_service/vendor.dart';
import 'package:serv_expert_webclient/main.dart';
import 'package:serv_expert_webclient/ui/components/fillable_scrollable_wrapper.dart';
import 'package:serv_expert_webclient/ui/components/header.dart';
import 'package:serv_expert_webclient/ui/router.gr.dart';

final vendorsStreamProvider = StreamProvider.autoDispose<List<RSVendor>>((ref) {
  final vendorsRepository = ref.watch(rsVendorsRepositoryProvider);
  return vendorsRepository.vendorsStream();
});

class RepairServiceVendorsScreen extends ConsumerStatefulWidget {
  const RepairServiceVendorsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RepairServiceVendorsScreenState();
}

class _RepairServiceVendorsScreenState extends ConsumerState<RepairServiceVendorsScreen> {
  @override
  Widget build(BuildContext context) {
    AsyncValue<List<RSVendor>> vendorsValue = ref.watch(vendorsStreamProvider);

    return Container(
      color: Colors.white,
      child: FillableScrollableWrapper(
        child: Column(
          children: [
            Header(context: context),
            Expanded(
              child: vendorsValue.when(
                data: (vendors) {
                  return content(vendors);
                },
                loading: () => Center(child: const CircularProgressIndicator()),
                error: (error, stackTrace) => Center(child: Text(error.toString())),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget content(List<RSVendor> vendors) {
    return Column(
      children: [
        Spacer(),
        const Text(
          'VENDORS',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Column(
          children: vendors.map((vendor) => vendorTile(vendor)).toList(),
        ),
        Spacer()
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
