// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/main.dart';
import 'package:serv_expert_webclient/ui/app_wrapper.dart';
import 'package:serv_expert_webclient/ui/app_providers.dart';
import 'package:serv_expert_webclient/ui/contributor_controller.dart';
import 'package:serv_expert_webclient/router.gr.dart';
import 'package:serv_expert_webclient/ui/screens/auth/auth_screen.dart';
import 'package:serv_expert_webclient/ui/screens/auth/subpages/sign_in.dart';
import 'package:serv_expert_webclient/ui/screens/auth/subpages/client_contacts.dart';
import 'package:serv_expert_webclient/ui/screens/auth/subpages/client_details.dart';
import 'package:serv_expert_webclient/ui/screens/auth/subpages/company_registration.dart';
import 'package:serv_expert_webclient/ui/screens/auth/subpages/data_error.dart';
import 'package:serv_expert_webclient/ui/screens/auth/subpages/confirm_phone.dart';
import 'package:serv_expert_webclient/ui/screens/auth/subpages/success.dart';
import 'package:serv_expert_webclient/ui/screens/auth/subpages/company_members.dart';
import 'package:serv_expert_webclient/ui/screens/contributor_select_screen.dart';
import 'package:serv_expert_webclient/ui/screens/debug_screen.dart';
import 'package:serv_expert_webclient/ui/screens/home_screen.dart';
import 'package:serv_expert_webclient/ui/screens/profile/profile_screen.dart';
import 'package:serv_expert_webclient/ui/screens/profile/subpages/client_info.dart';
import 'package:serv_expert_webclient/ui/screens/profile/subpages/companies_info.dart';
import 'package:serv_expert_webclient/ui/screens/repair_service/vendor_breaking_types_screen.dart';
import 'package:serv_expert_webclient/ui/screens/repair_service/vendor_categories_screen.dart';
import 'package:serv_expert_webclient/ui/screens/repair_service/vendor_subcategories_screen.dart';
import 'package:serv_expert_webclient/ui/screens/repair_service/vendors_screen.dart';

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
        AutoRoute(path: 'repair_vendors', page: RepairServiceVendorsScreen, guards: [ContributorGuard]),
        AutoRoute(path: 'vendor_cat', page: RSVendorCategoriesScreen, guards: [ContributorGuard]),
        AutoRoute(path: 'vendor_subcat', page: RSVendorSubCategoriesScreen, guards: [ContributorGuard]),
        AutoRoute(path: 'vendor_breakings', page: RSVendorBreakingTypesScreen, guards: [ContributorGuard]),
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
