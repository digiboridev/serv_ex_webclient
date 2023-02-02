import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/data/models/client/client.dart';
import 'package:serv_expert_webclient/data/models/company/company.dart';
import 'package:serv_expert_webclient/ui/app_wrapper.dart';
import 'package:serv_expert_webclient/ui/components/fillable_scrollable_wrapper.dart';
import 'package:serv_expert_webclient/ui/contrributor_controller.dart';
import 'package:serv_expert_webclient/ui/router.gr.dart';

class ContributorSelectScreen extends ConsumerStatefulWidget {
  const ContributorSelectScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ContributorSelectScreenState();
}

class _ContributorSelectScreenState extends ConsumerState<ContributorSelectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FillableScrollableWrapper(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'CONTRIBUTOR CHOOSE',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 164,
            ),
            Consumer(
              builder: (context, ref, _) {
                AsyncValue<Client> clientData = ref.watch(currentClientStreamProvider);
                if (clientData is AsyncData<Client>) {
                  return button('${clientData.value.firstName} ${clientData.value.lastName}', () {
                    ref.read(contributorControllerProvider.notifier).setClientContributor(client: clientData.value);
                    context.router.navigate(HomeScreenRoute());
                  });
                } else {
                  return const SizedBox();
                }
              },
            ),
            Container(
              height: 1,
              width: 100,
              color: Colors.deepPurple,
              margin: const EdgeInsets.symmetric(vertical: 8),
            ),
            Consumer(
              builder: (context, ref, _) {
                AsyncValue<List<Company>> companiesData = ref.watch(companiesStreamProvider);
                if (companiesData is AsyncData<List<Company>>) {
                  return Column(
                    children: [
                      for (Company company in companiesData.value)
                        button(
                          company.name,
                          () {
                            ref.read(contributorControllerProvider.notifier).setCompanyContributor(company: company);
                            context.router.navigate(HomeScreenRoute());
                          },
                        ),
                    ],
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget button(String text, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: 400,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Material(
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: onTap,
            child: Ink(
              // width: 600,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.deepPurple, width: 2),
              ),
              child: Center(
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
