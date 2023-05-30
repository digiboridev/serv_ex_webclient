import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/data/reposiotories/user_repository.dart';
import 'package:serv_expert_webclient/data/reposiotories/companies_repository.dart';
import 'package:serv_expert_webclient/data/reposiotories/repair_service/issues_repository.dart';
import 'package:serv_expert_webclient/data/reposiotories/repair_service/categories_repository.dart';
import 'package:serv_expert_webclient/data/reposiotories/repair_service/orders_repository.dart';
import 'package:serv_expert_webclient/services/api_client.dart';
import 'package:serv_expert_webclient/services/auth_service.dart';
import 'package:serv_expert_webclient/services/rs_orders_service.dart';

//
// -- Repositories
//

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepositoryHttpImpl();
});
final companiesRepositoryProvider = Provider<CompaniesRepository>((ref) {
  return CompaniesRepositoryImpl();
});

final rsCategoriesRepositoryProvider = Provider<RSCategoriesRepository>((ref) {
  return RSCategoriesRepositoryImpl();
});

final rsIssuesRepositoryProvider = Provider<RSIssuesRepository>((ref) {
  return RSIssuesRepositoryImpl();
});

final rsOrdersRepositoryProvider = Provider<RSOrdersRepository>((ref) {
  return RSOrdersRepositoryImpl();
});

//
// -- Services
//

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthServiceHttpImpl(apiClient: ApiClient());
});

final rsOrdersServiceProvider = Provider<RSOrdersService>((ref) {
  RSOrdersRepository ordersRepository = ref.read(rsOrdersRepositoryProvider);
  return RSOrdersService(ordersRepository: ordersRepository);
});
