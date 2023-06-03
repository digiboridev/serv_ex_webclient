import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/data/models/repair_service/issue.dart';
import 'package:serv_expert_webclient/data/reposiotories/repair_service/catalog_repository.dart';
import 'package:serv_expert_webclient/global_providers.dart';

final rsIssueProvider = FutureProvider.autoDispose.family<RSIssue, String>((ref, id) async {
  CatalogRepository repository = ref.read(catalogRepositoryProvider);
  return repository.issueById(issueId: id);
});
