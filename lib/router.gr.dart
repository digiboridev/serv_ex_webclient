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
import 'package:auto_route/auto_route.dart' as _i23;
import 'package:flutter/material.dart' as _i24;

import 'app/app_wrapper.dart' as _i2;
import 'app/screens/contributor_select_screen.dart' as _i11;
import 'app/screens/debug_screen.dart' as _i20;
import 'app/screens/home_screen.dart' as _i12;
import 'app/screens/profile/profile_screen.dart' as _i19;
import 'app/screens/profile/subpages/client_info.dart' as _i21;
import 'app/screens/profile/subpages/companies_info.dart' as _i22;
import 'app/screens/repair_service/order_details_screen.dart' as _i17;
import 'app/screens/repair_service/order_waranty_screen.dart' as _i18;
import 'app/screens/repair_service/vendor_breaking_types_screen.dart' as _i16;
import 'app/screens/repair_service/vendor_categories_screen.dart' as _i14;
import 'app/screens/repair_service/vendor_subcategories_screen.dart' as _i15;
import 'app/screens/repair_service/vendors_screen.dart' as _i13;
import 'auth/auth_screen.dart' as _i1;
import 'auth/subpages/client_contacts.dart' as _i6;
import 'auth/subpages/client_details.dart' as _i5;
import 'auth/subpages/company_members.dart' as _i8;
import 'auth/subpages/company_registration.dart' as _i7;
import 'auth/subpages/confirm_phone.dart' as _i4;
import 'auth/subpages/data_error.dart' as _i9;
import 'auth/subpages/sign_in.dart' as _i3;
import 'auth/subpages/success.dart' as _i10;
import 'data/dto/new_service_order.dart' as _i26;
import 'router.dart' as _i25;

class AppRouter extends _i23.RootStackRouter {
  AppRouter({
    _i24.GlobalKey<_i24.NavigatorState>? navigatorKey,
    required this.appGuard,
    required this.contributorGuard,
    required this.serviceOrderGuard,
  }) : super(navigatorKey);

  final _i25.AppGuard appGuard;

  final _i25.ContributorGuard contributorGuard;

  final _i25.ServiceOrderGuard serviceOrderGuard;

  @override
  final Map<String, _i23.PageFactory> pagesMap = {
    AuthScreenRoute.name: (routeData) {
      return _i23.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.AuthScreen(),
      );
    },
    App.name: (routeData) {
      return _i23.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.AppWrapper(),
      );
    },
    AsSignIn.name: (routeData) {
      return _i23.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.AuthSignIn(),
      );
    },
    AsConfirmPhone.name: (routeData) {
      final args = routeData.argsAs<AsConfirmPhoneArgs>();
      return _i23.MaterialPageX<dynamic>(
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
      return _i23.MaterialPageX<dynamic>(
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
      return _i23.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.AuthClientContacts(),
      );
    },
    AsCompanyCreate.name: (routeData) {
      return _i23.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.AuthCompanyCreate(),
      );
    },
    AsCompanyMembers.name: (routeData) {
      final args = routeData.argsAs<AsCompanyMembersArgs>();
      return _i23.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i8.AuthCompanyMembers(
          key: args.key,
          membersIds: args.membersIds,
        ),
      );
    },
    AsDataError.name: (routeData) {
      final args = routeData.argsAs<AsDataErrorArgs>();
      return _i23.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i9.AuthDataError(
          key: args.key,
          error: args.error,
        ),
      );
    },
    AsSuccess.name: (routeData) {
      return _i23.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i10.AuthSucces(),
      );
    },
    ContributorSelectScreenRoute.name: (routeData) {
      return _i23.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i11.ContributorSelectScreen(),
      );
    },
    HomeScreenRoute.name: (routeData) {
      return _i23.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i12.HomeScreen(),
      );
    },
    RepairServiceVendorsScreenRoute.name: (routeData) {
      return _i23.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i13.RepairServiceVendorsScreen(),
      );
    },
    RSVendorCategoriesScreenRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<RSVendorCategoriesScreenRouteArgs>(
          orElse: () => RSVendorCategoriesScreenRouteArgs(
              vendorId: queryParams.optString('vendorId')));
      return _i23.MaterialPageX<dynamic>(
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
      return _i23.MaterialPageX<dynamic>(
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
      return _i23.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i16.RSVendorBreakingTypesScreen(
          key: args.key,
          vendorId: args.vendorId,
          categoryId: args.categoryId,
        ),
      );
    },
    RSOrderDetailsScreenRoute.name: (routeData) {
      final args = routeData.argsAs<RSOrderDetailsScreenRouteArgs>();
      return _i23.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i17.RSOrderDetailsScreen(
          newServiceOrder: args.newServiceOrder,
          key: args.key,
        ),
      );
    },
    RSOrderWarantyScreenRoute.name: (routeData) {
      final args = routeData.argsAs<RSOrderWarantyScreenRouteArgs>();
      return _i23.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i18.RSOrderWarantyScreen(
          newServiceOrder: args.newServiceOrder,
          key: args.key,
        ),
      );
    },
    ProfileScreenRoute.name: (routeData) {
      return _i23.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i19.ProfileScreen(),
      );
    },
    SBRoute.name: (routeData) {
      return _i23.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i20.SB(),
      );
    },
    ClientInfoPageRoute.name: (routeData) {
      return _i23.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i21.ClientInfoPage(),
      );
    },
    CompaniesInfoPageRoute.name: (routeData) {
      return _i23.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i22.CompaniesInfoPage(),
      );
    },
  };

  @override
  List<_i23.RouteConfig> get routes => [
        _i23.RouteConfig(
          AuthScreenRoute.name,
          path: '/auth',
          children: [
            _i23.RouteConfig(
              AsSignIn.name,
              path: 'signin',
              parent: AuthScreenRoute.name,
              usesPathAsKey: true,
            ),
            _i23.RouteConfig(
              AsConfirmPhone.name,
              path: 'confirm_phone',
              parent: AuthScreenRoute.name,
              usesPathAsKey: true,
            ),
            _i23.RouteConfig(
              AsClientDetails.name,
              path: 'client_details',
              parent: AuthScreenRoute.name,
              usesPathAsKey: true,
            ),
            _i23.RouteConfig(
              AsClientContacts.name,
              path: 'client_contacts',
              parent: AuthScreenRoute.name,
              usesPathAsKey: true,
            ),
            _i23.RouteConfig(
              AsCompanyCreate.name,
              path: 'company_create',
              parent: AuthScreenRoute.name,
              usesPathAsKey: true,
            ),
            _i23.RouteConfig(
              AsCompanyMembers.name,
              path: 'company_members',
              parent: AuthScreenRoute.name,
              usesPathAsKey: true,
            ),
            _i23.RouteConfig(
              AsDataError.name,
              path: 'data_error',
              parent: AuthScreenRoute.name,
              usesPathAsKey: true,
            ),
            _i23.RouteConfig(
              AsSuccess.name,
              path: 'succes',
              parent: AuthScreenRoute.name,
              usesPathAsKey: true,
            ),
          ],
        ),
        _i23.RouteConfig(
          App.name,
          path: '/',
          guards: [appGuard],
          children: [
            _i23.RouteConfig(
              '#redirect',
              path: '',
              parent: App.name,
              redirectTo: 'home',
              fullMatch: true,
            ),
            _i23.RouteConfig(
              ContributorSelectScreenRoute.name,
              path: 'contributor_select',
              parent: App.name,
            ),
            _i23.RouteConfig(
              HomeScreenRoute.name,
              path: 'home',
              parent: App.name,
              guards: [contributorGuard],
            ),
            _i23.RouteConfig(
              RepairServiceVendorsScreenRoute.name,
              path: 'service_vendors',
              parent: App.name,
              guards: [contributorGuard],
            ),
            _i23.RouteConfig(
              RSVendorCategoriesScreenRoute.name,
              path: 'vendor_cat',
              parent: App.name,
              guards: [contributorGuard],
            ),
            _i23.RouteConfig(
              RSVendorSubCategoriesScreenRoute.name,
              path: 'vendor_subcat',
              parent: App.name,
              guards: [contributorGuard],
            ),
            _i23.RouteConfig(
              RSVendorBreakingTypesScreenRoute.name,
              path: 'vendor_breakings',
              parent: App.name,
              guards: [contributorGuard],
            ),
            _i23.RouteConfig(
              RSOrderDetailsScreenRoute.name,
              path: 'service_order_details',
              parent: App.name,
              guards: [
                contributorGuard,
                serviceOrderGuard,
              ],
            ),
            _i23.RouteConfig(
              RSOrderWarantyScreenRoute.name,
              path: 'service_order_waranty',
              parent: App.name,
              guards: [
                contributorGuard,
                serviceOrderGuard,
              ],
            ),
            _i23.RouteConfig(
              ProfileScreenRoute.name,
              path: 'profile',
              parent: App.name,
              guards: [contributorGuard],
              children: [
                _i23.RouteConfig(
                  '#redirect',
                  path: '',
                  parent: ProfileScreenRoute.name,
                  redirectTo: 'client_info',
                  fullMatch: true,
                ),
                _i23.RouteConfig(
                  ClientInfoPageRoute.name,
                  path: 'client_info',
                  parent: ProfileScreenRoute.name,
                ),
                _i23.RouteConfig(
                  CompaniesInfoPageRoute.name,
                  path: 'companies_info',
                  parent: ProfileScreenRoute.name,
                ),
              ],
            ),
            _i23.RouteConfig(
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
class AuthScreenRoute extends _i23.PageRouteInfo<void> {
  const AuthScreenRoute({List<_i23.PageRouteInfo>? children})
      : super(
          AuthScreenRoute.name,
          path: '/auth',
          initialChildren: children,
        );

  static const String name = 'AuthScreenRoute';
}

/// generated route for
/// [_i2.AppWrapper]
class App extends _i23.PageRouteInfo<void> {
  const App({List<_i23.PageRouteInfo>? children})
      : super(
          App.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'App';
}

/// generated route for
/// [_i3.AuthSignIn]
class AsSignIn extends _i23.PageRouteInfo<void> {
  const AsSignIn()
      : super(
          AsSignIn.name,
          path: 'signin',
        );

  static const String name = 'AsSignIn';
}

/// generated route for
/// [_i4.AuthConfirmPhone]
class AsConfirmPhone extends _i23.PageRouteInfo<AsConfirmPhoneArgs> {
  AsConfirmPhone({
    _i24.Key? key,
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

  final _i24.Key? key;

  final String phone;

  @override
  String toString() {
    return 'AsConfirmPhoneArgs{key: $key, phone: $phone}';
  }
}

/// generated route for
/// [_i5.AuthClientDetails]
class AsClientDetails extends _i23.PageRouteInfo<AsClientDetailsArgs> {
  AsClientDetails({
    _i24.Key? key,
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

  final _i24.Key? key;

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
class AsClientContacts extends _i23.PageRouteInfo<void> {
  const AsClientContacts()
      : super(
          AsClientContacts.name,
          path: 'client_contacts',
        );

  static const String name = 'AsClientContacts';
}

/// generated route for
/// [_i7.AuthCompanyCreate]
class AsCompanyCreate extends _i23.PageRouteInfo<void> {
  const AsCompanyCreate()
      : super(
          AsCompanyCreate.name,
          path: 'company_create',
        );

  static const String name = 'AsCompanyCreate';
}

/// generated route for
/// [_i8.AuthCompanyMembers]
class AsCompanyMembers extends _i23.PageRouteInfo<AsCompanyMembersArgs> {
  AsCompanyMembers({
    _i24.Key? key,
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

  final _i24.Key? key;

  final List<String> membersIds;

  @override
  String toString() {
    return 'AsCompanyMembersArgs{key: $key, membersIds: $membersIds}';
  }
}

/// generated route for
/// [_i9.AuthDataError]
class AsDataError extends _i23.PageRouteInfo<AsDataErrorArgs> {
  AsDataError({
    _i24.Key? key,
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

  final _i24.Key? key;

  final String error;

  @override
  String toString() {
    return 'AsDataErrorArgs{key: $key, error: $error}';
  }
}

/// generated route for
/// [_i10.AuthSucces]
class AsSuccess extends _i23.PageRouteInfo<void> {
  const AsSuccess()
      : super(
          AsSuccess.name,
          path: 'succes',
        );

  static const String name = 'AsSuccess';
}

/// generated route for
/// [_i11.ContributorSelectScreen]
class ContributorSelectScreenRoute extends _i23.PageRouteInfo<void> {
  const ContributorSelectScreenRoute()
      : super(
          ContributorSelectScreenRoute.name,
          path: 'contributor_select',
        );

  static const String name = 'ContributorSelectScreenRoute';
}

/// generated route for
/// [_i12.HomeScreen]
class HomeScreenRoute extends _i23.PageRouteInfo<void> {
  const HomeScreenRoute()
      : super(
          HomeScreenRoute.name,
          path: 'home',
        );

  static const String name = 'HomeScreenRoute';
}

/// generated route for
/// [_i13.RepairServiceVendorsScreen]
class RepairServiceVendorsScreenRoute extends _i23.PageRouteInfo<void> {
  const RepairServiceVendorsScreenRoute()
      : super(
          RepairServiceVendorsScreenRoute.name,
          path: 'service_vendors',
        );

  static const String name = 'RepairServiceVendorsScreenRoute';
}

/// generated route for
/// [_i14.RSVendorCategoriesScreen]
class RSVendorCategoriesScreenRoute
    extends _i23.PageRouteInfo<RSVendorCategoriesScreenRouteArgs> {
  RSVendorCategoriesScreenRoute({
    _i24.Key? key,
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

  final _i24.Key? key;

  final String? vendorId;

  @override
  String toString() {
    return 'RSVendorCategoriesScreenRouteArgs{key: $key, vendorId: $vendorId}';
  }
}

/// generated route for
/// [_i15.RSVendorSubCategoriesScreen]
class RSVendorSubCategoriesScreenRoute
    extends _i23.PageRouteInfo<RSVendorSubCategoriesScreenRouteArgs> {
  RSVendorSubCategoriesScreenRoute({
    _i24.Key? key,
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

  final _i24.Key? key;

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
    extends _i23.PageRouteInfo<RSVendorBreakingTypesScreenRouteArgs> {
  RSVendorBreakingTypesScreenRoute({
    _i24.Key? key,
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

  final _i24.Key? key;

  final String? vendorId;

  final String? categoryId;

  @override
  String toString() {
    return 'RSVendorBreakingTypesScreenRouteArgs{key: $key, vendorId: $vendorId, categoryId: $categoryId}';
  }
}

/// generated route for
/// [_i17.RSOrderDetailsScreen]
class RSOrderDetailsScreenRoute
    extends _i23.PageRouteInfo<RSOrderDetailsScreenRouteArgs> {
  RSOrderDetailsScreenRoute({
    required _i26.NewServiceOrder newServiceOrder,
    _i24.Key? key,
  }) : super(
          RSOrderDetailsScreenRoute.name,
          path: 'service_order_details',
          args: RSOrderDetailsScreenRouteArgs(
            newServiceOrder: newServiceOrder,
            key: key,
          ),
        );

  static const String name = 'RSOrderDetailsScreenRoute';
}

class RSOrderDetailsScreenRouteArgs {
  const RSOrderDetailsScreenRouteArgs({
    required this.newServiceOrder,
    this.key,
  });

  final _i26.NewServiceOrder newServiceOrder;

  final _i24.Key? key;

  @override
  String toString() {
    return 'RSOrderDetailsScreenRouteArgs{newServiceOrder: $newServiceOrder, key: $key}';
  }
}

/// generated route for
/// [_i18.RSOrderWarantyScreen]
class RSOrderWarantyScreenRoute
    extends _i23.PageRouteInfo<RSOrderWarantyScreenRouteArgs> {
  RSOrderWarantyScreenRoute({
    required _i26.NewServiceOrder newServiceOrder,
    _i24.Key? key,
  }) : super(
          RSOrderWarantyScreenRoute.name,
          path: 'service_order_waranty',
          args: RSOrderWarantyScreenRouteArgs(
            newServiceOrder: newServiceOrder,
            key: key,
          ),
        );

  static const String name = 'RSOrderWarantyScreenRoute';
}

class RSOrderWarantyScreenRouteArgs {
  const RSOrderWarantyScreenRouteArgs({
    required this.newServiceOrder,
    this.key,
  });

  final _i26.NewServiceOrder newServiceOrder;

  final _i24.Key? key;

  @override
  String toString() {
    return 'RSOrderWarantyScreenRouteArgs{newServiceOrder: $newServiceOrder, key: $key}';
  }
}

/// generated route for
/// [_i19.ProfileScreen]
class ProfileScreenRoute extends _i23.PageRouteInfo<void> {
  const ProfileScreenRoute({List<_i23.PageRouteInfo>? children})
      : super(
          ProfileScreenRoute.name,
          path: 'profile',
          initialChildren: children,
        );

  static const String name = 'ProfileScreenRoute';
}

/// generated route for
/// [_i20.SB]
class SBRoute extends _i23.PageRouteInfo<void> {
  const SBRoute()
      : super(
          SBRoute.name,
          path: 'b',
        );

  static const String name = 'SBRoute';
}

/// generated route for
/// [_i21.ClientInfoPage]
class ClientInfoPageRoute extends _i23.PageRouteInfo<void> {
  const ClientInfoPageRoute()
      : super(
          ClientInfoPageRoute.name,
          path: 'client_info',
        );

  static const String name = 'ClientInfoPageRoute';
}

/// generated route for
/// [_i22.CompaniesInfoPage]
class CompaniesInfoPageRoute extends _i23.PageRouteInfo<void> {
  const CompaniesInfoPageRoute()
      : super(
          CompaniesInfoPageRoute.name,
          path: 'companies_info',
        );

  static const String name = 'CompaniesInfoPageRoute';
}
