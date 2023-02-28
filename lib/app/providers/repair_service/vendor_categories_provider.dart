import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/data/models/repair_service/category.dart';
import 'package:serv_expert_webclient/data/reposiotories/repair_service/categories_repository.dart';
import 'package:serv_expert_webclient/global_providers.dart';

final vendorCategoriesProvider = FutureProvider.autoDispose.family<List<RSCategory>, String>((ref, vendorId) async {
  RSCategoriesRepository repository = ref.read(rsCategoriesRepositoryProvider);
  return repository.vendorCategories(vendorId);
});
