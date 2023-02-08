import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/data/models/repair_service/category.dart';
import 'package:serv_expert_webclient/ui/components/fillable_scrollable_wrapper.dart';
import 'package:serv_expert_webclient/ui/components/header.dart';
import 'package:serv_expert_webclient/ui/router.gr.dart';
import 'package:serv_expert_webclient/ui/screens/repair_service/providers/vendor_categories_provider.dart';

class RSVendorCategoriesScreen extends ConsumerStatefulWidget {
  const RSVendorCategoriesScreen({super.key, @queryParam required this.vendorId});
  final String? vendorId;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RSVendorCategoriesScreenState();
}

class _RSVendorCategoriesScreenState extends ConsumerState<RSVendorCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    AsyncValue<List<RSCategory>> categories = ref.watch(vendorCategoriesProvider(widget.vendorId!));

    return FillableScrollableWrapper(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Header(),
            const SizedBox(
              height: 32,
            ),
            const Text(
              'CATEGORY',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Expanded(
              child: categories.when(
                data: (categories) {
                  return FadeIn(child: content(categories));
                },
                loading: () => Center(child: const CircularProgressIndicator()),
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

  Widget content(List<RSCategory> categories) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: categories.map((category) => categoryTile(category)).toList(),
          ),
        ),
      ],
    );
  }

  Widget categoryTile(RSCategory category) {
    return Container(
      width: 360,
      height: 280,
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
            context.router.navigate(RSVendorSubCategoriesScreenRoute(vendorId: widget.vendorId, categoryId: category.id));
          },
          child: Center(child: Text(category.name, style: const TextStyle(color: Colors.white, fontSize: 24))),
        ),
      ),
    );
  }
}
