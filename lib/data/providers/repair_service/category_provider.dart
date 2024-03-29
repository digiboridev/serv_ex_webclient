// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/data/models/repair_service/category.dart';
import 'package:serv_expert_webclient/data/reposiotories/repair_service/catalog_repository.dart';
import 'package:serv_expert_webclient/global_providers.dart';

final categoryProvider = FutureProvider.autoDispose.family<Category, String>((ref, categoryId) async {
  CatalogRepository repository = ref.read(catalogRepositoryProvider);
  return repository.categoryById(categoryId: categoryId);
});
