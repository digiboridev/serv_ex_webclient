import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/app/app_providers.dart';
import 'package:serv_expert_webclient/app/controllers/contributor_controller.dart';
import 'package:serv_expert_webclient/core/app_colors.dart';
import 'package:serv_expert_webclient/global_providers.dart';
import 'package:serv_expert_webclient/router.gr.dart';
import 'package:serv_expert_webclient/widgets/fillable_scrollable_wrapper.dart';
import 'package:serv_expert_webclient/widgets/min_spacer.dart';

class Sidebar extends ConsumerStatefulWidget {
  const Sidebar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SidebarState();
}

class _SidebarState extends ConsumerState<Sidebar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          right: BorderSide(
            color: AppColors.primary.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: FillableScrollableWrapper(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: contributor(),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  context.router.navigate(const Home());
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  child: Row(
                    children: [
                      Icon(Icons.home_outlined, color: AppColors.black),
                      SizedBox(width: 8),
                      Expanded(child: Text('Home', style: TextStyle(color: AppColors.black))),
                    ],
                  ),
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  context.router.replace(const ProfileScreenRoute());
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  child: Row(
                    children: [
                      Icon(Icons.person_2_outlined, color: AppColors.black),
                      SizedBox(width: 8),
                      Expanded(child: Text('Profile', style: TextStyle(color: AppColors.black))),
                    ],
                  ),
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  context.router.replace(const CompaniesScreenRoute());
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  child: Row(
                    children: [
                      Icon(Icons.corporate_fare, color: AppColors.black),
                      SizedBox(width: 8),
                      Expanded(child: Text('Companies', style: TextStyle(color: AppColors.black))),
                    ],
                  ),
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  context.router.replace(const OrdersScreenRoute());
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  child: Row(
                    children: [
                      Icon(Icons.production_quantity_limits, color: AppColors.black),
                      SizedBox(width: 8),
                      Expanded(child: Text('Orders', style: TextStyle(color: AppColors.black))),
                    ],
                  ),
                ),
              ),
            ),
            MinSpacer(
              minHeight: 32,
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  ref.read(authServiceProvider).signOut();
                  context.router.replaceAll([const AuthScreenRoute()]);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  child: Row(
                    children: [
                      Icon(Icons.logout_outlined, color: AppColors.black),
                      SizedBox(width: 8),
                      Expanded(child: Text('Signout', style: TextStyle(color: AppColors.black))),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget contributor() {
    return Consumer(
      builder: (context, ref, child) {
        ContributorState contributorState = ref.watch(contributorControllerProvider);
        return Row(
          children: [
            if (contributorState is CSUnassigned)
              Expanded(
                child: Text(
                  'Unassigned',
                  style: TextStyle(color: AppColors.black, fontWeight: FontWeight.w600),
                ),
              ),
            if (contributorState is CSAssigned)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contributorState.name,
                      style: TextStyle(color: AppColors.black, fontWeight: FontWeight.w600, overflow: TextOverflow.ellipsis),
                    ),
                    Text(
                      contributorState is CSAssignedAsCompany ? 'company' : 'personal',
                      style: TextStyle(
                        color: AppColors.gray,
                      ),
                    ),
                  ],
                ),
              ),
            Tooltip(
              message: 'Change contributor',
              child: GestureDetector(
                onTap: () {
                  context.router.navigate(const ContributorSelectScreenRoute());
                },
                child: Icon(Icons.swap_horiz_sharp, color: AppColors.gray),
              ),
            ),
          ],
        );
      },
    );
  }
}

class SidebarWrapper extends StatelessWidget {
  const SidebarWrapper({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Hero(tag: 'sidebar', child: Sidebar()),
        Expanded(
          child: child,
        ),
      ],
    );
  }
}
