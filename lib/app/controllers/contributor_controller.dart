// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:serv_expert_webclient/data/models/user/app_user.dart';
import 'package:serv_expert_webclient/data/models/company/company.dart';
import 'package:serv_expert_webclient/app/app_providers.dart';

abstract class ContributorState {}

class CSUnassigned extends ContributorState {
  @override
  String toString() => 'CSUnassigned';
}

abstract class CSAssigned extends ContributorState {
  String get name;
  String get id;
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

  @override
  String get id => company.id;
}

class CSAssignedAsAppUser extends CSAssigned with EquatableMixin {
  final AppUser appUser;
  CSAssignedAsAppUser(this.appUser);

  @override
  List<Object> get props => [appUser];

  @override
  bool get stringify => true;

  @override
  String get name => '${appUser.firstName} ${appUser.lastName}';

  @override
  String get id => appUser.id;
}

class ContributorController extends StateNotifier<ContributorState> {
  ContributorController({required AutoDisposeStateNotifierProviderRef ref})
      : _ref = ref,
        super(CSUnassigned()) {
    ref.listen(currentAppUserStreamProvider, (previous, next) {
      fetchState();
    });

    ref.listen(companiesStreamProvider, (previous, next) {
      fetchState();
    });
    fetchState();
  }

  final AutoDisposeStateNotifierProviderRef _ref;
  final _storage = GetStorage();

  setAppUserContributor({required AppUser appUser}) {
    _storage.write('contributor', appUser.id);
    state = CSAssignedAsAppUser(appUser);
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
      AppUser? appUser = await _ref.read(currentAppUserStreamProvider.future);
      List<Company> companies = await _ref.read(companiesStreamProvider.future);

      if (!mounted) return;

      if (appUser != null && appUser.id == contributorId) {
        state = CSAssignedAsAppUser(appUser);
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
