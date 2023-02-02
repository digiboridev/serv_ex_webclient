import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/main.dart';
import 'package:serv_expert_webclient/ui/components/fillable_scrollable_wrapper.dart';
import 'package:serv_expert_webclient/ui/contrributor_controller.dart';
import 'package:serv_expert_webclient/ui/router.gr.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    ContributorState contributorState = ref.watch(contributorControllerProvider);

    return Container(
      color: Colors.white,
      child: FillableScrollableWrapper(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.home,
                      color: Colors.deepPurple,
                    ),
                    onPressed: () {
                      context.router.navigate(HomeScreenRoute());
                    },
                  ),
                  Spacer(),
                  SubmenuButton(
                    onClose: () {
                      FocusScope.of(context).unfocus();
                    },
                    menuChildren: <Widget>[
                      InkWell(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          context.router.navigate(ContributorSelectScreenRoute());
                        },
                        child: Container(
                          width: 150,
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Text(
                            'Switch contributor',
                            style: TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          context.router.navigate(ProfileScreenRoute());
                        },
                        child: Container(
                          width: 150,
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Text(
                            'Profile',
                            style: TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          ref.read(fireAuthServiceProvider).signOut();
                          context.router.replaceAll([const AuthScreenRoute()]);
                        },
                        child: Container(
                          width: 150,
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Text(
                            'Logout',
                            style: TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          context.router.navigate(SBRoute());
                        },
                        child: Container(
                          width: 150,
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Text(
                            'Debug',
                            style: TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                    child: Row(
                      children: [
                        if (contributorState is CSAssigned)
                          Text(
                            contributorState.name,
                            style: TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        SizedBox(
                          width: 4,
                        ),
                        Icon(
                          Icons.person,
                          color: Colors.deepPurple,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Text('HomeScreen'),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
