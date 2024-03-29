// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/data/providers/repair_service/order_provider.dart';
import 'package:serv_expert_webclient/app/screens/companies/companies_screen.dart';
import 'package:serv_expert_webclient/app/screens/home/home_wrapper.dart';
import 'package:serv_expert_webclient/app/screens/home/rs_catalog/services_screen.dart';
import 'package:serv_expert_webclient/app/screens/home/rs_ordering/order_password_screen.dart';
import 'package:serv_expert_webclient/app/screens/order_screen/cancel_page.dart';
import 'package:serv_expert_webclient/app/screens/order_screen/loader.dart';
import 'package:serv_expert_webclient/app/screens/order_screen/view_page.dart';
import 'package:serv_expert_webclient/app/screens/orders/orders_screen.dart';
import 'package:serv_expert_webclient/app/screens/home/rs_ordering/order_details_screen.dart';
import 'package:serv_expert_webclient/app/screens/home/rs_ordering/order_has_password_screen.dart';
import 'package:serv_expert_webclient/app/screens/home/rs_ordering/order_password_type_screen.dart';
import 'package:serv_expert_webclient/app/screens/home/rs_ordering/order_submitted_screen.dart';
import 'package:serv_expert_webclient/app/screens/home/rs_ordering/order_waranty_screen.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/order.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/status.dart';
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
import 'package:serv_expert_webclient/app/screens/profile/profile_screen.dart';
import 'package:serv_expert_webclient/app/screens/home/rs_catalog/breaking_types_screen.dart';
import 'package:serv_expert_webclient/app/screens/home/rs_catalog/categories_screen.dart';
import 'package:serv_expert_webclient/app/screens/home/rs_catalog/subcategories_screen.dart';

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
        AutoRoute(
          name: 'home',
          path: 'home',
          page: HomeWrapper,
          guards: [ContributorGuard],
          children: [
            RedirectRoute(path: '', redirectTo: 'services'),
            AutoRoute(path: 'services', page: ServicesScreen),
            AutoRoute(path: 'categories', page: CategoriesScreen),
            AutoRoute(path: 'subcategories/:categoryId', page: SubCategoriesScreen),
            AutoRoute(path: 'issues/:categoryId', page: IssuesScreen),
          ],
        ),
        AutoRoute(path: 'profile', page: ProfileScreen, guards: [ContributorGuard]),
        AutoRoute(path: 'companies', page: CompaniesScreen, guards: [ContributorGuard]),
        AutoRoute(path: 'orders', page: OrdersScreen, guards: [ContributorGuard]),
        AutoRoute(
          name: 'orderScreen',
          path: 'order/:orderId',
          page: OrderScreenLoader,
          children: [
            RedirectRoute(path: '', redirectTo: 'view'),
            AutoRoute(path: 'view', page: OrderScreenViewPage),
            AutoRoute(path: 'cancell', page: OrderCancellPage, guards: [OrderCancellGuard]),
          ],
        ),
        AutoRoute(path: 'rs_order_details', page: RSOrderDetailsScreen, guards: [ContributorGuard, ServiceOrderGuard]),
        AutoRoute(path: 'rs_order_waranty', page: RSOrderWarantyScreen, guards: [ContributorGuard, ServiceOrderGuard]),
        AutoRoute(path: 'rs_order_haspass', page: RSOrderHasPasswordScreen, guards: [ContributorGuard, ServiceOrderGuard]),
        AutoRoute(path: 'rs_order_passtypes', page: RSOrderPasswordTypeScreen, guards: [ContributorGuard, ServiceOrderGuard]),
        AutoRoute(path: 'rs_order_password', page: RSOrderPasswordScreen, guards: [ContributorGuard, ServiceOrderGuard]),

        AutoRoute(path: 'rs_order_submitted', page: RSOrderSubmittedScreen, guards: [ContributorGuard]),
        // AutoRoute(path: 'b', page: SB),
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

class OrderCancellGuard extends AutoRouteGuard {
  WidgetRef ref;
  OrderCancellGuard({
    required this.ref,
  });

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    String orderId = router.routeData.pathParams.getString('orderId');

    /// Make sure that the order is loaded before navigating to the cancell page
    RSOrder order = ref.watch(rsOrderStreamProvider(orderId)).value!;

    // Protect to navigate to the cancell page if the order is already closed or cancelled
    if (order.status.currentStatus == RSOStatusType.canceled || order.status.currentStatus == RSOStatusType.closed) {
      resolver.next(false);
      router.replace(OrderScreenViewPageRoute());
    } else {
      resolver.next(true);
    }
  }
}
