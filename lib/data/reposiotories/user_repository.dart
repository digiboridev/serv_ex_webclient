import 'dart:async';
import 'package:serv_expert_webclient/data/dto/repair_service/new_contact.dart';
import 'package:serv_expert_webclient/data/models/user/app_user.dart';
import 'package:serv_expert_webclient/data/models/user/user_contact.dart';
import 'package:serv_expert_webclient/services/api_client.dart';

abstract class UserRepository {
  Future<AppUser> me();
  Future<List<AppUserContact>> userContacts();
  Future<List<AppUserContact>> updateUserContacts({required List<NewContactDTO> contacts});
}

class UserRepositoryHttpImpl implements UserRepository {
  UserRepositoryHttpImpl({required ApiClient apiClient}) : _apiClient = apiClient;
  final ApiClient _apiClient;

  @override
  Future<AppUser> me() async {
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
}
