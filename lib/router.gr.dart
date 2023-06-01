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
import 'package:auto_route/auto_route.dart' as _i29;
import 'package:flutter/material.dart' as _i30;

import 'app/app_wrapper.dart' as _i2;
import 'app/screens/companies/companies_screen.dart' as _i14;
import 'app/screens/contributor_select_screen.dart' as _i11;
import 'app/screens/home/home_wrapper.dart' as _i12;
import 'app/screens/home/rs_catalog/breaking_types_screen.dart' as _i26;
import 'app/screens/home/rs_catalog/categories_screen.dart' as _i24;
import 'app/screens/home/rs_catalog/services_screen.dart' as _i23;
import 'app/screens/home/rs_catalog/subcategories_screen.dart' as _i25;
import 'app/screens/home/rs_ordering/order_details_screen.dart' as _i17;
import 'app/screens/home/rs_ordering/order_has_password_screen.dart' as _i19;
import 'app/screens/home/rs_ordering/order_password_screen.dart' as _i21;
import 'app/screens/home/rs_ordering/order_password_type_screen.dart' as _i20;
import 'app/screens/home/rs_ordering/order_submitted_screen.dart' as _i22;
import 'app/screens/home/rs_ordering/order_waranty_screen.dart' as _i18;
import 'app/screens/order_screen/cancel_page.dart' as _i28;
import 'app/screens/order_screen/loader.dart' as _i16;
import 'app/screens/order_screen/view_page.dart' as _i27;
import 'app/screens/orders/orders_screen.dart' as _i15;
import 'app/screens/profile/profile_screen.dart' as _i13;
import 'auth/auth_screen.dart' as _i1;
import 'auth/pages/company_members.dart' as _i8;
import 'auth/pages/company_registration.dart' as _i7;
import 'auth/pages/confirm_phone.dart' as _i4;
import 'auth/pages/data_error.dart' as _i9;
import 'auth/pages/sign_in.dart' as _i3;
import 'auth/pages/success.dart' as _i10;
import 'auth/pages/user_contacts.dart' as _i6;
import 'auth/pages/user_details.dart' as _i5;
import 'data/dto/repair_service/new_order.dart' as _i32;
import 'router.dart' as _i31;

class AppRouter extends _i29.RootStackRouter {
  AppRouter({
    _i30.GlobalKey<_i30.NavigatorState>? navigatorKey,
    required this.appGuard,
    required this.contributorGuard,
    required this.serviceOrderGuard,
    required this.orderCancellGuard,
  }) : super(navigatorKey);

  final _i31.AppGuard appGuard;

  final _i31.ContributorGuard contributorGuard;

  final _i31.ServiceOrderGuard serviceOrderGuard;

  final _i31.OrderCancellGuard orderCancellGuard;

  @override
  final Map<String, _i29.PageFactory> pagesMap = {
    AuthScreenRoute.name: (routeData) {
      return _i29.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.AuthScreen(),
      );
    },
    App.name: (routeData) {
      return _i29.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.AppWrapper(),
      );
    },
    AsSignIn.name: (routeData) {
      return _i29.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.AuthSignIn(),
      );
    },
    AsConfirmPhone.name: (routeData) {
      final args = routeData.argsAs<AsConfirmPhoneArgs>();
      return _i29.MaterialPageX<dynamic>(
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
      return _i29.MaterialPageX<dynamic>(
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
      return _i29.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.AuthAppUserContacts(),
      );
    },
    AsCompanyCreate.name: (routeData) {
      return _i29.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.AuthCompanyCreate(),
      );
    },
    AsCompanyMembers.name: (routeData) {
      final args = routeData.argsAs<AsCompanyMembersArgs>();
      return _i29.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i8.AuthCompanyMembers(
          key: args.key,
          membersIds: args.membersIds,
        ),
      );
    },
    AsDataError.name: (routeData) {
      final args = routeData.argsAs<AsDataErrorArgs>();
      return _i29.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i9.AuthDataError(
          key: args.key,
          error: args.error,
        ),
      );
    },
    AsSuccess.name: (routeData) {
      return _i29.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i10.AuthSucces(),
      );
    },
    ContributorSelectScreenRoute.name: (routeData) {
      return _i29.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i11.ContributorSelectScreen(),
      );
    },
    Home.name: (routeData) {
      return _i29.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i12.HomeWrapper(),
      );
    },
    ProfileScreenRoute.name: (routeData) {
      return _i29.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i13.ProfileScreen(),
      );
    },
    CompaniesScreenRoute.name: (routeData) {
      return _i29.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i14.CompaniesScreen(),
      );
    },
    OrdersScreenRoute.name: (routeData) {
      return _i29.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i15.OrdersScreen(),
      );
    },
    OrderScreen.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<OrderScreenArgs>(
          orElse: () =>
              OrderScreenArgs(orderId: pathParams.getString('orderId')));
      return _i29.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i16.OrderScreenLoader(
          orderId: args.orderId,
          key: args.key,
        ),
      );
    },
    RSOrderDetailsScreenRoute.name: (routeData) {
      final args = routeData.argsAs<RSOrderDetailsScreenRouteArgs>();
      return _i29.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i17.RSOrderDetailsScreen(
          newOrder: args.newOrder,
          key: args.key,
        ),
      );
    },
    RSOrderWarantyScreenRoute.name: (routeData) {
      final args = routeData.argsAs<RSOrderWarantyScreenRouteArgs>();
      return _i29.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i18.RSOrderWarantyScreen(
          newOrder: args.newOrder,
          key: args.key,
        ),
      );
    },
    RSOrderHasPasswordScreenRoute.name: (routeData) {
      final args = routeData.argsAs<RSOrderHasPasswordScreenRouteArgs>();
      return _i29.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i19.RSOrderHasPasswordScreen(
          newOrder: args.newOrder,
          key: args.key,
        ),
      );
    },
    RSOrderPasswordTypeScreenRoute.name: (routeData) {
      final args = routeData.argsAs<RSOrderPasswordTypeScreenRouteArgs>();
      return _i29.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i20.RSOrderPasswordTypeScreen(
          newOrder: args.newOrder,
          key: args.key,
        ),
      );
    },
    RSOrderPasswordScreenRoute.name: (routeData) {
      final args = routeData.argsAs<RSOrderPasswordScreenRouteArgs>();
      return _i29.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i21.RSOrderPasswordScreen(
          newOrder: args.newOrder,
          key: args.key,
        ),
      );
    },
    RSOrderSubmittedScreenRoute.name: (routeData) {
      return _i29.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i22.RSOrderSubmittedScreen(),
      );
    },
    ServicesScreenRoute.name: (routeData) {
      return _i29.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i23.ServicesScreen(),
      );
    },
    RSCategoriesScreenRoute.name: (routeData) {
      return _i29.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i24.RSCategoriesScreen(),
      );
    },
    RSSubCategoriesScreenRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<RSSubCategoriesScreenRouteArgs>(
          orElse: () => RSSubCategoriesScreenRouteArgs(
              categoryId: pathParams.getString('categoryId')));
      return _i29.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i25.RSSubCategoriesScreen(
          key: args.key,
          categoryId: args.categoryId,
        ),
      );
    },
    RSIssuesScreenRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<RSIssuesScreenRouteArgs>(
          orElse: () => RSIssuesScreenRouteArgs(
              categoryId: pathParams.getString('categoryId')));
      return _i29.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i26.RSIssuesScreen(
          key: args.key,
          categoryId: args.categoryId,
        ),
      );
    },
    OrderScreenViewPageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<OrderScreenViewPageRouteArgs>(
          orElse: () => const OrderScreenViewPageRouteArgs());
      return _i29.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i27.OrderScreenViewPage(
          orderId: pathParams.getString('orderId'),
          key: args.key,
        ),
      );
    },
    OrderCancellPageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<OrderCancellPageRouteArgs>(
          orElse: () => const OrderCancellPageRouteArgs());
      return _i29.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i28.OrderCancellPage(
          orderId: pathParams.getString('orderId'),
          key: args.key,
        ),
      );
    },
  };

  @override
  List<_i29.RouteConfig> get routes => [
        _i29.RouteConfig(
          AuthScreenRoute.name,
          path: '/auth',
          children: [
            _i29.RouteConfig(
              AsSignIn.name,
              path: 'signin',
              parent: AuthScreenRoute.name,
              usesPathAsKey: true,
            ),
            _i29.RouteConfig(
              AsConfirmPhone.name,
              path: 'confirm_phone',
              parent: AuthScreenRoute.name,
              usesPathAsKey: true,
            ),
            _i29.RouteConfig(
              AsAppUserDetails.name,
              path: 'user_details',
              parent: AuthScreenRoute.name,
              usesPathAsKey: true,
            ),
            _i29.RouteConfig(
              AsAppUserContacts.name,
              path: 'user_contacts',
              parent: AuthScreenRoute.name,
              usesPathAsKey: true,
            ),
            _i29.RouteConfig(
              AsCompanyCreate.name,
              path: 'company_create',
              parent: AuthScreenRoute.name,
              usesPathAsKey: true,
            ),
            _i29.RouteConfig(
              AsCompanyMembers.name,
              path: 'company_members',
              parent: AuthScreenRoute.name,
              usesPathAsKey: true,
            ),
            _i29.RouteConfig(
              AsDataError.name,
              path: 'data_error',
              parent: AuthScreenRoute.name,
              usesPathAsKey: true,
            ),
            _i29.RouteConfig(
              AsSuccess.name,
              path: 'succes',
              parent: AuthScreenRoute.name,
              usesPathAsKey: true,
            ),
          ],
        ),
        _i29.RouteConfig(
          App.name,
          path: '/',
          guards: [appGuard],
          children: [
            _i29.RouteConfig(
              '#redirect',
              path: '',
              parent: App.name,
              redirectTo: 'home',
              fullMatch: true,
            ),
            _i29.RouteConfig(
              ContributorSelectScreenRoute.name,
              path: 'contributor_select',
              parent: App.name,
            ),
            _i29.RouteConfig(
              Home.name,
              path: 'home',
              parent: App.name,
              guards: [contributorGuard],
              children: [
                _i29.RouteConfig(
                  '#redirect',
                  path: '',
                  parent: Home.name,
                  redirectTo: 'services',
                  fullMatch: true,
                ),
                _i29.RouteConfig(
                  ServicesScreenRoute.name,
                  path: 'services',
                  parent: Home.name,
                ),
                _i29.RouteConfig(
                  RSCategoriesScreenRoute.name,
                  path: 'rs_categories',
                  parent: Home.name,
                ),
                _i29.RouteConfig(
                  RSSubCategoriesScreenRoute.name,
                  path: 'rs_subcategories/:categoryId',
                  parent: Home.name,
                ),
                _i29.RouteConfig(
                  RSIssuesScreenRoute.name,
                  path: 'rs_issues/:categoryId',
                  parent: Home.name,
                ),
              ],
            ),
            _i29.RouteConfig(
              ProfileScreenRoute.name,
              path: 'profile',
              parent: App.name,
              guards: [contributorGuard],
            ),
            _i29.RouteConfig(
              CompaniesScreenRoute.name,
              path: 'companies',
              parent: App.name,
              guards: [contributorGuard],
            ),
            _i29.RouteConfig(
              OrdersScreenRoute.name,
              path: 'orders',
              parent: App.name,
              guards: [contributorGuard],
            ),
            _i29.RouteConfig(
              OrderScreen.name,
              path: 'order/:orderId',
              parent: App.name,
              children: [
                _i29.RouteConfig(
                  '#redirect',
                  path: '',
                  parent: OrderScreen.name,
                  redirectTo: 'view',
                  fullMatch: true,
                ),
                _i29.RouteConfig(
                  OrderScreenViewPageRoute.name,
                  path: 'view',
                  parent: OrderScreen.name,
                ),
                _i29.RouteConfig(
                  OrderCancellPageRoute.name,
                  path: 'cancell',
                  parent: OrderScreen.name,
                  guards: [orderCancellGuard],
                ),
              ],
            ),
            _i29.RouteConfig(
              RSOrderDetailsScreenRoute.name,
              path: 'rs_order_details',
              parent: App.name,
              guards: [
                contributorGuard,
                serviceOrderGuard,
              ],
            ),
            _i29.RouteConfig(
              RSOrderWarantyScreenRoute.name,
              path: 'rs_order_waranty',
              parent: App.name,
              guards: [
                contributorGuard,
                serviceOrderGuard,
              ],
            ),
            _i29.RouteConfig(
              RSOrderHasPasswordScreenRoute.name,
              path: 'rs_order_haspass',
              parent: App.name,
              guards: [
                contributorGuard,
                serviceOrderGuard,
              ],
            ),
            _i29.RouteConfig(
              RSOrderPasswordTypeScreenRoute.name,
              path: 'rs_order_passtypes',
              parent: App.name,
              guards: [
                contributorGuard,
                serviceOrderGuard,
              ],
            ),
            _i29.RouteConfig(
              RSOrderPasswordScreenRoute.name,
              path: 'rs_order_password',
              parent: App.name,
              guards: [
                contributorGuard,
                serviceOrderGuard,
              ],
            ),
            _i29.RouteConfig(
              RSOrderSubmittedScreenRoute.name,
              path: 'rs_order_submitted',
              parent: App.name,
              guards: [contributorGuard],
            ),
          ],
        ),
      ];
}

/// generated route for
/// [_i1.AuthScreen]
class AuthScreenRoute extends _i29.PageRouteInfo<void> {
  const AuthScreenRoute({List<_i29.PageRouteInfo>? children})
      : super(
          AuthScreenRoute.name,
          path: '/auth',
          initialChildren: children,
        );

  static const String name = 'AuthScreenRoute';
}

/// generated route for
/// [_i2.AppWrapper]
class App extends _i29.PageRouteInfo<void> {
  const App({List<_i29.PageRouteInfo>? children})
      : super(
          App.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'App';
}

/// generated route for
/// [_i3.AuthSignIn]
class AsSignIn extends _i29.PageRouteInfo<void> {
  const AsSignIn()
      : super(
          AsSignIn.name,
          path: 'signin',
        );

  static const String name = 'AsSignIn';
}

/// generated route for
/// [_i4.AuthConfirmPhone]
class AsConfirmPhone extends _i29.PageRouteInfo<AsConfirmPhoneArgs> {
  AsConfirmPhone({
    _i30.Key? key,
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

  final _i30.Key? key;

  final String phone;

  @override
  String toString() {
    return 'AsConfirmPhoneArgs{key: $key, phone: $phone}';
  }
}

/// generated route for
/// [_i5.AuthAppUserDetails]
class AsAppUserDetails extends _i29.PageRouteInfo<AsAppUserDetailsArgs> {
  AsAppUserDetails({
    _i30.Key? key,
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

  final _i30.Key? key;

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
class AsAppUserContacts extends _i29.PageRouteInfo<void> {
  const AsAppUserContacts()
      : super(
          AsAppUserContacts.name,
          path: 'user_contacts',
        );

  static const String name = 'AsAppUserContacts';
}

/// generated route for
/// [_i7.AuthCompanyCreate]
class AsCompanyCreate extends _i29.PageRouteInfo<void> {
  const AsCompanyCreate()
      : super(
          AsCompanyCreate.name,
          path: 'company_create',
        );

  static const String name = 'AsCompanyCreate';
}

/// generated route for
/// [_i8.AuthCompanyMembers]
class AsCompanyMembers extends _i29.PageRouteInfo<AsCompanyMembersArgs> {
  AsCompanyMembers({
    _i30.Key? key,
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

  final _i30.Key? key;

  final List<String> membersIds;

  @override
  String toString() {
    return 'AsCompanyMembersArgs{key: $key, membersIds: $membersIds}';
  }
}

/// generated route for
/// [_i9.AuthDataError]
class AsDataError extends _i29.PageRouteInfo<AsDataErrorArgs> {
  AsDataError({
    _i30.Key? key,
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

  final _i30.Key? key;

  final String error;

  @override
  String toString() {
    return 'AsDataErrorArgs{key: $key, error: $error}';
  }
}

/// generated route for
/// [_i10.AuthSucces]
class AsSuccess extends _i29.PageRouteInfo<void> {
  const AsSuccess()
      : super(
          AsSuccess.name,
          path: 'succes',
        );

  static const String name = 'AsSuccess';
}

/// generated route for
/// [_i11.ContributorSelectScreen]
class ContributorSelectScreenRoute extends _i29.PageRouteInfo<void> {
  const ContributorSelectScreenRoute()
      : super(
          ContributorSelectScreenRoute.name,
          path: 'contributor_select',
        );

  static const String name = 'ContributorSelectScreenRoute';
}

/// generated route for
/// [_i12.HomeWrapper]
class Home extends _i29.PageRouteInfo<void> {
  const Home({List<_i29.PageRouteInfo>? children})
      : super(
          Home.name,
          path: 'home',
          initialChildren: children,
        );

  static const String name = 'Home';
}

/// generated route for
/// [_i13.ProfileScreen]
class ProfileScreenRoute extends _i29.PageRouteInfo<void> {
  const ProfileScreenRoute()
      : super(
          ProfileScreenRoute.name,
          path: 'profile',
        );

  static const String name = 'ProfileScreenRoute';
}

/// generated route for
/// [_i14.CompaniesScreen]
class CompaniesScreenRoute extends _i29.PageRouteInfo<void> {
  const CompaniesScreenRoute()
      : super(
          CompaniesScreenRoute.name,
          path: 'companies',
        );

  static const String name = 'CompaniesScreenRoute';
}

/// generated route for
/// [_i15.OrdersScreen]
class OrdersScreenRoute extends _i29.PageRouteInfo<void> {
  const OrdersScreenRoute()
      : super(
          OrdersScreenRoute.name,
          path: 'orders',
        );

  static const String name = 'OrdersScreenRoute';
}

/// generated route for
/// [_i16.OrderScreenLoader]
class OrderScreen extends _i29.PageRouteInfo<OrderScreenArgs> {
  OrderScreen({
    required String orderId,
    _i30.Key? key,
    List<_i29.PageRouteInfo>? children,
  }) : super(
          OrderScreen.name,
          path: 'order/:orderId',
          args: OrderScreenArgs(
            orderId: orderId,
            key: key,
          ),
          rawPathParams: {'orderId': orderId},
          initialChildren: children,
        );

  static const String name = 'OrderScreen';
}

class OrderScreenArgs {
  const OrderScreenArgs({
    required this.orderId,
    this.key,
  });

  final String orderId;

  final _i30.Key? key;

  @override
  String toString() {
    return 'OrderScreenArgs{orderId: $orderId, key: $key}';
  }
}

/// generated route for
/// [_i17.RSOrderDetailsScreen]
class RSOrderDetailsScreenRoute
    extends _i29.PageRouteInfo<RSOrderDetailsScreenRouteArgs> {
  RSOrderDetailsScreenRoute({
    required _i32.RSNewOrderDTO newOrder,
    _i30.Key? key,
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

  final _i32.RSNewOrderDTO newOrder;

  final _i30.Key? key;

  @override
  String toString() {
    return 'RSOrderDetailsScreenRouteArgs{newOrder: $newOrder, key: $key}';
  }
}

/// generated route for
/// [_i18.RSOrderWarantyScreen]
class RSOrderWarantyScreenRoute
    extends _i29.PageRouteInfo<RSOrderWarantyScreenRouteArgs> {
  RSOrderWarantyScreenRoute({
    required _i32.RSNewOrderDTO newOrder,
    _i30.Key? key,
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

  final _i32.RSNewOrderDTO newOrder;

  final _i30.Key? key;

  @override
  String toString() {
    return 'RSOrderWarantyScreenRouteArgs{newOrder: $newOrder, key: $key}';
  }
}

/// generated route for
/// [_i19.RSOrderHasPasswordScreen]
class RSOrderHasPasswordScreenRoute
    extends _i29.PageRouteInfo<RSOrderHasPasswordScreenRouteArgs> {
  RSOrderHasPasswordScreenRoute({
    required _i32.RSNewOrderDTO newOrder,
    _i30.Key? key,
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

  final _i32.RSNewOrderDTO newOrder;

  final _i30.Key? key;

  @override
  String toString() {
    return 'RSOrderHasPasswordScreenRouteArgs{newOrder: $newOrder, key: $key}';
  }
}

/// generated route for
/// [_i20.RSOrderPasswordTypeScreen]
class RSOrderPasswordTypeScreenRoute
    extends _i29.PageRouteInfo<RSOrderPasswordTypeScreenRouteArgs> {
  RSOrderPasswordTypeScreenRoute({
    required _i32.RSNewOrderDTO newOrder,
    _i30.Key? key,
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

  final _i32.RSNewOrderDTO newOrder;

  final _i30.Key? key;

  @override
  String toString() {
    return 'RSOrderPasswordTypeScreenRouteArgs{newOrder: $newOrder, key: $key}';
  }
}

/// generated route for
/// [_i21.RSOrderPasswordScreen]
class RSOrderPasswordScreenRoute
    extends _i29.PageRouteInfo<RSOrderPasswordScreenRouteArgs> {
  RSOrderPasswordScreenRoute({
    required _i32.RSNewOrderDTO newOrder,
    _i30.Key? key,
  }) : super(
          RSOrderPasswordScreenRoute.name,
          path: 'rs_order_password',
          args: RSOrderPasswordScreenRouteArgs(
            newOrder: newOrder,
            key: key,
          ),
        );

  static const String name = 'RSOrderPasswordScreenRoute';
}

class RSOrderPasswordScreenRouteArgs {
  const RSOrderPasswordScreenRouteArgs({
    required this.newOrder,
    this.key,
  });

  final _i32.RSNewOrderDTO newOrder;

  final _i30.Key? key;

  @override
  String toString() {
    return 'RSOrderPasswordScreenRouteArgs{newOrder: $newOrder, key: $key}';
  }
}

/// generated route for
/// [_i22.RSOrderSubmittedScreen]
class RSOrderSubmittedScreenRoute extends _i29.PageRouteInfo<void> {
  const RSOrderSubmittedScreenRoute()
      : super(
          RSOrderSubmittedScreenRoute.name,
          path: 'rs_order_submitted',
        );

  static const String name = 'RSOrderSubmittedScreenRoute';
}

/// generated route for
/// [_i23.ServicesScreen]
class ServicesScreenRoute extends _i29.PageRouteInfo<void> {
  const ServicesScreenRoute()
      : super(
          ServicesScreenRoute.name,
          path: 'services',
        );

  static const String name = 'ServicesScreenRoute';
}

/// generated route for
/// [_i24.RSCategoriesScreen]
class RSCategoriesScreenRoute extends _i29.PageRouteInfo<void> {
  const RSCategoriesScreenRoute()
      : super(
          RSCategoriesScreenRoute.name,
          path: 'rs_categories',
        );

  static const String name = 'RSCategoriesScreenRoute';
}

/// generated route for
/// [_i25.RSSubCategoriesScreen]
class RSSubCategoriesScreenRoute
    extends _i29.PageRouteInfo<RSSubCategoriesScreenRouteArgs> {
  RSSubCategoriesScreenRoute({
    _i30.Key? key,
    required String categoryId,
  }) : super(
          RSSubCategoriesScreenRoute.name,
          path: 'rs_subcategories/:categoryId',
          args: RSSubCategoriesScreenRouteArgs(
            key: key,
            categoryId: categoryId,
          ),
          rawPathParams: {'categoryId': categoryId},
        );

  static const String name = 'RSSubCategoriesScreenRoute';
}

class RSSubCategoriesScreenRouteArgs {
  const RSSubCategoriesScreenRouteArgs({
    this.key,
    required this.categoryId,
  });

  final _i30.Key? key;

  final String categoryId;

  @override
  String toString() {
    return 'RSSubCategoriesScreenRouteArgs{key: $key, categoryId: $categoryId}';
  }
}

/// generated route for
/// [_i26.RSIssuesScreen]
class RSIssuesScreenRoute extends _i29.PageRouteInfo<RSIssuesScreenRouteArgs> {
  RSIssuesScreenRoute({
    _i30.Key? key,
    required String categoryId,
  }) : super(
          RSIssuesScreenRoute.name,
          path: 'rs_issues/:categoryId',
          args: RSIssuesScreenRouteArgs(
            key: key,
            categoryId: categoryId,
          ),
          rawPathParams: {'categoryId': categoryId},
        );

  static const String name = 'RSIssuesScreenRoute';
}

class RSIssuesScreenRouteArgs {
  const RSIssuesScreenRouteArgs({
    this.key,
    required this.categoryId,
  });

  final _i30.Key? key;

  final String categoryId;

  @override
  String toString() {
    return 'RSIssuesScreenRouteArgs{key: $key, categoryId: $categoryId}';
  }
}

/// generated route for
/// [_i27.OrderScreenViewPage]
class OrderScreenViewPageRoute
    extends _i29.PageRouteInfo<OrderScreenViewPageRouteArgs> {
  OrderScreenViewPageRoute({_i30.Key? key})
      : super(
          OrderScreenViewPageRoute.name,
          path: 'view',
          args: OrderScreenViewPageRouteArgs(key: key),
        );

  static const String name = 'OrderScreenViewPageRoute';
}

class OrderScreenViewPageRouteArgs {
  const OrderScreenViewPageRouteArgs({this.key});

  final _i30.Key? key;

  @override
  String toString() {
    return 'OrderScreenViewPageRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i28.OrderCancellPage]
class OrderCancellPageRoute
    extends _i29.PageRouteInfo<OrderCancellPageRouteArgs> {
  OrderCancellPageRoute({_i30.Key? key})
      : super(
          OrderCancellPageRoute.name,
          path: 'cancell',
          args: OrderCancellPageRouteArgs(key: key),
        );

  static const String name = 'OrderCancellPageRoute';
}

class OrderCancellPageRouteArgs {
  const OrderCancellPageRouteArgs({this.key});

  final _i30.Key? key;

  @override
  String toString() {
    return 'OrderCancellPageRouteArgs{key: $key}';
  }
}
