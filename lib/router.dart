// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/app/screens/repair_service/order/order_details_screen.dart';
import 'package:serv_expert_webclient/app/screens/repair_service/order/order_has_password_screen.dart';
import 'package:serv_expert_webclient/app/screens/repair_service/order/order_password_type_screen.dart';
import 'package:serv_expert_webclient/app/screens/repair_service/order/order_submitted_screen.dart';
import 'package:serv_expert_webclient/app/screens/repair_service/order/order_waranty_screen.dart';
import 'package:serv_expert_webclient/global_providers.dart';
import 'package:serv_expert_webclient/app/app_wrapper.dart';
import 'package:serv_expert_webclient/app/app_providers.dart';
import 'package:serv_expert_webclient/app/contributor_controller.dart';
import 'package:serv_expert_webclient/router.gr.dart';
import 'package:serv_expert_webclient/auth/auth_screen.dart';
import 'package:serv_expert_webclient/auth/subpages/sign_in.dart';
import 'package:serv_expert_webclient/auth/subpages/client_contacts.dart';
import 'package:serv_expert_webclient/auth/subpages/client_details.dart';
import 'package:serv_expert_webclient/auth/subpages/company_registration.dart';
import 'package:serv_expert_webclient/auth/subpages/data_error.dart';
import 'package:serv_expert_webclient/auth/subpages/confirm_phone.dart';
import 'package:serv_expert_webclient/auth/subpages/success.dart';
import 'package:serv_expert_webclient/auth/subpages/company_members.dart';
import 'package:serv_expert_webclient/app/screens/contributor_select_screen.dart';
import 'package:serv_expert_webclient/app/screens/debug_screen.dart';
import 'package:serv_expert_webclient/app/screens/home_screen.dart';
import 'package:serv_expert_webclient/app/screens/profile/profile_screen.dart';
import 'package:serv_expert_webclient/app/screens/profile/subpages/client_info.dart';
import 'package:serv_expert_webclient/app/screens/profile/subpages/companies_info.dart';
import 'package:serv_expert_webclient/app/screens/repair_service/vendor_breaking_types_screen.dart';
import 'package:serv_expert_webclient/app/screens/repair_service/vendor_categories_screen.dart';
import 'package:serv_expert_webclient/app/screens/repair_service/vendor_subcategories_screen.dart';
import 'package:serv_expert_webclient/app/screens/repair_service/vendors_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route,Screen',
  routes: <AutoRoute>[
    AutoRoute(
      path: '/auth',
      page: AuthScreen,
      children: [
        AutoRoute(name: 'asSignIn', path: 'signin', page: AuthSignIn, usesPathAsKey: true),
        AutoRoute(name: 'asConfirmPhone', path: 'confirm_phone', page: AuthConfirmPhone, usesPathAsKey: true),
        AutoRoute(name: 'asClientDetails', path: 'client_details', page: AuthClientDetails, usesPathAsKey: true),
        AutoRoute(name: 'asClientContacts', path: 'client_contacts', page: AuthClientContacts, usesPathAsKey: true),
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
        AutoRoute(path: 'service_vendors', page: RepairServiceVendorsScreen, guards: [ContributorGuard]),
        AutoRoute(path: 'vendor_cat', page: RSVendorCategoriesScreen, guards: [ContributorGuard]),
        AutoRoute(path: 'vendor_subcat', page: RSVendorSubCategoriesScreen, guards: [ContributorGuard]),
        AutoRoute(path: 'vendor_breakings', page: RSVendorBreakingTypesScreen, guards: [ContributorGuard]),
        AutoRoute(path: 'service_order_details', page: RSOrderDetailsScreen, guards: [ContributorGuard, ServiceOrderGuard]),
        AutoRoute(path: 'service_order_waranty', page: RSOrderWarantyScreen, guards: [ContributorGuard, ServiceOrderGuard]),
        AutoRoute(path: 'service_order_haspass', page: RSOrderHasPasswordScreen, guards: [ContributorGuard, ServiceOrderGuard]),
        AutoRoute(path: 'service_order_passtypes', page: RSOrderPasswordTypeScreen, guards: [ContributorGuard, ServiceOrderGuard]),
        AutoRoute(path: 'service_order_submitted', page: RSOrderSubmittedScreen, guards: [ContributorGuard]),
        AutoRoute(
          path: 'profile',
          page: ProfileScreen,
          guards: [ContributorGuard],
          children: [
            RedirectRoute(path: '', redirectTo: 'client_info'),
            AutoRoute(path: 'client_info', page: ClientInfoPage),
            AutoRoute(path: 'companies_info', page: CompaniesInfoPage),
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
    bool isUserAuthorized = ref.read(fireAuthServiceProvider).authorized;
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