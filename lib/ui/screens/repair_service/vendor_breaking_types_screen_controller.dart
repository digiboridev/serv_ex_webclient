import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/core/log.dart';
import 'package:serv_expert_webclient/data/models/repair_service/breaking_type.dart';
import 'package:serv_expert_webclient/data/reposiotories/repair_service/breaking_types_repository.dart';

abstract class VendorBreakingTypesState {}

class VBTInitial extends VendorBreakingTypesState {
  @override
  String toString() => 'VBTInitial';
}

class VBTDataLoading extends VendorBreakingTypesState {
  @override
  String toString() => 'VBTDataLoading';
}

class VBTDataLoadingError extends VendorBreakingTypesState {
  final String error;

  VBTDataLoadingError(this.error);
}

class VBTCommon extends VendorBreakingTypesState {
  final List<RSBreakingType> breakingTypes;

  VBTCommon(this.breakingTypes);
}

class ContributorController extends StateNotifier<VendorBreakingTypesState> {
  ContributorController({required this.breakingTypesRepository}) : super(VBTInitial());

  final RSBreakingTypesRepository breakingTypesRepository;

  Future load({
    required String vendorId,
    required String categoryId,
  }) async {
    try {
      List<RSBreakingType> breakingTypes = await breakingTypesRepository.vendorBreakingTypes(vendorId, categoryId: categoryId);
    } catch (e) {
      log(e);
    }
  }
}
