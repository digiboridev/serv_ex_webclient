import 'dart:async';
import 'package:serv_expert_webclient/data/models/user/app_user.dart';
import 'package:serv_expert_webclient/data/api_client.dart';

abstract class UsersRepository {
  Future<AppUser> userById(String appUserId);
  Future<AppUser> userByEmailOrPhone({required String emailOrPhone});
}

class UsersRepositoryHttpImpl implements UsersRepository {
  UsersRepositoryHttpImpl({required ApiClient apiClient}) : _apiClient = apiClient;
  final ApiClient _apiClient;

  @override
  Future<AppUser> userById(String appUserId) async {
    final response = await _apiClient.get('/users/$appUserId');
    return AppUser.fromMap(response);
  }

  @override
  Future<AppUser> userByEmailOrPhone({required String emailOrPhone}) async {
    final response = await _apiClient.get('/users/findByPhoneOrEmail/$emailOrPhone');
    return AppUser.fromMap(response);
  }
}
