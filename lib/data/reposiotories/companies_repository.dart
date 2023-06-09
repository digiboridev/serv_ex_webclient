import 'dart:async';
import 'package:serv_expert_webclient/data/models/company/company.dart';
import 'package:serv_expert_webclient/services/api_client.dart';

abstract class CompaniesRepository {
  Future<List<Company>> userCompanies();
  Future<Company> createCompany({required String publicId, required String name, required String email});
  Future updateCompanyMembers({required String companyId, required List<String> membersIds});
}

class CompaniesRepositoryHttpImpl implements CompaniesRepository {
  CompaniesRepositoryHttpImpl({required ApiClient apiClient}) : _apiClient = apiClient;
  final ApiClient _apiClient;

  @override
  Future<List<Company>> userCompanies() async {
    List response = await _apiClient.get('/companies/user-companies');
    return response.map((e) => Company.fromMap(e)).toList();
  }

  @override
  Future<Company> createCompany({required String publicId, required String name, required String email}) async {
    Map<String, dynamic> response = await _apiClient.post('/companies/create-company', data: {'publicId': publicId, 'name': name, 'email': email});
    return Company.fromMap(response);
  }

  @override
  Future<Company> updateCompanyMembers({required String companyId, required List<String> membersIds}) async {
    Map<String, dynamic> response = await _apiClient.post('/companies/update-members', data: {'companyId': companyId, 'membersIds': membersIds});
    return Company.fromMap(response);
  }
}
