// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/app/screens/profile/subpages/orders.dart';
import 'package:serv_expert_webclient/app/screens/repair_service/order/order_details_screen.dart';
import 'package:serv_expert_webclient/app/screens/repair_service/order/order_has_password_screen.dart';
import 'package:serv_expert_webclient/app/screens/repair_service/order/order_password_type_screen.dart';
import 'package:serv_expert_webclient/app/screens/repair_service/order/order_submitted_screen.dart';
import 'package:serv_expert_webclient/app/screens/repair_service/order/order_waranty_screen.dart';
import 'package:serv_expert_webclient/global_providers.dart';
import 'package:serv_expert_webclient/app/app_wrapper.dart';
import 'package:serv_expert_webclient/app/app_providers.dart';
import 'package:serv_expert_webclient/app/controllers/contributor_controller.dart';
import 'package:serv_expert_webclient/router.gr.dart';
import 'package:serv_expert_webclient/auth/auth_screen.dart';
import 'package:serv_expert_webclient/auth/pages/sign_in.dart';
import 'package:serv_expert_webclient/auth/pages/user_contacts.dart';
import 'package:serv_expert_webclient/auth/pages/user_details.dart';
import 'package:serv_expert_webclient/auth/pages/company_registration.dart';
import 'package:serv_expert_webclient/auth/pages/data_error.dart';
import 'package:serv_expert_webclient/auth/pages/confirm_phone.dart';
import 'package:serv_expert_webclient/auth/pages/success.dart';
import 'package:serv_expert_webclient/auth/pages/company_members.dart';
import 'package:serv_expert_webclient/app/screens/contributor_select_screen.dart';
import 'package:serv_expert_webclient/app/screens/debug_screen.dart';
import 'package:serv_expert_webclient/app/screens/home_screen.dart';
import 'package:serv_expert_webclient/app/screens/profile/profile_screen.dart';
import 'package:serv_expert_webclient/app/screens/profile/subpages/user_info.dart';
import 'package:serv_expert_webclient/app/screens/profile/subpages/companies_info.dart';
import 'package:serv_expert_webclient/app/screens/repair_service/breaking_types_screen.dart';
import 'package:serv_expert_webclient/app/screens/repair_service/categories_screen.dart';
import 'package:serv_expert_webclient/app/screens/repair_service/subcategories_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route,Screen',
  routes: <AutoRoute>[
    AutoRoute(
      path: '/auth',
      page: AuthScreen,
      children: [
        AutoRoute(name: 'asSignIn', path: 'signin', page: AuthSignIn, usesPathAsKey: true),
        AutoRoute(name: 'asConfirmPhone', path: 'confirm_phone', page: AuthConfirmPhone, usesPathAsKey: true),
        AutoRoute(name: 'asAppUserDetails', path: 'user_details', page: AuthAppUserDetails, usesPathAsKey: true),
        AutoRoute(name: 'asAppUserContacts', path: 'user_contacts', page: AuthAppUserContacts, usesPathAsKey: true),
        AutoRoute(name: 'asCompanyCreate', path: 'company_create', page: AuthCompanyCreate, usesPathAsKey: true),
        AutoRoute(name: 'asCompanyMembers', path: 'company_members', page: AuthCompanyMembers, usesPathAsKey: true),
        AutoRoute(name: 'asDataError', path: 'data_error', page: AuthDataError, usesPathAsKey: true),
        AutoRoute(name: 'asSuccess', path: 'succes', page: AuthSucces, usesPathAsKey: true),
      ],
    ),
    AutoRoute(
      name: 'app',
      path: '/',
      page: AppWrapper,
      guards: [AppGuard],
      children: [
        RedirectRoute(path: '', redirectTo: 'home'),
        AutoRoute(path: 'contributor_select', page: ContributorSelectScreen),
        AutoRoute(path: 'home', page: HomeScreen, guards: [ContributorGuard]),
        // AutoRoute(path: 'service_vendors', page: RepairServiceVendorsScreen, guards: [ContributorGuard]),
        AutoRoute(path: 'rs_categories', page: RSCategoriesScreen, guards: [ContributorGuard]),
        AutoRoute(path: 'rs_subcategories', page: RSSubCategoriesScreen, guards: [ContributorGuard]),
        AutoRoute(path: 'rs_breaking_types', page: RSBreakingTypesScreen, guards: [ContributorGuard]),
        AutoRoute(path: 'rs_order_details', page: RSOrderDetailsScreen, guards: [ContributorGuard, ServiceOrderGuard]),
        AutoRoute(path: 'rs_order_waranty', page: RSOrderWarantyScreen, guards: [ContributorGuard, ServiceOrderGuard]),
        AutoRoute(path: 'rs_order_haspass', page: RSOrderHasPasswordScreen, guards: [ContributorGuard, ServiceOrderGuard]),
        AutoRoute(path: 'rs_order_passtypes', page: RSOrderPasswordTypeScreen, guards: [ContributorGuard, ServiceOrderGuard]),
        AutoRoute(path: 'rs_order_submitted', page: RSOrderSubmittedScreen, guards: [ContributorGuard]),
        AutoRoute(
          path: 'profile',
          page: ProfileScreen,
          guards: [ContributorGuard],
          children: [
            RedirectRoute(path: '', redirectTo: 'user_info'),
            AutoRoute(path: 'user_info', page: AppUserInfoPage),
            AutoRoute(path: 'companies_info', page: CompaniesInfoPage),
            AutoRoute(path: 'orders', page: OrdersPage),
          ],
        ),
        AutoRoute(path: 'b', page: SB),
      ],
    ),
  ],
)
// extend the generated private router
class $AppRouter {}

class AppGuard extends AutoRouteGuard {
  WidgetRef ref;
  AppGuard({
    required this.ref,
  });

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    bool isUserAuthorized = ref.read(authServiceProvider).authorized;
    if (isUserAuthorized) {
      resolver.next(true);
    } else {
      resolver.next(false);
      router.replaceAll([const AuthScreenRoute()]);
    }
  }
}

class ContributorGuard extends AutoRouteGuard {
  WidgetRef ref;
  ContributorGuard({
    required this.ref,
  });

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    ContributorState contributorState = ref.read(contributorControllerProvider);
    if (contributorState is CSUnassigned) {
      resolver.next(false);
      router.replace(const ContributorSelectScreenRoute());
    } else {
      resolver.next(true);
    }
  }
}

class ServiceOrderGuard extends AutoRouteGuard {
  WidgetRef ref;
  ServiceOrderGuard({
    required this.ref,
  });

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (resolver.route.args == null) {
      resolver.next(false);
      if (router.canNavigateBack) {
        router.navigateBack();
      } else {
        router.replace(const App());
      }
    } else {
      resolver.next(true);
    }
  }
}
