import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:serv_expert_webclient/ui/screens/auth/auth_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    RedirectRoute(path: '/', redirectTo: '/login'),
    AutoRoute(path: '/login', page: AuthScreen, name: 'login'),
    AutoRoute(
      path: '/home',
      page: Home,
      name: 'home',
      children: [
        AutoRoute(path: 'a', page: SA),
        AutoRoute(path: 'b', page: SB),
      ],
    ),
    AutoRoute(
      path: '/home2',
      name: 'home2',
      page: Home,
      children: [
        AutoRoute(path: 'a', page: SA),
        AutoRoute(path: 'b', page: SB),
      ],
    ),
  ],
)
// extend the generated private router
class $AppRouter {}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GestureDetector(
              onTap: () {
                context.router.navigateNamed('/home2/b');
              },
              child: const Text('Home')),
          const Expanded(child: AutoRouter()),
        ],
      ),
    );
  }
}

class SA extends StatelessWidget {
  const SA({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('SA'),
      ),
    );
  }
}

class SB extends StatelessWidget {
  const SB({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('SB'),
      ),
    );
  }
}
