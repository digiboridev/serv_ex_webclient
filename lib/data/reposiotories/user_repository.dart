import 'dart:async';
import 'package:serv_expert_webclient/data/dto/repair_service/new_contact.dart';
import 'package:serv_expert_webclient/data/models/user/app_user.dart';
import 'package:serv_expert_webclient/data/models/user/user_contact.dart';
import 'package:serv_expert_webclient/services/api_client.dart';

abstract class UserRepository {
  Future<AppUser> appUser();
  Future<List<AppUserContact>> userContacts();
  Future<List<AppUserContact>> updateUserContacts({required List<NewContactDTO> contacts});
  Future<AppUser> findAppUserByEmailOrPhone({required String emailOrPhone});
}

class UserRepositoryHttpImpl implements UserRepository {
  final ApiClient _apiClient = ApiClient();

  @override
  Future<AppUser> appUser() async {
    final response = await _apiClient.get('/user/me');
    return AppUser.fromMap(response);
  }

  @override
  Future<List<AppUserContact>> userContacts() async {
    List response = await _apiClient.get('/user/contacts');
    return response.map((e) => AppUserContact.fromMap(e)).toList();
  }

  @override
  Future<List<AppUserContact>> updateUserContacts({required List<NewContactDTO> contacts}) async {
    List response = await _apiClient.post('/user/update-contacts', data: contacts.map((e) => e.toMap()).toList());
    return response.map((e) => AppUserContact.fromMap(e)).toList();
  }

  @override
  Future<AppUser> findAppUserByEmailOrPhone({required String emailOrPhone}) async {
    final response = await _apiClient.get('/user/findByPhoneOrEmail', queryParameters: {'phoneOrEmail': emailOrPhone});
    return AppUser.fromMap(response);
  }
}
