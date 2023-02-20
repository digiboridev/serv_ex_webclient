import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/core/app_colors.dart';
import 'package:serv_expert_webclient/core/text_styles.dart';
import 'package:serv_expert_webclient/data/models/client/client.dart';
import 'package:serv_expert_webclient/data/models/company/company.dart';
import 'package:serv_expert_webclient/app/app_providers.dart';
import 'package:serv_expert_webclient/global_providers.dart';
import 'package:serv_expert_webclient/widgets/fillable_scrollable_wrapper.dart';
import 'package:serv_expert_webclient/router.gr.dart';
import 'package:serv_expert_webclient/widgets/layouter.dart';
import 'package:serv_expert_webclient/widgets/min_spacer.dart';
import 'package:serv_expert_webclient/widgets/regular_button.dart';

class ContributorSelectScreen extends ConsumerStatefulWidget {
  const ContributorSelectScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ContributorSelectScreenState();
}

class _ContributorSelectScreenState extends ConsumerState<ContributorSelectScreen> {
  onLogout() {
    ref.read(fireAuthServiceProvider).signOut();
    context.router.replaceAll([const AuthScreenRoute()]);
  }

  onClientSelect(Client client) {
    ref.read(contributorControllerProvider.notifier).setClientContributor(client: client);
    context.router.navigate(const HomeScreenRoute());
  }

  onCompanySelect(Company company) {
    ref.read(contributorControllerProvider.notifier).setCompanyContributor(company: company);
    context.router.navigate(const HomeScreenRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Layouter(mobileLayout: mobileBody, tabletLayout: tabletBody),
    );
  }

  Widget get mobileBody {
    return FillableScrollableWrapper(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                TextButton(
                  onPressed: onLogout,
                  child: Text('Logout', style: AppTextStyles.formText.copyWith(color: AppColors.primary)),
                ),
              ],
            ),
          ),
          const MinSpacer(
            minHeight: 32,
          ),
          const Text('CONTRIBUTOR CHOOSE', style: AppTextStyles.headline),
          const SizedBox(
            height: 40,
          ),
          // Personal account
          Consumer(
            builder: (context, ref, _) {
              AsyncValue<Client> clientData = ref.watch(currentClientStreamProvider);
              if (clientData is AsyncData<Client>) {
                return SizedBox(
                  width: 345,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: button(
                      '${clientData.value.firstName} ${clientData.value.lastName}',
                      () => onClientSelect(clientData.value),
                      true,
                    ),
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
                      SizedBox(
                        width: 345,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: button(
                            company.name,
                            () => onCompanySelect(company),
                            true,
                          ),
                        ),
                      ),
                  ],
                );
              } else {
                return const SizedBox();
              }
            },
          ),
          const MinSpacer(
            minHeight: 32,
          ),
        ],
      ),
    );
  }

  Widget get tabletBody {
    return FillableScrollableWrapper(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                TextButton(
                  onPressed: onLogout,
                  child: Text('Logout', style: AppTextStyles.formTextTablet.copyWith(color: AppColors.primary)),
                ),
              ],
            ),
          ),
          const MinSpacer(
            minHeight: 32,
          ),
          const Text('CONTRIBUTOR CHOOSE', style: AppTextStyles.headlineTablet),
          const SizedBox(
            height: 72,
          ),
          // Personal account
          Consumer(
            builder: (context, ref, _) {
              AsyncValue<Client> clientData = ref.watch(currentClientStreamProvider);
              if (clientData is AsyncData<Client>) {
                return SizedBox(
                  width: 546,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: button(
                      '${clientData.value.firstName} ${clientData.value.lastName}',
                      () => onClientSelect(clientData.value),
                      false,
                    ),
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
                      SizedBox(
                        width: 546,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: button(
                            company.name,
                            () => onCompanySelect(company),
                            false,
                          ),
                        ),
                      ),
                  ],
                );
              } else {
                return const SizedBox();
              }
            },
          ),
          const MinSpacer(
            minHeight: 32,
          ),
        ],
      ),
    );
  }

  Widget button(String text, VoidCallback onTap, bool mobile) {
    return RegularButton(
      onTap: onTap,
      text: text,
      color: AppColors.white,
      borderColor: AppColors.primary,
      textStyle: mobile ? AppTextStyles.btnText.copyWith(color: AppColors.primary) : AppTextStyles.btnTextTablet.copyWith(color: AppColors.primary),
    );
  }
}
