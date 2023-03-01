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
import 'package:auto_route/auto_route.dart' as _i26;
import 'package:flutter/material.dart' as _i27;

import 'app/app_wrapper.dart' as _i2;
import 'app/screens/contributor_select_screen.dart' as _i11;
import 'app/screens/debug_screen.dart' as _i22;
import 'app/screens/home_screen.dart' as _i12;
import 'app/screens/profile/profile_screen.dart' as _i21;
import 'app/screens/profile/subpages/companies_info.dart' as _i24;
import 'app/screens/profile/subpages/orders.dart' as _i25;
import 'app/screens/profile/subpages/user_info.dart' as _i23;
import 'app/screens/repair_service/breaking_types_screen.dart' as _i15;
import 'app/screens/repair_service/categories_screen.dart' as _i13;
import 'app/screens/repair_service/order/order_details_screen.dart' as _i16;
import 'app/screens/repair_service/order/order_has_password_screen.dart'
    as _i18;
import 'app/screens/repair_service/order/order_password_type_screen.dart'
    as _i19;
import 'app/screens/repair_service/order/order_submitted_screen.dart' as _i20;
import 'app/screens/repair_service/order/order_waranty_screen.dart' as _i17;
import 'app/screens/repair_service/subcategories_screen.dart' as _i14;
import 'auth/auth_screen.dart' as _i1;
import 'auth/pages/company_members.dart' as _i8;
import 'auth/pages/company_registration.dart' as _i7;
import 'auth/pages/confirm_phone.dart' as _i4;
import 'auth/pages/data_error.dart' as _i9;
import 'auth/pages/sign_in.dart' as _i3;
import 'auth/pages/success.dart' as _i10;
import 'auth/pages/user_contacts.dart' as _i6;
import 'auth/pages/user_details.dart' as _i5;
import 'data/dto/repair_service/new_order.dart' as _i29;
import 'router.dart' as _i28;

class AppRouter extends _i26.RootStackRouter {
  AppRouter({
    _i27.GlobalKey<_i27.NavigatorState>? navigatorKey,
    required this.appGuard,
    required this.contributorGuard,
    required this.serviceOrderGuard,
  }) : super(navigatorKey);

  final _i28.AppGuard appGuard;

  final _i28.ContributorGuard contributorGuard;

  final _i28.ServiceOrderGuard serviceOrderGuard;

  @override
  final Map<String, _i26.PageFactory> pagesMap = {
    AuthScreenRoute.name: (routeData) {
      return _i26.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.AuthScreen(),
      );
    },
    App.name: (routeData) {
      return _i26.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.AppWrapper(),
      );
    },
    AsSignIn.name: (routeData) {
      return _i26.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.AuthSignIn(),
      );
    },
    AsConfirmPhone.name: (routeData) {
      final args = routeData.argsAs<AsConfirmPhoneArgs>();
      return _i26.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i4.AuthConfirmPhone(
          key: args.key,
          phone: args.phone,
        ),
      );
    },
    AsAppUserDetails.name: (routeData) {
      final args = routeData.argsAs<AsAppUserDetailsArgs>(
          orElse: () => const AsAppUserDetailsArgs());
      return _i26.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.AuthAppUserDetails(
          key: args.key,
          phone: args.phone,
          firstName: args.firstName,
          lastName: args.lastName,
          email: args.email,
        ),
      );
    },
    AsAppUserContacts.name: (routeData) {
      return _i26.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.AuthAppUserContacts(),
      );
    },
    AsCompanyCreate.name: (routeData) {
      return _i26.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.AuthCompanyCreate(),
      );
    },
    AsCompanyMembers.name: (routeData) {
      final args = routeData.argsAs<AsCompanyMembersArgs>();
      return _i26.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i8.AuthCompanyMembers(
          key: args.key,
          membersIds: args.membersIds,
        ),
      );
    },
    AsDataError.name: (routeData) {
      final args = routeData.argsAs<AsDataErrorArgs>();
      return _i26.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i9.AuthDataError(
          key: args.key,
          error: args.error,
        ),
      );
    },
    AsSuccess.name: (routeData) {
      return _i26.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i10.AuthSucces(),
      );
    },
    ContributorSelectScreenRoute.name: (routeData) {
      return _i26.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i11.ContributorSelectScreen(),
      );
    },
    HomeScreenRoute.name: (routeData) {
      return _i26.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i12.HomeScreen(),
      );
    },
    RSCategoriesScreenRoute.name: (routeData) {
      return _i26.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i13.RSCategoriesScreen(),
      );
    },
    RSSubCategoriesScreenRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<RSSubCategoriesScreenRouteArgs>(
          orElse: () => RSSubCategoriesScreenRouteArgs(
              categoryId: queryParams.optString('categoryId')));
      return _i26.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i14.RSSubCategoriesScreen(
          key: args.key,
          categoryId: args.categoryId,
        ),
      );
    },
    RSBreakingTypesScreenRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<RSBreakingTypesScreenRouteArgs>(
          orElse: () => RSBreakingTypesScreenRouteArgs(
              categoryId: queryParams.optString('categoryId')));
      return _i26.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i15.RSBreakingTypesScreen(
          key: args.key,
          categoryId: args.categoryId,
        ),
      );
    },
    RSOrderDetailsScreenRoute.name: (routeData) {
      final args = routeData.argsAs<RSOrderDetailsScreenRouteArgs>();
      return _i26.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i16.RSOrderDetailsScreen(
          newOrder: args.newOrder,
          key: args.key,
        ),
      );
    },
    RSOrderWarantyScreenRoute.name: (routeData) {
      final args = routeData.argsAs<RSOrderWarantyScreenRouteArgs>();
      return _i26.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i17.RSOrderWarantyScreen(
          newOrder: args.newOrder,
          key: args.key,
        ),
      );
    },
    RSOrderHasPasswordScreenRoute.name: (routeData) {
      final args = routeData.argsAs<RSOrderHasPasswordScreenRouteArgs>();
      return _i26.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i18.RSOrderHasPasswordScreen(
          newOrder: args.newOrder,
          key: args.key,
        ),
      );
    },
    RSOrderPasswordTypeScreenRoute.name: (routeData) {
      final args = routeData.argsAs<RSOrderPasswordTypeScreenRouteArgs>();
      return _i26.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i19.RSOrderPasswordTypeScreen(
          newOrder: args.newOrder,
          key: args.key,
        ),
      );
    },
    RSOrderSubmittedScreenRoute.name: (routeData) {
      return _i26.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i20.RSOrderSubmittedScreen(),
      );
    },
    ProfileScreenRoute.name: (routeData) {
      return _i26.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i21.ProfileScreen(),
      );
    },
    SBRoute.name: (routeData) {
      return _i26.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i22.SB(),
      );
    },
    AppUserInfoPageRoute.name: (routeData) {
      return _i26.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i23.AppUserInfoPage(),
      );
    },
    CompaniesInfoPageRoute.name: (routeData) {
      return _i26.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i24.CompaniesInfoPage(),
      );
    },
    OrdersPageRoute.name: (routeData) {
      return _i26.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i25.OrdersPage(),
      );
    },
  };

  @override
  List<_i26.RouteConfig> get routes => [
        _i26.RouteConfig(
          AuthScreenRoute.name,
          path: '/auth',
          children: [
            _i26.RouteConfig(
              AsSignIn.name,
              path: 'signin',
              parent: AuthScreenRoute.name,
              usesPathAsKey: true,
            ),
            _i26.RouteConfig(
              AsConfirmPhone.name,
              path: 'confirm_phone',
              parent: AuthScreenRoute.name,
              usesPathAsKey: true,
            ),
            _i26.RouteConfig(
              AsAppUserDetails.name,
              path: 'user_details',
              parent: AuthScreenRoute.name,
              usesPathAsKey: true,
            ),
            _i26.RouteConfig(
              AsAppUserContacts.name,
              path: 'user_contacts',
              parent: AuthScreenRoute.name,
              usesPathAsKey: true,
            ),
            _i26.RouteConfig(
              AsCompanyCreate.name,
              path: 'company_create',
              parent: AuthScreenRoute.name,
              usesPathAsKey: true,
            ),
            _i26.RouteConfig(
              AsCompanyMembers.name,
              path: 'company_members',
              parent: AuthScreenRoute.name,
              usesPathAsKey: true,
            ),
            _i26.RouteConfig(
              AsDataError.name,
              path: 'data_error',
              parent: AuthScreenRoute.name,
              usesPathAsKey: true,
            ),
            _i26.RouteConfig(
              AsSuccess.name,
              path: 'succes',
              parent: AuthScreenRoute.name,
              usesPathAsKey: true,
            ),
          ],
        ),
        _i26.RouteConfig(
          App.name,
          path: '/',
          guards: [appGuard],
          children: [
            _i26.RouteConfig(
              '#redirect',
              path: '',
              parent: App.name,
              redirectTo: 'home',
              fullMatch: true,
            ),
            _i26.RouteConfig(
              ContributorSelectScreenRoute.name,
              path: 'contributor_select',
              parent: App.name,
            ),
            _i26.RouteConfig(
              HomeScreenRoute.name,
              path: 'home',
              parent: App.name,
              guards: [contributorGuard],
            ),
            _i26.RouteConfig(
              RSCategoriesScreenRoute.name,
              path: 'rs_categories',
              parent: App.name,
              guards: [contributorGuard],
            ),
            _i26.RouteConfig(
              RSSubCategoriesScreenRoute.name,
              path: 'rs_subcategories',
              parent: App.name,
              guards: [contributorGuard],
            ),
            _i26.RouteConfig(
              RSBreakingTypesScreenRoute.name,
              path: 'rs_breaking_types',
              parent: App.name,
              guards: [contributorGuard],
            ),
            _i26.RouteConfig(
              RSOrderDetailsScreenRoute.name,
              path: 'rs_order_details',
              parent: App.name,
              guards: [
                contributorGuard,
                serviceOrderGuard,
              ],
            ),
            _i26.RouteConfig(
              RSOrderWarantyScreenRoute.name,
              path: 'rs_order_waranty',
              parent: App.name,
              guards: [
                contributorGuard,
                serviceOrderGuard,
              ],
            ),
            _i26.RouteConfig(
              RSOrderHasPasswordScreenRoute.name,
              path: 'rs_order_haspass',
              parent: App.name,
              guards: [
                contributorGuard,
                serviceOrderGuard,
              ],
            ),
            _i26.RouteConfig(
              RSOrderPasswordTypeScreenRoute.name,
              path: 'rs_order_passtypes',
              parent: App.name,
              guards: [
                contributorGuard,
                serviceOrderGuard,
              ],
            ),
            _i26.RouteConfig(
              RSOrderSubmittedScreenRoute.name,
              path: 'rs_order_submitted',
              parent: App.name,
              guards: [contributorGuard],
            ),
            _i26.RouteConfig(
              ProfileScreenRoute.name,
              path: 'profile',
              parent: App.name,
              guards: [contributorGuard],
              children: [
                _i26.RouteConfig(
                  '#redirect',
                  path: '',
                  parent: ProfileScreenRoute.name,
                  redirectTo: 'user_info',
                  fullMatch: true,
                ),
                _i26.RouteConfig(
                  AppUserInfoPageRoute.name,
                  path: 'user_info',
                  parent: ProfileScreenRoute.name,
                ),
                _i26.RouteConfig(
                  CompaniesInfoPageRoute.name,
                  path: 'companies_info',
                  parent: ProfileScreenRoute.name,
                ),
                _i26.RouteConfig(
                  OrdersPageRoute.name,
                  path: 'orders',
                  parent: ProfileScreenRoute.name,
                ),
              ],
            ),
            _i26.RouteConfig(
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
class AuthScreenRoute extends _i26.PageRouteInfo<void> {
  const AuthScreenRoute({List<_i26.PageRouteInfo>? children})
      : super(
          AuthScreenRoute.name,
          path: '/auth',
          initialChildren: children,
        );

  static const String name = 'AuthScreenRoute';
}

/// generated route for
/// [_i2.AppWrapper]
class App extends _i26.PageRouteInfo<void> {
  const App({List<_i26.PageRouteInfo>? children})
      : super(
          App.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'App';
}

/// generated route for
/// [_i3.AuthSignIn]
class AsSignIn extends _i26.PageRouteInfo<void> {
  const AsSignIn()
      : super(
          AsSignIn.name,
          path: 'signin',
        );

  static const String name = 'AsSignIn';
}

/// generated route for
/// [_i4.AuthConfirmPhone]
class AsConfirmPhone extends _i26.PageRouteInfo<AsConfirmPhoneArgs> {
  AsConfirmPhone({
    _i27.Key? key,
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

  final _i27.Key? key;

  final String phone;

  @override
  String toString() {
    return 'AsConfirmPhoneArgs{key: $key, phone: $phone}';
  }
}

/// generated route for
/// [_i5.AuthAppUserDetails]
class AsAppUserDetails extends _i26.PageRouteInfo<AsAppUserDetailsArgs> {
  AsAppUserDetails({
    _i27.Key? key,
    String? phone,
    String? firstName,
    String? lastName,
    String? email,
  }) : super(
          AsAppUserDetails.name,
          path: 'user_details',
          args: AsAppUserDetailsArgs(
            key: key,
            phone: phone,
            firstName: firstName,
            lastName: lastName,
            email: email,
          ),
        );

  static const String name = 'AsAppUserDetails';
}

class AsAppUserDetailsArgs {
  const AsAppUserDetailsArgs({
    this.key,
    this.phone,
    this.firstName,
    this.lastName,
    this.email,
  });

  final _i27.Key? key;

  final String? phone;

  final String? firstName;

  final String? lastName;

  final String? email;

  @override
  String toString() {
    return 'AsAppUserDetailsArgs{key: $key, phone: $phone, firstName: $firstName, lastName: $lastName, email: $email}';
  }
}

/// generated route for
/// [_i6.AuthAppUserContacts]
class AsAppUserContacts extends _i26.PageRouteInfo<void> {
  const AsAppUserContacts()
      : super(
          AsAppUserContacts.name,
          path: 'user_contacts',
        );

  static const String name = 'AsAppUserContacts';
}

/// generated route for
/// [_i7.AuthCompanyCreate]
class AsCompanyCreate extends _i26.PageRouteInfo<void> {
  const AsCompanyCreate()
      : super(
          AsCompanyCreate.name,
          path: 'company_create',
        );

  static const String name = 'AsCompanyCreate';
}

/// generated route for
/// [_i8.AuthCompanyMembers]
class AsCompanyMembers extends _i26.PageRouteInfo<AsCompanyMembersArgs> {
  AsCompanyMembers({
    _i27.Key? key,
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

  final _i27.Key? key;

  final List<String> membersIds;

  @override
  String toString() {
    return 'AsCompanyMembersArgs{key: $key, membersIds: $membersIds}';
  }
}

/// generated route for
/// [_i9.AuthDataError]
class AsDataError extends _i26.PageRouteInfo<AsDataErrorArgs> {
  AsDataError({
    _i27.Key? key,
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

  final _i27.Key? key;

  final String error;

  @override
  String toString() {
    return 'AsDataErrorArgs{key: $key, error: $error}';
  }
}

/// generated route for
/// [_i10.AuthSucces]
class AsSuccess extends _i26.PageRouteInfo<void> {
  const AsSuccess()
      : super(
          AsSuccess.name,
          path: 'succes',
        );

  static const String name = 'AsSuccess';
}

/// generated route for
/// [_i11.ContributorSelectScreen]
class ContributorSelectScreenRoute extends _i26.PageRouteInfo<void> {
  const ContributorSelectScreenRoute()
      : super(
          ContributorSelectScreenRoute.name,
          path: 'contributor_select',
        );

  static const String name = 'ContributorSelectScreenRoute';
}

/// generated route for
/// [_i12.HomeScreen]
class HomeScreenRoute extends _i26.PageRouteInfo<void> {
  const HomeScreenRoute()
      : super(
          HomeScreenRoute.name,
          path: 'home',
        );

  static const String name = 'HomeScreenRoute';
}

/// generated route for
/// [_i13.RSCategoriesScreen]
class RSCategoriesScreenRoute extends _i26.PageRouteInfo<void> {
  const RSCategoriesScreenRoute()
      : super(
          RSCategoriesScreenRoute.name,
          path: 'rs_categories',
        );

  static const String name = 'RSCategoriesScreenRoute';
}

/// generated route for
/// [_i14.RSSubCategoriesScreen]
class RSSubCategoriesScreenRoute
    extends _i26.PageRouteInfo<RSSubCategoriesScreenRouteArgs> {
  RSSubCategoriesScreenRoute({
    _i27.Key? key,
    required String? categoryId,
  }) : super(
          RSSubCategoriesScreenRoute.name,
          path: 'rs_subcategories',
          args: RSSubCategoriesScreenRouteArgs(
            key: key,
            categoryId: categoryId,
          ),
          rawQueryParams: {'categoryId': categoryId},
        );

  static const String name = 'RSSubCategoriesScreenRoute';
}

class RSSubCategoriesScreenRouteArgs {
  const RSSubCategoriesScreenRouteArgs({
    this.key,
    required this.categoryId,
  });

  final _i27.Key? key;

  final String? categoryId;

  @override
  String toString() {
    return 'RSSubCategoriesScreenRouteArgs{key: $key, categoryId: $categoryId}';
  }
}

/// generated route for
/// [_i15.RSBreakingTypesScreen]
class RSBreakingTypesScreenRoute
    extends _i26.PageRouteInfo<RSBreakingTypesScreenRouteArgs> {
  RSBreakingTypesScreenRoute({
    _i27.Key? key,
    required String? categoryId,
  }) : super(
          RSBreakingTypesScreenRoute.name,
          path: 'rs_breaking_types',
          args: RSBreakingTypesScreenRouteArgs(
            key: key,
            categoryId: categoryId,
          ),
          rawQueryParams: {'categoryId': categoryId},
        );

  static const String name = 'RSBreakingTypesScreenRoute';
}

class RSBreakingTypesScreenRouteArgs {
  const RSBreakingTypesScreenRouteArgs({
    this.key,
    required this.categoryId,
  });

  final _i27.Key? key;

  final String? categoryId;

  @override
  String toString() {
    return 'RSBreakingTypesScreenRouteArgs{key: $key, categoryId: $categoryId}';
  }
}

/// generated route for
/// [_i16.RSOrderDetailsScreen]
class RSOrderDetailsScreenRoute
    extends _i26.PageRouteInfo<RSOrderDetailsScreenRouteArgs> {
  RSOrderDetailsScreenRoute({
    required _i29.RSNewOrderDTO newOrder,
    _i27.Key? key,
  }) : super(
          RSOrderDetailsScreenRoute.name,
          path: 'rs_order_details',
          args: RSOrderDetailsScreenRouteArgs(
            newOrder: newOrder,
            key: key,
          ),
        );

  static const String name = 'RSOrderDetailsScreenRoute';
}

class RSOrderDetailsScreenRouteArgs {
  const RSOrderDetailsScreenRouteArgs({
    required this.newOrder,
    this.key,
  });

  final _i29.RSNewOrderDTO newOrder;

  final _i27.Key? key;

  @override
  String toString() {
    return 'RSOrderDetailsScreenRouteArgs{newOrder: $newOrder, key: $key}';
  }
}

/// generated route for
/// [_i17.RSOrderWarantyScreen]
class RSOrderWarantyScreenRoute
    extends _i26.PageRouteInfo<RSOrderWarantyScreenRouteArgs> {
  RSOrderWarantyScreenRoute({
    required _i29.RSNewOrderDTO newOrder,
    _i27.Key? key,
  }) : super(
          RSOrderWarantyScreenRoute.name,
          path: 'rs_order_waranty',
          args: RSOrderWarantyScreenRouteArgs(
            newOrder: newOrder,
            key: key,
          ),
        );

  static const String name = 'RSOrderWarantyScreenRoute';
}

class RSOrderWarantyScreenRouteArgs {
  const RSOrderWarantyScreenRouteArgs({
    required this.newOrder,
    this.key,
  });

  final _i29.RSNewOrderDTO newOrder;

  final _i27.Key? key;

  @override
  String toString() {
    return 'RSOrderWarantyScreenRouteArgs{newOrder: $newOrder, key: $key}';
  }
}

/// generated route for
/// [_i18.RSOrderHasPasswordScreen]
class RSOrderHasPasswordScreenRoute
    extends _i26.PageRouteInfo<RSOrderHasPasswordScreenRouteArgs> {
  RSOrderHasPasswordScreenRoute({
    required _i29.RSNewOrderDTO newOrder,
    _i27.Key? key,
  }) : super(
          RSOrderHasPasswordScreenRoute.name,
          path: 'rs_order_haspass',
          args: RSOrderHasPasswordScreenRouteArgs(
            newOrder: newOrder,
            key: key,
          ),
        );

  static const String name = 'RSOrderHasPasswordScreenRoute';
}

class RSOrderHasPasswordScreenRouteArgs {
  const RSOrderHasPasswordScreenRouteArgs({
    required this.newOrder,
    this.key,
  });

  final _i29.RSNewOrderDTO newOrder;

  final _i27.Key? key;

  @override
  String toString() {
    return 'RSOrderHasPasswordScreenRouteArgs{newOrder: $newOrder, key: $key}';
  }
}

/// generated route for
/// [_i19.RSOrderPasswordTypeScreen]
class RSOrderPasswordTypeScreenRoute
    extends _i26.PageRouteInfo<RSOrderPasswordTypeScreenRouteArgs> {
  RSOrderPasswordTypeScreenRoute({
    required _i29.RSNewOrderDTO newOrder,
    _i27.Key? key,
  }) : super(
          RSOrderPasswordTypeScreenRoute.name,
          path: 'rs_order_passtypes',
          args: RSOrderPasswordTypeScreenRouteArgs(
            newOrder: newOrder,
            key: key,
          ),
        );

  static const String name = 'RSOrderPasswordTypeScreenRoute';
}

class RSOrderPasswordTypeScreenRouteArgs {
  const RSOrderPasswordTypeScreenRouteArgs({
    required this.newOrder,
    this.key,
  });

  final _i29.RSNewOrderDTO newOrder;

  final _i27.Key? key;

  @override
  String toString() {
    return 'RSOrderPasswordTypeScreenRouteArgs{newOrder: $newOrder, key: $key}';
  }
}

/// generated route for
/// [_i20.RSOrderSubmittedScreen]
class RSOrderSubmittedScreenRoute extends _i26.PageRouteInfo<void> {
  const RSOrderSubmittedScreenRoute()
      : super(
          RSOrderSubmittedScreenRoute.name,
          path: 'rs_order_submitted',
        );

  static const String name = 'RSOrderSubmittedScreenRoute';
}

/// generated route for
/// [_i21.ProfileScreen]
class ProfileScreenRoute extends _i26.PageRouteInfo<void> {
  const ProfileScreenRoute({List<_i26.PageRouteInfo>? children})
      : super(
          ProfileScreenRoute.name,
          path: 'profile',
          initialChildren: children,
        );

  static const String name = 'ProfileScreenRoute';
}

/// generated route for
/// [_i22.SB]
class SBRoute extends _i26.PageRouteInfo<void> {
  const SBRoute()
      : super(
          SBRoute.name,
          path: 'b',
        );

  static const String name = 'SBRoute';
}

/// generated route for
/// [_i23.AppUserInfoPage]
class AppUserInfoPageRoute extends _i26.PageRouteInfo<void> {
  const AppUserInfoPageRoute()
      : super(
          AppUserInfoPageRoute.name,
          path: 'user_info',
        );

  static const String name = 'AppUserInfoPageRoute';
}

/// generated route for
/// [_i24.CompaniesInfoPage]
class CompaniesInfoPageRoute extends _i26.PageRouteInfo<void> {
  const CompaniesInfoPageRoute()
      : super(
          CompaniesInfoPageRoute.name,
          path: 'companies_info',
        );

  static const String name = 'CompaniesInfoPageRoute';
}

/// generated route for
/// [_i25.OrdersPage]
class OrdersPageRoute extends _i26.PageRouteInfo<void> {
  const OrdersPageRoute()
      : super(
          OrdersPageRoute.name,
          path: 'orders',
        );

  static const String name = 'OrdersPageRoute';
}
