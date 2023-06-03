import 'package:serv_expert_webclient/data/models/repair_service/category.dart';
import 'package:serv_expert_webclient/data/models/repair_service/issue.dart';
import 'package:serv_expert_webclient/services/api_client.dart';

abstract class CatalogRepository {
  Future<Category> categoryById({required String categoryId});
  Future<List<Category>> mainCategories();
  Future<List<Category>> subCategories({required String parentId});
  Future<List<RSIssue>> issuesByCategory({required String categoryId});
  Future<RSIssue> issueById({required String issueId});
}

class CatalogRepositoryHttpImpl implements CatalogRepository {
  CatalogRepositoryHttpImpl({required ApiClient apiClient}) : _apiClient = apiClient;
  final ApiClient _apiClient;

  @override
  Future<Category> categoryById({required String categoryId}) async {
    final response = await _apiClient.get('/catalog/category/$categoryId');
    return Category.fromMap(response);
  }

  @override
  Future<List<Category>> mainCategories() async {
    final response = await _apiClient.get('/catalog/category');
    return (response as List).map((e) => Category.fromMap(e)).toList();
  }

  @override
  Future<List<Category>> subCategories({String? parentId}) async {
    final response = await _apiClient.get('/catalog/category/$parentId/children');
    return (response as List).map((e) => Category.fromMap(e)).toList();
  }

  @override
  Future<List<RSIssue>> issuesByCategory({required String categoryId}) async {
    final response = await _apiClient.get('/catalog/category/$categoryId/issues');
    return (response as List).map((e) => RSIssue.fromMap(e)).toList();
  }

  @override
  Future<RSIssue> issueById({required String issueId}) async {
    final response = await _apiClient.get('/catalog/issue/$issueId');
    return RSIssue.fromMap(response);
  }
}
