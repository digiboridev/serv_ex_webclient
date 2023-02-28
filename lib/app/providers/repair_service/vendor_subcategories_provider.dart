import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/data/models/repair_service/category.dart';
import 'package:serv_expert_webclient/data/reposiotories/repair_service/categories_repository.dart';
import 'package:serv_expert_webclient/global_providers.dart';

class VSCParams extends Equatable {
  final String vendorId;
  final String categoryId;

  const VSCParams(this.vendorId, this.categoryId);

  @override
  List<Object> get props => [vendorId, categoryId];
}

final vendorSubcategoriesProvider = FutureProvider.autoDispose.family<List<RSCategory>, VSCParams>((ref, params) async {
  RSCategoriesRepository repository = ref.read(rsCategoriesRepositoryProvider);
  return repository.vendorCategories(params.vendorId, parentId: params.categoryId);
});
