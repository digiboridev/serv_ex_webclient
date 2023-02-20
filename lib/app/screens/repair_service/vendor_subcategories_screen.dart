// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/core/app_colors.dart';
import 'package:serv_expert_webclient/core/text_styles.dart';
import 'package:serv_expert_webclient/data/models/repair_service/category.dart';
import 'package:serv_expert_webclient/widgets/fillable_scrollable_wrapper.dart';
import 'package:serv_expert_webclient/app/widgets/header.dart';
import 'package:serv_expert_webclient/router.gr.dart';
import 'package:serv_expert_webclient/app/screens/repair_service/providers/vendor_category_provider.dart';
import 'package:serv_expert_webclient/app/screens/repair_service/providers/vendor_subcategories_provider.dart';
import 'package:transparent_image/transparent_image.dart';

class RSVendorSubCategoriesScreen extends ConsumerStatefulWidget {
  const RSVendorSubCategoriesScreen({super.key, @queryParam required this.vendorId, @queryParam required this.categoryId});
  final String? vendorId;
  final String? categoryId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RSVendorSubCategoriesScreenState();
}

class _RSVendorSubCategoriesScreenState extends ConsumerState<RSVendorSubCategoriesScreen> {
  onCategoryTap(RSCategory category) {
    context.router.navigate(RSVendorBreakingTypesScreenRoute(vendorId: widget.vendorId, categoryId: category.id));
  }

  @override
  Widget build(BuildContext context) {
    AsyncValue<List<RSCategory>> categories = ref.watch(vendorSubcategoriesProvider(VSCParams(widget.vendorId!, widget.categoryId!)));

    return FillableScrollableWrapper(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            const Header(),
            const SizedBox(
              height: 32,
            ),
            cetegoryName(),
            const SizedBox(
              height: 32,
            ),
            Expanded(
              child: categories.when(
                data: (categories) {
                  return FadeIn(child: content(categories));
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

  Widget cetegoryName() {
    return Consumer(
      builder: (context, ref, child) {
        AsyncValue<RSCategory> selectedCategoryData = ref.watch(
          vendorCategoryProvider(
            VCParams(vendorId: widget.vendorId!, categoryId: widget.categoryId!),
          ),
        );

        return FadeIn(
          child: Text(
            selectedCategoryData.when(
              data: (category) {
                return category.name;
              },
              loading: () => '',
              error: (error, stackTrace) => 'Error',
            ),
            style: AppTextStyles.headline,
          ),
        );
      },
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
      width: 300,
      margin: const EdgeInsets.symmetric(vertical: 8),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.primary,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onCategoryTap(category),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 64,
              ),
              FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: category.imageUri,
                width: 120,
                height: 120,
                fit: BoxFit.contain,
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(category.name, style: const TextStyle(color: Colors.white, fontSize: 24)),
              ),
              const SizedBox(
                height: 64,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
