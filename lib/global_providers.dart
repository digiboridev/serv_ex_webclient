import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/data/reposiotories/app_users_repository.dart';
import 'package:serv_expert_webclient/data/reposiotories/companies_repository.dart';
import 'package:serv_expert_webclient/data/reposiotories/repair_service/breaking_types_repository.dart';
import 'package:serv_expert_webclient/data/reposiotories/repair_service/categories_repository.dart';
import 'package:serv_expert_webclient/data/reposiotories/repair_service/vendors_repository.dart';
import 'package:serv_expert_webclient/services/auth_service.dart';

// -- Repositories
final appUsersRepositoryProvider = Provider<AppUsersRepository>((ref) {
  return AppUsersRepositoryImpl();
});
final companiesRepositoryProvider = Provider<CompaniesRepository>((ref) {
  return CompaniesRepositoryImpl();
});

final rsVendorsRepositoryProvider = Provider<RSVendorsRepository>((ref) {
  return RSVendorsRepositoryImpl();
});

final rsCategoriesRepositoryProvider = Provider<RSCategoriesRepository>((ref) {
  return RSCategoriesRepositoryImpl();
});

final rsBreakingTypesRepositoryProvider = Provider<RSBreakingTypesRepository>((ref) {
  return RSBreakingTypesRepositoryImpl();
});

// -- Services
final authServiceProvider = Provider<AuthService>((ref) {
  return FireAuthServiceImpl();
});
