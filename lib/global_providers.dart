import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/data/reposiotories/app_users_repository.dart';
import 'package:serv_expert_webclient/data/reposiotories/companies_repository.dart';
import 'package:serv_expert_webclient/data/reposiotories/repair_service/breaking_types_repository.dart';
import 'package:serv_expert_webclient/data/reposiotories/repair_service/categories_repository.dart';
import 'package:serv_expert_webclient/data/reposiotories/repair_service/orders_repository.dart';
import 'package:serv_expert_webclient/services/auth_service.dart';
import 'package:serv_expert_webclient/services/rs_orders_service.dart';

//
// -- Repositories
//

final appUsersRepositoryProvider = Provider<AppUsersRepository>((ref) {
  return AppUsersRepositoryImpl();
});
final companiesRepositoryProvider = Provider<CompaniesRepository>((ref) {
  return CompaniesRepositoryImpl();
});

final rsCategoriesRepositoryProvider = Provider<RSCategoriesRepository>((ref) {
  return RSCategoriesRepositoryImpl();
});

final rsBreakingTypesRepositoryProvider = Provider<RSBreakingTypesRepository>((ref) {
  return RSBreakingTypesRepositoryImpl();
});

final rsOrdersRepositoryProvider = Provider<RSOrdersRepository>((ref) {
  return RSOrdersRepositoryImpl();
});

//
// -- Services
//

final authServiceProvider = Provider<AuthService>((ref) {
  return FireAuthServiceImpl();
});

final rsOrdersServiceProvider = Provider<RSOrdersService>((ref) {
  RSOrdersRepository ordersRepository = ref.read(rsOrdersRepositoryProvider);
  return RSOrdersService(ordersRepository: ordersRepository);
});
