import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/core/app_colors.dart';
import 'package:serv_expert_webclient/data/models/user/app_user.dart';
import 'package:serv_expert_webclient/data/models/company/company.dart';
import 'package:serv_expert_webclient/app/app_providers.dart';
import 'package:serv_expert_webclient/global_providers.dart';
import 'package:serv_expert_webclient/utils/ui_utils.dart';
import 'package:serv_expert_webclient/widgets/fillable_scrollable_wrapper.dart';
import 'package:serv_expert_webclient/router.gr.dart';
import 'package:serv_expert_webclient/widgets/headline.dart';
import 'package:serv_expert_webclient/widgets/min_spacer.dart';
import 'package:serv_expert_webclient/widgets/regular_button.dart';

class ContributorSelectScreen extends ConsumerStatefulWidget {
  const ContributorSelectScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ContributorSelectScreenState();
}

class _ContributorSelectScreenState extends ConsumerState<ContributorSelectScreen> {
  onLogout() {
    ref.read(authServiceProvider).signOut();
    context.router.replaceAll([const AuthScreenRoute()]);
  }

  onAppUserSelect(AppUser appUser) {
    ref.read(contributorControllerProvider.notifier).setAppUserContributor(appUser: appUser);
    context.router.navigate(const Home());
  }

  onCompanySelect(Company company) {
    ref.read(contributorControllerProvider.notifier).setCompanyContributor(company: company);
    context.router.navigate(const Home());
  }

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: body,
    );
  }

  Widget get body {
    return FillableScrollableWrapper(
      child: Column(
        children: [
          // Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          //   alignment: Alignment.centerLeft,
          //   child: TextButton(
          //     onPressed: onLogout,
          //     child: Text(
          //       'Logout',
          //       style: TextStyle(
          //         fontSize: whenLayout<double>(mobile: 14.ms, tablet: 18.ts),
          //         color: AppColors.primary,
          //       ),
          //     ),
          //   ),
          // ),
          MinSpacer(minHeight: whenLayout<double>(mobile: 32.ms, tablet: 48.ts)),
          const Headline(text: 'CONTRIBUTOR CHOOSE'),
          SizedBox(height: whenLayout<double>(mobile: 40.ms, tablet: 72.ts)),
          // Personal account
          Consumer(
            builder: (context, ref, _) {
              AsyncValue<AppUser> userData = ref.watch(currentAppUserStreamProvider);
              if (userData is AsyncData<AppUser>) {
                return Container(
                  width: whenLayout<double>(mobile: 345.ms, tablet: 546.ts),
                  padding: EdgeInsets.symmetric(vertical: whenLayout<double>(mobile: 6.ms, tablet: 8.ts)),
                  child: button(
                    '${userData.value.firstName} ${userData.value.lastName}',
                    () => onAppUserSelect(userData.value),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
          // List of companies
          Consumer(
            builder: (context, ref, _) {
              AsyncValue<List<Company>> companiesData = ref.watch(companiesStreamProvider);
              if (companiesData is AsyncData<List<Company>>) {
                return Column(
                  children: [
                    Container(
                      height: 1,
                      width: 100,
                      color: Colors.deepPurple,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    for (Company company in companiesData.value)
                      Container(
                        width: whenLayout<double>(mobile: 345.ms, tablet: 546.ts),
                        padding: EdgeInsets.symmetric(vertical: whenLayout<double>(mobile: 6.ms, tablet: 8.ts)),
                        child: button(
                          company.name,
                          () => onCompanySelect(company),
                        ),
                      ),
                  ],
                );
              } else {
                return const SizedBox();
              }
            },
          ),
          MinSpacer(minHeight: whenLayout<double>(mobile: 32.ms, tablet: 48.ts)),
        ],
      ),
    );
  }

  Widget button(String text, VoidCallback onTap) {
    return RegularButton(
      textStyle: TextStyle(
        fontSize: whenLayout<double>(mobile: 18.ms, tablet: 24.ts),
        fontWeight: FontWeight.w500,
        color: AppColors.primary,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: whenLayout<double>(mobile: 16.ms, tablet: 24.ts),
        vertical: whenLayout<double>(mobile: 12.ms, tablet: 18.ts),
      ),
      onTap: onTap,
      text: text,
      color: AppColors.white,
      borderColor: AppColors.primary,
    );
  }
}
