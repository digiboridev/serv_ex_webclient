// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i21;
import 'package:flutter/material.dart' as _i22;

import 'app_wrapper.dart' as _i2;
import 'router.dart' as _i23;
import 'screens/auth/auth_screen.dart' as _i1;
import 'screens/auth/subpages/client_contacts.dart' as _i6;
import 'screens/auth/subpages/client_details.dart' as _i5;
import 'screens/auth/subpages/company_members.dart' as _i8;
import 'screens/auth/subpages/company_registration.dart' as _i7;
import 'screens/auth/subpages/confirm_phone.dart' as _i4;
import 'screens/auth/subpages/data_error.dart' as _i9;
import 'screens/auth/subpages/sign_in.dart' as _i3;
import 'screens/auth/subpages/success.dart' as _i10;
import 'screens/contributor_select_screen.dart' as _i11;
import 'screens/debug_screen.dart' as _i18;
import 'screens/home_screen.dart' as _i12;
import 'screens/profile/profile_screen.dart' as _i17;
import 'screens/profile/subpages/client_info.dart' as _i19;
import 'screens/profile/subpages/companies_info.dart' as _i20;
import 'screens/repair_service/vendor_breaking_types_screen.dart' as _i16;
import 'screens/repair_service/vendor_categories_screen.dart' as _i14;
import 'screens/repair_service/vendor_subcategories_screen.dart' as _i15;
import 'screens/repair_service/vendors_screen.dart' as _i13;

class AppRouter extends _i21.RootStackRouter {
  AppRouter({
    _i22.GlobalKey<_i22.NavigatorState>? navigatorKey,
    required this.appGuard,
    required this.contributorGuard,
  }) : super(navigatorKey);

  final _i23.AppGuard appGuard;

  final _i23.ContributorGuard contributorGuard;

  @override
  final Map<String, _i21.PageFactory> pagesMap = {
    AuthScreenRoute.name: (routeData) {
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.AuthScreen(),
      );
    },
    App.name: (routeData) {
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.AppWrapper(),
      );
    },
    AsSignIn.name: (routeData) {
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.AuthSignIn(),
      );
    },
    AsConfirmPhone.name: (routeData) {
      final args = routeData.argsAs<AsConfirmPhoneArgs>();
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i4.AuthConfirmPhone(
          key: args.key,
          phone: args.phone,
        ),
      );
    },
    AsClientDetails.name: (routeData) {
      final args = routeData.argsAs<AsClientDetailsArgs>(
          orElse: () => const AsClientDetailsArgs());
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.AuthClientDetails(
          key: args.key,
          phone: args.phone,
          firstName: args.firstName,
          lastName: args.lastName,
          email: args.email,
        ),
      );
    },
    AsClientContacts.name: (routeData) {
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.AuthClientContacts(),
      );
    },
    AsCompanyCreate.name: (routeData) {
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.AuthCompanyCreate(),
      );
    },
    AsCompanyMembers.name: (routeData) {
      final args = routeData.argsAs<AsCompanyMembersArgs>();
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i8.AuthCompanyMembers(
          key: args.key,
          membersIds: args.membersIds,
        ),
      );
    },
    AsDataError.name: (routeData) {
      final args = routeData.argsAs<AsDataErrorArgs>();
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i9.AuthDataError(
          key: args.key,
          error: args.error,
        ),
      );
    },
    AsSuccess.name: (routeData) {
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i10.AuthSucces(),
      );
    },
    ContributorSelectScreenRoute.name: (routeData) {
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i11.ContributorSelectScreen(),
      );
    },
    HomeScreenRoute.name: (routeData) {
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i12.HomeScreen(),
      );
    },
    RepairServiceVendorsScreenRoute.name: (routeData) {
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i13.RepairServiceVendorsScreen(),
      );
    },
    RSVendorCategoriesScreenRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<RSVendorCategoriesScreenRouteArgs>(
          orElse: () => RSVendorCategoriesScreenRouteArgs(
              vendorId: queryParams.optString('vendorId')));
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i14.RSVendorCategoriesScreen(
          key: args.key,
          vendorId: args.vendorId,
        ),
      );
    },
    RSVendorSubCategoriesScreenRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<RSVendorSubCategoriesScreenRouteArgs>(
          orElse: () => RSVendorSubCategoriesScreenRouteArgs(
                vendorId: queryParams.optString('vendorId'),
                categoryId: queryParams.optString('categoryId'),
              ));
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i15.RSVendorSubCategoriesScreen(
          key: args.key,
          vendorId: args.vendorId,
          categoryId: args.categoryId,
        ),
      );
    },
    RSVendorBreakingTypesScreenRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<RSVendorBreakingTypesScreenRouteArgs>(
          orElse: () => RSVendorBreakingTypesScreenRouteArgs(
                vendorId: queryParams.optString('vendorId'),
                categoryId: queryParams.optString('categoryId'),
              ));
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i16.RSVendorBreakingTypesScreen(
          key: args.key,
          vendorId: args.vendorId,
          categoryId: args.categoryId,
        ),
      );
    },
    ProfileScreenRoute.name: (routeData) {
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i17.ProfileScreen(),
      );
    },
    SBRoute.name: (routeData) {
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i18.SB(),
      );
    },
    ClientInfoPageRoute.name: (routeData) {
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i19.ClientInfoPage(),
      );
    },
    CompaniesInfoPageRoute.name: (routeData) {
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i20.CompaniesInfoPage(),
      );
    },
  };

  @override
  List<_i21.RouteConfig> get routes => [
        _i21.RouteConfig(
          AuthScreenRoute.name,
          path: '/auth',
          children: [
            _i21.RouteConfig(
              AsSignIn.name,
              path: 'signin',
              parent: AuthScreenRoute.name,
              usesPathAsKey: true,
            ),
            _i21.RouteConfig(
              AsConfirmPhone.name,
              path: 'confirm_phone',
              parent: AuthScreenRoute.name,
              usesPathAsKey: true,
            ),
            _i21.RouteConfig(
              AsClientDetails.name,
              path: 'client_details',
              parent: AuthScreenRoute.name,
              usesPathAsKey: true,
            ),
            _i21.RouteConfig(
              AsClientContacts.name,
              path: 'client_contacts',
              parent: AuthScreenRoute.name,
              usesPathAsKey: true,
            ),
            _i21.RouteConfig(
              AsCompanyCreate.name,
              path: 'company_create',
              parent: AuthScreenRoute.name,
              usesPathAsKey: true,
            ),
            _i21.RouteConfig(
              AsCompanyMembers.name,
              path: 'company_members',
              parent: AuthScreenRoute.name,
              usesPathAsKey: true,
            ),
            _i21.RouteConfig(
              AsDataError.name,
              path: 'data_error',
              parent: AuthScreenRoute.name,
              usesPathAsKey: true,
            ),
            _i21.RouteConfig(
              AsSuccess.name,
              path: 'succes',
              parent: AuthScreenRoute.name,
              usesPathAsKey: true,
            ),
          ],
        ),
        _i21.RouteConfig(
          App.name,
          path: '/',
          guards: [appGuard],
          children: [
            _i21.RouteConfig(
              '#redirect',
              path: '',
              parent: App.name,
              redirectTo: 'home',
              fullMatch: true,
            ),
            _i21.RouteConfig(
              ContributorSelectScreenRoute.name,
              path: 'contributor_select',
              parent: App.name,
            ),
            _i21.RouteConfig(
              HomeScreenRoute.name,
              path: 'home',
              parent: App.name,
              guards: [contributorGuard],
            ),
            _i21.RouteConfig(
              RepairServiceVendorsScreenRoute.name,
              path: 'repair_vendors',
              parent: App.name,
              guards: [contributorGuard],
            ),
            _i21.RouteConfig(
              RSVendorCategoriesScreenRoute.name,
              path: 'vendor_cat',
              parent: App.name,
              guards: [contributorGuard],
            ),
            _i21.RouteConfig(
              RSVendorSubCategoriesScreenRoute.name,
              path: 'vendor_subcat',
              parent: App.name,
              guards: [contributorGuard],
            ),
            _i21.RouteConfig(
              RSVendorBreakingTypesScreenRoute.name,
              path: 'vendor_breakings',
              parent: App.name,
              guards: [contributorGuard],
            ),
            _i21.RouteConfig(
              ProfileScreenRoute.name,
              path: 'profile',
              parent: App.name,
              guards: [contributorGuard],
              children: [
                _i21.RouteConfig(
                  '#redirect',
                  path: '',
                  parent: ProfileScreenRoute.name,
                  redirectTo: 'client_info',
                  fullMatch: true,
                ),
                _i21.RouteConfig(
                  ClientInfoPageRoute.name,
                  path: 'client_info',
                  parent: ProfileScreenRoute.name,
                ),
                _i21.RouteConfig(
                  CompaniesInfoPageRoute.name,
                  path: 'companies_info',
                  parent: ProfileScreenRoute.name,
                ),
              ],
            ),
            _i21.RouteConfig(
              SBRoute.name,
              path: 'b',
              parent: App.name,
            ),
          ],
        ),
      ];
}

/// generated route for
/// [_i1.AuthScreen]
class AuthScreenRoute extends _i21.PageRouteInfo<void> {
  const AuthScreenRoute({List<_i21.PageRouteInfo>? children})
      : super(
          AuthScreenRoute.name,
          path: '/auth',
          initialChildren: children,
        );

  static const String name = 'AuthScreenRoute';
}

/// generated route for
/// [_i2.AppWrapper]
class App extends _i21.PageRouteInfo<void> {
  const App({List<_i21.PageRouteInfo>? children})
      : super(
          App.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'App';
}

/// generated route for
/// [_i3.AuthSignIn]
class AsSignIn extends _i21.PageRouteInfo<void> {
  const AsSignIn()
      : super(
          AsSignIn.name,
          path: 'signin',
        );

  static const String name = 'AsSignIn';
}

/// generated route for
/// [_i4.AuthConfirmPhone]
class AsConfirmPhone extends _i21.PageRouteInfo<AsConfirmPhoneArgs> {
  AsConfirmPhone({
    _i22.Key? key,
    required String phone,
  }) : super(
          AsConfirmPhone.name,
          path: 'confirm_phone',
          args: AsConfirmPhoneArgs(
            key: key,
            phone: phone,
          ),
        );

  static const String name = 'AsConfirmPhone';
}

class AsConfirmPhoneArgs {
  const AsConfirmPhoneArgs({
    this.key,
    required this.phone,
  });

  final _i22.Key? key;

  final String phone;

  @override
  String toString() {
    return 'AsConfirmPhoneArgs{key: $key, phone: $phone}';
  }
}

/// generated route for
/// [_i5.AuthClientDetails]
class AsClientDetails extends _i21.PageRouteInfo<AsClientDetailsArgs> {
  AsClientDetails({
    _i22.Key? key,
    String? phone,
    String? firstName,
    String? lastName,
    String? email,
  }) : super(
          AsClientDetails.name,
          path: 'client_details',
          args: AsClientDetailsArgs(
            key: key,
            phone: phone,
            firstName: firstName,
            lastName: lastName,
            email: email,
          ),
        );

  static const String name = 'AsClientDetails';
}

class AsClientDetailsArgs {
  const AsClientDetailsArgs({
    this.key,
    this.phone,
    this.firstName,
    this.lastName,
    this.email,
  });

  final _i22.Key? key;

  final String? phone;

  final String? firstName;

  final String? lastName;

  final String? email;

  @override
  String toString() {
    return 'AsClientDetailsArgs{key: $key, phone: $phone, firstName: $firstName, lastName: $lastName, email: $email}';
  }
}

/// generated route for
/// [_i6.AuthClientContacts]
class AsClientContacts extends _i21.PageRouteInfo<void> {
  const AsClientContacts()
      : super(
          AsClientContacts.name,
          path: 'client_contacts',
        );

  static const String name = 'AsClientContacts';
}

/// generated route for
/// [_i7.AuthCompanyCreate]
class AsCompanyCreate extends _i21.PageRouteInfo<void> {
  const AsCompanyCreate()
      : super(
          AsCompanyCreate.name,
          path: 'company_create',
        );

  static const String name = 'AsCompanyCreate';
}

/// generated route for
/// [_i8.AuthCompanyMembers]
class AsCompanyMembers extends _i21.PageRouteInfo<AsCompanyMembersArgs> {
  AsCompanyMembers({
    _i22.Key? key,
    required List<String> membersIds,
  }) : super(
          AsCompanyMembers.name,
          path: 'company_members',
          args: AsCompanyMembersArgs(
            key: key,
            membersIds: membersIds,
          ),
        );

  static const String name = 'AsCompanyMembers';
}

class AsCompanyMembersArgs {
  const AsCompanyMembersArgs({
    this.key,
    required this.membersIds,
  });

  final _i22.Key? key;

  final List<String> membersIds;

  @override
  String toString() {
    return 'AsCompanyMembersArgs{key: $key, membersIds: $membersIds}';
  }
}

/// generated route for
/// [_i9.AuthDataError]
class AsDataError extends _i21.PageRouteInfo<AsDataErrorArgs> {
  AsDataError({
    _i22.Key? key,
    required String error,
  }) : super(
          AsDataError.name,
          path: 'data_error',
          args: AsDataErrorArgs(
            key: key,
            error: error,
          ),
        );

  static const String name = 'AsDataError';
}

class AsDataErrorArgs {
  const AsDataErrorArgs({
    this.key,
    required this.error,
  });

  final _i22.Key? key;

  final String error;

  @override
  String toString() {
    return 'AsDataErrorArgs{key: $key, error: $error}';
  }
}

/// generated route for
/// [_i10.AuthSucces]
class AsSuccess extends _i21.PageRouteInfo<void> {
  const AsSuccess()
      : super(
          AsSuccess.name,
          path: 'succes',
        );

  static const String name = 'AsSuccess';
}

/// generated route for
/// [_i11.ContributorSelectScreen]
class ContributorSelectScreenRoute extends _i21.PageRouteInfo<void> {
  const ContributorSelectScreenRoute()
      : super(
          ContributorSelectScreenRoute.name,
          path: 'contributor_select',
        );

  static const String name = 'ContributorSelectScreenRoute';
}

/// generated route for
/// [_i12.HomeScreen]
class HomeScreenRoute extends _i21.PageRouteInfo<void> {
  const HomeScreenRoute()
      : super(
          HomeScreenRoute.name,
          path: 'home',
        );

  static const String name = 'HomeScreenRoute';
}

/// generated route for
/// [_i13.RepairServiceVendorsScreen]
class RepairServiceVendorsScreenRoute extends _i21.PageRouteInfo<void> {
  const RepairServiceVendorsScreenRoute()
      : super(
          RepairServiceVendorsScreenRoute.name,
          path: 'repair_vendors',
        );

  static const String name = 'RepairServiceVendorsScreenRoute';
}

/// generated route for
/// [_i14.RSVendorCategoriesScreen]
class RSVendorCategoriesScreenRoute
    extends _i21.PageRouteInfo<RSVendorCategoriesScreenRouteArgs> {
  RSVendorCategoriesScreenRoute({
    _i22.Key? key,
    required String? vendorId,
  }) : super(
          RSVendorCategoriesScreenRoute.name,
          path: 'vendor_cat',
          args: RSVendorCategoriesScreenRouteArgs(
            key: key,
            vendorId: vendorId,
          ),
          rawQueryParams: {'vendorId': vendorId},
        );

  static const String name = 'RSVendorCategoriesScreenRoute';
}

class RSVendorCategoriesScreenRouteArgs {
  const RSVendorCategoriesScreenRouteArgs({
    this.key,
    required this.vendorId,
  });

  final _i22.Key? key;

  final String? vendorId;

  @override
  String toString() {
    return 'RSVendorCategoriesScreenRouteArgs{key: $key, vendorId: $vendorId}';
  }
}

/// generated route for
/// [_i15.RSVendorSubCategoriesScreen]
class RSVendorSubCategoriesScreenRoute
    extends _i21.PageRouteInfo<RSVendorSubCategoriesScreenRouteArgs> {
  RSVendorSubCategoriesScreenRoute({
    _i22.Key? key,
    required String? vendorId,
    required String? categoryId,
  }) : super(
          RSVendorSubCategoriesScreenRoute.name,
          path: 'vendor_subcat',
          args: RSVendorSubCategoriesScreenRouteArgs(
            key: key,
            vendorId: vendorId,
            categoryId: categoryId,
          ),
          rawQueryParams: {
            'vendorId': vendorId,
            'categoryId': categoryId,
          },
        );

  static const String name = 'RSVendorSubCategoriesScreenRoute';
}

class RSVendorSubCategoriesScreenRouteArgs {
  const RSVendorSubCategoriesScreenRouteArgs({
    this.key,
    required this.vendorId,
    required this.categoryId,
  });

  final _i22.Key? key;

  final String? vendorId;

  final String? categoryId;

  @override
  String toString() {
    return 'RSVendorSubCategoriesScreenRouteArgs{key: $key, vendorId: $vendorId, categoryId: $categoryId}';
  }
}

/// generated route for
/// [_i16.RSVendorBreakingTypesScreen]
class RSVendorBreakingTypesScreenRoute
    extends _i21.PageRouteInfo<RSVendorBreakingTypesScreenRouteArgs> {
  RSVendorBreakingTypesScreenRoute({
    _i22.Key? key,
    required String? vendorId,
    required String? categoryId,
  }) : super(
          RSVendorBreakingTypesScreenRoute.name,
          path: 'vendor_breakings',
          args: RSVendorBreakingTypesScreenRouteArgs(
            key: key,
            vendorId: vendorId,
            categoryId: categoryId,
          ),
          rawQueryParams: {
            'vendorId': vendorId,
            'categoryId': categoryId,
          },
        );

  static const String name = 'RSVendorBreakingTypesScreenRoute';
}

class RSVendorBreakingTypesScreenRouteArgs {
  const RSVendorBreakingTypesScreenRouteArgs({
    this.key,
    required this.vendorId,
    required this.categoryId,
  });

  final _i22.Key? key;

  final String? vendorId;

  final String? categoryId;

  @override
  String toString() {
    return 'RSVendorBreakingTypesScreenRouteArgs{key: $key, vendorId: $vendorId, categoryId: $categoryId}';
  }
}

/// generated route for
/// [_i17.ProfileScreen]
class ProfileScreenRoute extends _i21.PageRouteInfo<void> {
  const ProfileScreenRoute({List<_i21.PageRouteInfo>? children})
      : super(
          ProfileScreenRoute.name,
          path: 'profile',
          initialChildren: children,
        );

  static const String name = 'ProfileScreenRoute';
}

/// generated route for
/// [_i18.SB]
class SBRoute extends _i21.PageRouteInfo<void> {
  const SBRoute()
      : super(
          SBRoute.name,
          path: 'b',
        );

  static const String name = 'SBRoute';
}

/// generated route for
/// [_i19.ClientInfoPage]
class ClientInfoPageRoute extends _i21.PageRouteInfo<void> {
  const ClientInfoPageRoute()
      : super(
          ClientInfoPageRoute.name,
          path: 'client_info',
        );

  static const String name = 'ClientInfoPageRoute';
}

/// generated route for
/// [_i20.CompaniesInfoPage]
class CompaniesInfoPageRoute extends _i21.PageRouteInfo<void> {
  const CompaniesInfoPageRoute()
      : super(
          CompaniesInfoPageRoute.name,
          path: 'companies_info',
        );

  static const String name = 'CompaniesInfoPageRoute';
}
