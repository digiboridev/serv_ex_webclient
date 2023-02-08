import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/data/reposiotories/clients_repository.dart';
import 'package:serv_expert_webclient/data/reposiotories/companies_repository.dart';
import 'package:serv_expert_webclient/data/reposiotories/repair_service/breaking_types_repository.dart';
import 'package:serv_expert_webclient/data/reposiotories/repair_service/categories_repository.dart';
import 'package:serv_expert_webclient/data/reposiotories/repair_service/vendors_repository.dart';
import 'package:serv_expert_webclient/services/fireauth.dart';

// -- Repositories
final clientsRepositoryProvider = Provider<ClientsRepository>((ref) {
  return ClientsRepository();
});
final companiesRepositoryProvider = Provider<CompaniesRepository>((ref) {
  return CompaniesRepository();
});

final rsVendorsRepositoryProvider = Provider<RSVendorsRepository>((ref) {
  return RSVendorsRepository();
});

final rsCategoriesRepositoryProvider = Provider<RSCategoriesRepository>((ref) {
  return RSCategoriesRepository();
});

final rsBreakingTypesRepositoryProvider = Provider<RSBreakingTypesRepository>((ref) {
  return RSBreakingTypesRepository();
});

// -- Services
final fireAuthServiceProvider = Provider<FireAuthService>((ref) {
  return FireAuthService();
});
