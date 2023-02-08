// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:serv_expert_webclient/data/models/client/client.dart';
import 'package:serv_expert_webclient/data/models/company/company.dart';
import 'package:serv_expert_webclient/ui/app_providers.dart';

abstract class ContributorState {}

class CSUnassigned extends ContributorState {
  @override
  String toString() => 'CSUnassigned';
}

abstract class CSAssigned extends ContributorState {
  String get name;
}

class CSAssignedAsCompany extends CSAssigned with EquatableMixin {
  final Company company;
  CSAssignedAsCompany(this.company);

  @override
  List<Object> get props => [company];

  @override
  bool get stringify => true;

  @override
  String get name => company.name;
}

class CSAssignedAsClient extends CSAssigned with EquatableMixin {
  final Client client;
  CSAssignedAsClient(this.client);

  @override
  List<Object> get props => [client];

  @override
  bool get stringify => true;

  @override
  String get name => '${client.firstName} ${client.lastName}';
}

class ContributorController extends StateNotifier<ContributorState> {
  ContributorController({required AutoDisposeStateNotifierProviderRef ref})
      : _ref = ref,
        super(CSUnassigned()) {
    ref.listen(currentClientStreamProvider, (previous, next) {
      fetchState();
    });

    ref.listen(companiesStreamProvider, (previous, next) {
      fetchState();
    });
    fetchState();
  }

  final AutoDisposeStateNotifierProviderRef _ref;
  final _storage = GetStorage();

  setClientContributor({required Client client}) {
    _storage.write('contributor', client.id);
    state = CSAssignedAsClient(client);
  }

  setCompanyContributor({required Company company}) {
    _storage.write('contributor', company.id);
    state = CSAssignedAsCompany(company);
  }

  clearContributor() {
    _storage.remove('contributor');
    state = CSUnassigned();
  }

  Future fetchState() async {
    String? contributorId = _storage.read('contributor');

    if (contributorId != null) {
      Client? client = await _ref.read(currentClientStreamProvider.future);
      List<Company> companies = await _ref.read(companiesStreamProvider.future);

      if (client != null && client.id == contributorId) {
        state = CSAssignedAsClient(client);
      }

      for (Company c in companies) {
        if (c.id == contributorId) {
          state = CSAssignedAsCompany(c);
          break;
        }
      }
    }
  }
}
