// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/data/models/repair_service/category.dart';
import 'package:serv_expert_webclient/data/reposiotories/repair_service/categories_repository.dart';
import 'package:serv_expert_webclient/global_providers.dart';

class VCParams extends Equatable {
  final String vendorId;
  final String categoryId;

  const VCParams({required this.vendorId, required this.categoryId});

  @override
  List<Object> get props => [vendorId, categoryId];
}

final vendorCategoryProvider = FutureProvider.autoDispose.family<RSCategory, VCParams>((ref, params) async {
  RSCategoriesRepository repository = ref.read(rsCategoriesRepositoryProvider);
  return repository.vendorCategory(vendorId: params.vendorId, categoryId: params.categoryId);
});
