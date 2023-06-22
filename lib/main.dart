import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:serv_expert_webclient/router.dart';
import 'package:serv_expert_webclient/router.gr.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  runApp(const ProviderScope(child: TheApp()));
}

class TheApp extends ConsumerStatefulWidget {
  const TheApp({super.key});

  @override
  ConsumerState<TheApp> createState() => _TheAppState();
}

class _TheAppState extends ConsumerState<TheApp> {
  late final AppRouter _appRouter;
  @override
  void initState() {
    super.initState();
    _appRouter = AppRouter(
      navigatorKey: navigatorKey,
      appGuard: AppGuard(ref: ref),
      contributorGuard: ContributorGuard(ref: ref),
      serviceOrderGuard: ServiceOrderGuard(ref: ref),
      orderCancellGuard: OrderCancellGuard(ref: ref),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ServExpert',
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
