import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/data/providers/repair_service/category_provider.dart';
import 'package:serv_expert_webclient/data/providers/repair_service/issue_provider.dart';
import 'package:serv_expert_webclient/app/widgets/pattern_lock.dart';
import 'package:serv_expert_webclient/core/app_colors.dart';
import 'package:serv_expert_webclient/data/models/repair_service/category.dart';
import 'package:serv_expert_webclient/data/models/repair_service/issue.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/device_password.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/order.dart';

class OrderDetailsInfo extends StatelessWidget {
  const OrderDetailsInfo({
    required this.order,
    super.key,
  });

  final RSOrder order;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      decoration: BoxDecoration(
        color: AppColors.backgroundTable,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primary, width: 1),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          const Text(
            'CLIENT',
            style: TextStyle(
              color: AppColors.black,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Category:',
            style: TextStyle(
              color: AppColors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Consumer(
            builder: (context, ref, child) {
              AsyncValue<Category> categoryData = ref.watch(categoryProvider(order.details.categoryId));
              return categoryData.when(
                data: (category) => Text(
                  category.name,
                  style: const TextStyle(
                    color: AppColors.black,
                    fontSize: 22,
                  ),
                ),
                loading: () => const SizedBox(),
                error: (error, stack) => GestureDetector(
                  onTap: () => ref.refresh(categoryProvider(order.details.categoryId)),
                  child: Text(
                    'Error: $error',
                    style: const TextStyle(
                      color: AppColors.black,
                      fontSize: 22,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          const Text(
            'Issues:',
            style: TextStyle(
              color: AppColors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...order.details.issueIds.map((issueId) {
            return Consumer(
              builder: (context, ref, child) {
                AsyncValue<RSIssue> issueData = ref.watch(rsIssueProvider(issueId));

                return issueData.when(
                  data: (issue) => Text(
                    issue.name,
                    style: const TextStyle(
                      color: AppColors.black,
                      fontSize: 22,
                    ),
                  ),
                  loading: () => const SizedBox(),
                  error: (error, stack) => GestureDetector(
                    onTap: () => ref.refresh(rsIssueProvider(issueId)),
                    child: Text(
                      'Error: $error',
                      style: const TextStyle(
                        color: AppColors.black,
                        fontSize: 22,
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
          const SizedBox(height: 16),
          const Text(
            'Issue description:',
            style: TextStyle(
              color: AppColors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            order.details.description,
            style: const TextStyle(
              color: AppColors.black,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Device wet:',
            style: TextStyle(
              color: AppColors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            order.details.deviceWet ? 'Yes' : 'No',
            style: const TextStyle(
              color: AppColors.black,
              fontSize: 22,
            ),
          ),
          if (order.details.deviceWet)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                const Text(
                  'Device wet description:',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  order.details.wetDescription,
                  style: const TextStyle(
                    color: AppColors.black,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          const SizedBox(height: 16),
          const Text(
            'Accesories included:',
            style: TextStyle(
              color: AppColors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            order.details.accesoriesIncluded ? 'Yes' : 'No',
            style: const TextStyle(
              color: AppColors.black,
              fontSize: 22,
            ),
          ),
          if (order.details.accesoriesIncluded)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                const Text(
                  'Accesories included description:',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  order.details.accesoriesDescription,
                  style: const TextStyle(
                    color: AppColors.black,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          const SizedBox(height: 16),
          const Text(
            'Has waranty:',
            style: TextStyle(
              color: AppColors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            order.details.hasWaranty ? 'Yes' : 'No',
            style: const TextStyle(
              color: AppColors.black,
              fontSize: 22,
            ),
          ),
          if (order.details.password != null) ...[
            const SizedBox(height: 16),
            const Text(
              'Device password:',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (order.details.password is PatternPassword)
              Container(
                margin: const EdgeInsets.only(top: 16),
                height: 200,
                width: 200,
                child: PatternLock(
                  onlyView: true,
                  dimension: (order.details.password as PatternPassword).dimensions,
                  initialPoints: (order.details.password as PatternPassword).points,
                  relativePadding: 0.1,
                  onInputComplete: (v) {},
                ),
              ),
            if (order.details.password is NumericPassword)
              Text(
                (order.details.password as NumericPassword).password,
                style: const TextStyle(
                  color: AppColors.black,
                  fontSize: 22,
                ),
              ),
          ],
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
