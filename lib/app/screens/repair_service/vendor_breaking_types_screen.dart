import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/data/dto/repair_service/new_order.dart';
import 'package:serv_expert_webclient/data/models/repair_service/breaking_type.dart';
import 'package:serv_expert_webclient/data/models/repair_service/category.dart';
import 'package:serv_expert_webclient/router.gr.dart';
import 'package:serv_expert_webclient/widgets/fillable_scrollable_wrapper.dart';
import 'package:serv_expert_webclient/app/widgets/header.dart';
import 'package:serv_expert_webclient/widgets/min_spacer.dart';
import 'package:serv_expert_webclient/app/screens/repair_service/providers/vendor_category_provider.dart';
import 'package:serv_expert_webclient/app/screens/repair_service/providers/vendor_breaking_types_provider.dart';

class RSVendorBreakingTypesScreen extends ConsumerWidget {
  const RSVendorBreakingTypesScreen({super.key, @queryParam required this.vendorId, @queryParam required this.categoryId});

  final String? vendorId;
  final String? categoryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FillableScrollableWrapper(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            const Header(),
            const SizedBox(
              height: 32,
            ),
            categoryName(),
            const SizedBox(
              height: 32,
            ),
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  AsyncValue<List<RSBreakingType>> breakingTypes = ref.watch(vendorBreakingTypesProvider(VBTParams(vendorId!, categoryId!)));
                  return breakingTypes.when(
                    data: (breakingTypes) {
                      return FadeIn(
                        child: BreakingTypeSelection(
                          vendorId: vendorId!,
                          categoryId: categoryId!,
                          breakingTypes: breakingTypes,
                        ),
                      );
                    },
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (error, stackTrace) => Center(child: Text(error.toString())),
                  );
                },
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

  Consumer categoryName() {
    return Consumer(
      builder: (context, ref, child) {
        AsyncValue<RSCategory> selectedCategoryData = ref.watch(
          vendorCategoryProvider(
            VCParams(vendorId: vendorId!, categoryId: categoryId!),
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
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
        );
      },
    );
  }
}

class BreakingTypeSelection extends ConsumerStatefulWidget {
  const BreakingTypeSelection({required this.vendorId, required this.breakingTypes, required this.categoryId, super.key});
  final List<RSBreakingType> breakingTypes;
  final String vendorId;
  final String categoryId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BreakingTypeSelectionState();
}

class _BreakingTypeSelectionState extends ConsumerState<BreakingTypeSelection> {
  late final List<RSBreakingType> breakingTypes;
  List<RSBreakingType> selectedBreakingTypes = [];

  @override
  void initState() {
    super.initState();
    breakingTypes = widget.breakingTypes;
  }

  onSubmit() {
    RSNewOrderDTO newOrder = RSNewOrderDTO(
      vendorId: widget.vendorId,
      categoryId: widget.categoryId,
      breakingTypeIds: selectedBreakingTypes.map((breakingType) => breakingType.id).toList(),
    );
    context.router.navigate(
      RSOrderDetailsScreenRoute(newOrder: newOrder),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(children: breakingTypes.map((breakingType) => breakingTile(breakingType)).toList()),
        const MinSpacer(
          minHeight: 32,
        ),
        nextButton(),
        const MinSpacer(
          minHeight: 32,
        ),
      ],
    );
  }

  Widget nextButton() {
    return SizedBox(
      width: 600,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Material(
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: onSubmit,
            child: Ink(
              // width: 600,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  'Next',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget breakingTile(RSBreakingType breakingType) {
    return Container(
      width: 600,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Checkbox(
            value: selectedBreakingTypes.contains(breakingType),
            onChanged: (value) {
              if (value!) {
                setState(() {
                  selectedBreakingTypes.add(breakingType);
                });
              } else {
                setState(() {
                  selectedBreakingTypes.remove(breakingType);
                });
              }
            },
          ),
          Text(breakingType.name),
        ],
      ),
    );
  }
}
