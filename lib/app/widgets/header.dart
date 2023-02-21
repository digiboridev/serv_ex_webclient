import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/core/app_colors.dart';
import 'package:serv_expert_webclient/global_providers.dart';
import 'package:serv_expert_webclient/app/app_providers.dart';
import 'package:serv_expert_webclient/app/contributor_controller.dart';
import 'package:serv_expert_webclient/router.gr.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'header228',
      child: Consumer(
        builder: (context, ref, child) {
          ContributorState contributorState = ref.watch(contributorControllerProvider);
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.home,
                    color: AppColors.primary,
                  ),
                  onPressed: () {
                    context.router.navigate(const HomeScreenRoute());
                  },
                ),
                const Spacer(),
                SubmenuButton(
                  onClose: () {
                    FocusScope.of(context).unfocus();
                  },
                  menuChildren: <Widget>[
                    InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        context.router.navigate(const ContributorSelectScreenRoute());
                      },
                      child: Container(
                        width: 150,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: const Text(
                          'Switch contributor',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        context.router.navigate(const ProfileScreenRoute());
                      },
                      child: Container(
                        width: 150,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: const Text(
                          'Profile',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        ref.read(authServiceProvider).signOut();
                        context.router.replaceAll([const AuthScreenRoute()]);
                      },
                      child: Container(
                        width: 150,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: const Text(
                          'Logout',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        context.router.navigate(const SBRoute());
                      },
                      child: Container(
                        width: 150,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: const Text(
                          'Debug',
                          style: TextStyle(
                            color: AppColors.primary,
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
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      const SizedBox(
                        width: 4,
                      ),
                      const Icon(
                        Icons.person,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
