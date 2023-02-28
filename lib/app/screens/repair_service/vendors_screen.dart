import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/app/providers/repair_service/vendors_provider.dart';
import 'package:serv_expert_webclient/core/app_colors.dart';
import 'package:serv_expert_webclient/data/models/repair_service/vendor.dart';
import 'package:serv_expert_webclient/utils/ui_utils.dart';
import 'package:serv_expert_webclient/widgets/fillable_scrollable_wrapper.dart';
import 'package:serv_expert_webclient/app/widgets/header.dart';
import 'package:serv_expert_webclient/router.gr.dart';
import 'package:serv_expert_webclient/widgets/headline.dart';

class RepairServiceVendorsScreen extends ConsumerStatefulWidget {
  const RepairServiceVendorsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RepairServiceVendorsScreenState();
}

class _RepairServiceVendorsScreenState extends ConsumerState<RepairServiceVendorsScreen> {
  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context);

    AsyncValue<List<RSVendor>> vendorsData = ref.watch(vendorsProvider);

    return Container(
      color: Colors.white,
      child: FillableScrollableWrapper(
        child: Column(
          children: [
            const Header(),
            SizedBox(height: whenLayout(mobile: 32.ms, tablet: 48.ts)),
            const Headline(
              text: 'VENDORS',
            ),
            SizedBox(height: whenLayout(mobile: 32.ms, tablet: 48.ts)),
            Expanded(
              child: vendorsData.when(
                data: (vendors) => FadeIn(child: content(vendors)),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => Center(child: Text(error.toString())),
              ),
            ),
            SizedBox(height: whenLayout(mobile: 32.ms, tablet: 48.ts)),
          ],
        ),
      ),
    );
  }

  Widget content(List<RSVendor> vendors) {
    return Wrap(
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      spacing: whenLayout(mobile: 8.ms, tablet: 16.ts),
      runSpacing: whenLayout(mobile: 8.ms, tablet: 16.ts),
      children: vendors.map((vendor) => vendorTile(vendor)).toList(),
    );
  }

  Widget vendorTile(RSVendor vendor) {
    return Container(
      width: whenLayout(mobile: 160.ms, tablet: 300.ts),
      height: whenLayout(mobile: 160.ms, tablet: 268.ts),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(whenLayout(mobile: 8.ms, tablet: 16.ts)),
        color: AppColors.primary,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            context.router.navigate(RSVendorCategoriesScreenRoute(vendorId: vendor.id));
          },
          child: Center(
            child: Text(
              vendor.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: whenLayout(mobile: 16.ms, tablet: 24.ts),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
