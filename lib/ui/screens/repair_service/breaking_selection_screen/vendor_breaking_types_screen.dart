import 'package:auto_route/auto_route.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/data/models/repair_service/breaking_type.dart';
import 'package:serv_expert_webclient/data/reposiotories/repair_service/breaking_types_repository.dart';
import 'package:serv_expert_webclient/main.dart';
import 'package:serv_expert_webclient/ui/components/fillable_scrollable_wrapper.dart';
import 'package:serv_expert_webclient/ui/components/header.dart';
import 'package:serv_expert_webclient/ui/components/min_spacer.dart';

class BrTypesParams extends Equatable {
  final String vendorId;
  final String categoryId;

  const BrTypesParams(this.vendorId, this.categoryId);

  @override
  List<Object> get props => [vendorId, categoryId];
}

final breakingTypesProvider = FutureProvider.autoDispose.family<List<RSBreakingType>, BrTypesParams>((ref, params) async {
  RSBreakingTypesRepository repository = ref.read(rsBreakingTypesRepositoryProvider);
  return repository.vendorBreakingTypes(params.vendorId, categoryId: params.categoryId);
});

class RSVendorBreakingTypesScreen extends ConsumerWidget {
  const RSVendorBreakingTypesScreen({super.key, @queryParam required this.vendorId, @queryParam required this.categoryId});

  final String? vendorId;
  final String? categoryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<RSBreakingType>> breakingTypes = ref.watch(breakingTypesProvider(BrTypesParams(vendorId!, categoryId!)));

    return FillableScrollableWrapper(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Header(context: context),
            Expanded(
              child: breakingTypes.when(
                data: (breakingTypes) {
                  return BreakingTypeSelection(
                    breakingTypes: breakingTypes,
                  );
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
}

class BreakingTypeSelection extends ConsumerStatefulWidget {
  const BreakingTypeSelection({required this.breakingTypes, super.key});
  final List<RSBreakingType> breakingTypes;

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 32,
        ),
        const Text(
          'BREAKING TYPES',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ),
        const MinSpacer(
          minHeight: 32,
        ),
        Column(children: breakingTypes.map((breakingType) => breakingTile(breakingType)).toList()),
        const MinSpacer(
          minHeight: 32,
        ),
        ElevatedButton(onPressed: () {}, child: Text('Next')),
        const SizedBox(
          height: 32,
        ),
      ],
    );
  }

  Widget breakingTile(RSBreakingType breakingType) {
    return Container(
      width: 300,
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
