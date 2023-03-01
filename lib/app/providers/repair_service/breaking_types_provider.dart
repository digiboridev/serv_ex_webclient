import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/data/models/repair_service/breaking_type.dart';
import 'package:serv_expert_webclient/data/reposiotories/repair_service/breaking_types_repository.dart';
import 'package:serv_expert_webclient/global_providers.dart';

final rsBreakingTypesProvider = FutureProvider.autoDispose.family<List<RSBreakingType>, String>((ref, categoryId) async {
  RSBreakingTypesRepository repository = ref.read(rsBreakingTypesRepositoryProvider);
  return repository.breakingTypes(categoryId: categoryId);
});
