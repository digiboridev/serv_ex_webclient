import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/data/models/repair_service/breaking_type.dart';
import 'package:serv_expert_webclient/data/reposiotories/repair_service/breaking_types_repository.dart';
import 'package:serv_expert_webclient/global_providers.dart';

class VBTParams extends Equatable {
  final String vendorId;
  final String categoryId;

  const VBTParams(this.vendorId, this.categoryId);

  @override
  List<Object> get props => [vendorId, categoryId];
}

final vendorBreakingTypesProvider = FutureProvider.autoDispose.family<List<RSBreakingType>, VBTParams>((ref, params) async {
  RSBreakingTypesRepository repository = ref.read(rsBreakingTypesRepositoryProvider);
  return repository.vendorBreakingTypes(params.vendorId, categoryId: params.categoryId);
});
