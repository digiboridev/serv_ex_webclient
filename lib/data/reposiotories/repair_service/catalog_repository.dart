import 'package:serv_expert_webclient/data/models/repair_service/category.dart';
import 'package:serv_expert_webclient/services/api_client.dart';

abstract class CatalogRepository {
  Future<RSCategory> categoryById({required String categoryId});
  Future<List<RSCategory>> mainCategories();
  Future<List<RSCategory>> subCategories({required String parentId});
}

class CatalogRepositoryHttpImpl implements CatalogRepository {
  CatalogRepositoryHttpImpl({required ApiClient apiClient}) : _apiClient = apiClient;
  ApiClient _apiClient;

  @override
  Future<RSCategory> categoryById({required String categoryId}) async {
    final response = await _apiClient.get('/catalog/category/$categoryId');
    return RSCategory.fromMap(response);
  }

  @override
  Future<List<RSCategory>> mainCategories() async {
    final response = await _apiClient.get('/catalog/category');
    return (response as List).map((e) => RSCategory.fromMap(e)).toList();
  }

  @override
  Future<List<RSCategory>> subCategories({String? parentId}) async {
    final response = await _apiClient.get('/catalog/category/$parentId/children');
    return (response as List).map((e) => RSCategory.fromMap(e)).toList();
  }
}
