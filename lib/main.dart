import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/core/firebase_options.dart';
import 'package:serv_expert_webclient/data/reposiotories/clients_repository.dart';
import 'package:serv_expert_webclient/data/reposiotories/companies_repository.dart';
import 'package:serv_expert_webclient/services/fireauth.dart';
import 'package:serv_expert_webclient/ui/router.dart';
import 'package:serv_expert_webclient/ui/router.gr.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAuth.instance.userChanges().first;

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
      appGuard: AppGuard(ref: ref),
      authGuard: AuthGuard(ref: ref),
      contributorGuard: ContributorGuard(ref: ref),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}

// Global providers
final clientsRepositoryProvider = Provider<ClientsRepository>((ref) {
  return ClientsRepository();
});
final companiesRepositoryProvider = Provider<CompaniesRepository>((ref) {
  return CompaniesRepository();
});

final fireAuthServiceProvider = Provider<FireAuthService>((ref) {
  return FireAuthService();
});
