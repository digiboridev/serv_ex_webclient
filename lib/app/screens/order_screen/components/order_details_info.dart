import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/app/providers/repair_service/category_provider.dart';
import 'package:serv_expert_webclient/app/providers/repair_service/issue_provider.dart';
import 'package:serv_expert_webclient/core/app_colors.dart';
import 'package:serv_expert_webclient/data/models/repair_service/category.dart';
import 'package:serv_expert_webclient/data/models/repair_service/issue.dart';
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
          SizedBox(height: 32),
          Text(
            'CLIENT',
            style: TextStyle(
              color: AppColors.black,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Category:',
            style: TextStyle(
              color: AppColors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Consumer(
            builder: (context, ref, child) {
              AsyncValue<RSCategory> categoryData = ref.watch(rsCategoryProvider(order.details.categoryId));
              return categoryData.when(
                data: (category) => Text(
                  category.name,
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 22,
                  ),
                ),
                loading: () => SizedBox(),
                error: (error, stack) => GestureDetector(
                  onTap: () => ref.refresh(rsCategoryProvider(order.details.categoryId)),
                  child: Text(
                    'Error: $error',
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 22,
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 16),
          Text(
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
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 22,
                    ),
                  ),
                  loading: () => SizedBox(),
                  error: (error, stack) => GestureDetector(
                    onTap: () => ref.refresh(rsIssueProvider(issueId)),
                    child: Text(
                      'Error: $error',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 22,
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
          SizedBox(height: 16),
          Text(
            'Issue description:',
            style: TextStyle(
              color: AppColors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            order.details.description,
            style: TextStyle(
              color: AppColors.black,
              fontSize: 22,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Device wet:',
            style: TextStyle(
              color: AppColors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            order.details.deviceWet ? 'Yes' : 'No',
            style: TextStyle(
              color: AppColors.black,
              fontSize: 22,
            ),
          ),
          if (order.details.deviceWet)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Text(
                  'Device wet description:',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  order.details.wetDescription,
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          SizedBox(height: 16),
          Text(
            'Accesories included:',
            style: TextStyle(
              color: AppColors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            order.details.accesoriesIncluded ? 'Yes' : 'No',
            style: TextStyle(
              color: AppColors.black,
              fontSize: 22,
            ),
          ),
          if (order.details.accesoriesIncluded)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Text(
                  'Accesories included description:',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  order.details.accesoriesDescription,
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          SizedBox(height: 32),
        ],
      ),
    );
  }
}
