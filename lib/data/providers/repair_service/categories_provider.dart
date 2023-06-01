import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/data/models/repair_service/category.dart';
import 'package:serv_expert_webclient/data/reposiotories/repair_service/catalog_repository.dart';
import 'package:serv_expert_webclient/global_providers.dart';

final mainCategoriesProvider = FutureProvider.autoDispose<List<RSCategory>>((ref) async {
  CatalogRepository repository = ref.read(catalogRepositoryProvider);
  return repository.mainCategories();
});

final subCategoriesProvider = FutureProvider.autoDispose.family<List<RSCategory>, String>((ref, parentId) async {
  CatalogRepository repository = ref.read(catalogRepositoryProvider);
  return repository.subCategories(parentId: parentId);
});
