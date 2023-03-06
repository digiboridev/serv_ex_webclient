import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/app/app_providers.dart';
import 'package:serv_expert_webclient/app/controllers/contributor_controller.dart';
import 'package:serv_expert_webclient/app/providers/repair_service/issues_provider.dart';
import 'package:serv_expert_webclient/app/providers/repair_service/category_provider.dart';
import 'package:serv_expert_webclient/core/text_styles.dart';
import 'package:serv_expert_webclient/data/dto/repair_service/new_order.dart';
import 'package:serv_expert_webclient/data/models/repair_service/issue.dart';
import 'package:serv_expert_webclient/data/models/repair_service/category.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/customer_info.dart';
import 'package:serv_expert_webclient/router.gr.dart';
import 'package:serv_expert_webclient/widgets/fillable_scrollable_wrapper.dart';
import 'package:serv_expert_webclient/app/widgets/header.dart';
import 'package:serv_expert_webclient/widgets/min_spacer.dart';
import 'package:serv_expert_webclient/widgets/regular_button.dart';

class RSIssuesScreen extends ConsumerWidget {
  const RSIssuesScreen({super.key, @queryParam required this.categoryId});

  final String? categoryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FillableScrollableWrapper(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            const Header(),
            const SizedBox(
              height: 32,
            ),
            categoryName(),
            const SizedBox(
              height: 32,
            ),
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  AsyncValue<List<RSIssue>> issues = ref.watch(rsIssuesProvider(categoryId!));
                  return issues.when(
                    data: (issues) {
                      return FadeIn(
                        child: IssueSelection(
                          categoryId: categoryId!,
                          issues: issues,
                        ),
                      );
                    },
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (error, stackTrace) => Center(child: Text(error.toString())),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 32,
            ),
          ],
        ),
      ),
    );
  }

  Consumer categoryName() {
    return Consumer(
      builder: (context, ref, child) {
        AsyncValue<RSCategory> selectedCategoryData = ref.watch(rsCategoryProvider(categoryId!));

        return FadeIn(
          child: Text(
            selectedCategoryData.when(
              data: (category) {
                return category.name;
              },
              loading: () => '',
              error: (error, stackTrace) => 'Error',
            ),
            style: AppTextStyles.headline,
          ),
        );
      },
    );
  }
}

class IssueSelection extends ConsumerStatefulWidget {
  const IssueSelection({required this.issues, required this.categoryId, super.key});
  final List<RSIssue> issues;
  final String categoryId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _IssueSelectionState();
}

class _IssueSelectionState extends ConsumerState<IssueSelection> {
  late final List<RSIssue> issues;
  List<RSIssue> selectedIssues = [];

  @override
  void initState() {
    super.initState();
    issues = widget.issues;
  }

  onSubmit() {
    ContributorState contributorState = ref.read(contributorControllerProvider);
    if (contributorState is CSAssigned) {
      RSOrderCustomerInfo customerInfo = RSOrderCustomerInfo(
        customerType: (contributorState is CSAssignedAsCompany) ? RSOrderCustomerType.company : RSOrderCustomerType.personal,
        customerId: contributorState.id,
      );

      RSNewOrderDTO newOrder = RSNewOrderDTO(
        customerInfo: customerInfo,
        categoryId: widget.categoryId,
        issueIds: selectedIssues.map((issue) => issue.id).toList(),
      );

      context.router.navigate(
        RSOrderDetailsScreenRoute(newOrder: newOrder),
      );
    } else {
      throw Exception('Contributor is not assigned');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(children: issues.map((issue) => issueTile(issue)).toList()),
        const MinSpacer(
          minHeight: 32,
        ),
        nextButton(),
        const MinSpacer(
          minHeight: 32,
        ),
      ],
    );
  }

  Widget nextButton() {
    return SizedBox(
      width: 546,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: RegularButton(onTap: onSubmit, text: 'Next'),
      ),
    );
  }

  Widget issueTile(RSIssue issue) {
    return Container(
      width: 600,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Checkbox(
            value: selectedIssues.contains(issue),
            onChanged: (value) {
              if (value!) {
                setState(() {
                  selectedIssues.add(issue);
                });
              } else {
                setState(() {
                  selectedIssues.remove(issue);
                });
              }
            },
          ),
          Text(issue.name),
        ],
      ),
    );
  }
}
