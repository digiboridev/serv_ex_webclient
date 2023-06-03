import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/data/models/repair_service/issue.dart';
import 'package:serv_expert_webclient/data/reposiotories/repair_service/catalog_repository.dart';
import 'package:serv_expert_webclient/global_providers.dart';

final issuesProvider = FutureProvider.autoDispose.family<List<Issue>, String>((ref, categoryId) async {
  CatalogRepository repository = ref.read(catalogRepositoryProvider);
  return repository.issuesByCategory(categoryId: categoryId);
});
