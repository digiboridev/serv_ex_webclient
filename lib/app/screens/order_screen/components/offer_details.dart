import 'package:flutter/material.dart';
import 'package:serv_expert_webclient/app/screens/order_screen/components/repair_parts_table.dart';
import 'package:serv_expert_webclient/core/app_colors.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/order.dart';

class OfferDetails extends StatelessWidget {
  const OfferDetails({
    Key? key,
    required this.order,
  }) : super(key: key);

  final RSOrder order;

  double get totalCost {
    double total = 0;
    for (var part in order.status.offerCreatedDetails!.parts) {
      total += part.price;
      for (var subpart in part.subparts) {
        total += subpart.price;
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text(
              'Employee nickname: ',
              style: TextStyle(color: AppColors.black, fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text(
              order.status.offerCreatedDetails!.employeeNick,
              style: const TextStyle(color: AppColors.black, fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 32),
        RepairPartsTable(parts: order.status.offerCreatedDetails!.parts),
        const SizedBox(height: 16),
        Row(
          children: [
            const Text(
              'Total:',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Text(
              totalCost.toString(),
              style: const TextStyle(
                color: AppColors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const Text(
              'With Payment:',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              order.status.offerCreatedDetails!.withPayment ? 'Yes' : 'No',
              style: const TextStyle(
                color: AppColors.black,
                fontSize: 18,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const Text(
              'Prepay required:',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              order.status.offerCreatedDetails!.prepayRequired ? 'Yes' : 'No',
              style: const TextStyle(
                color: AppColors.black,
                fontSize: 18,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const Text(
              'Confirmation required:',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              order.status.offerCreatedDetails!.confirmationRequired ? 'Yes' : 'No',
              style: const TextStyle(
                color: AppColors.black,
                fontSize: 18,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const Text(
              'Note for client: ',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              order.status.offerCreatedDetails!.noteForClient,
              style: const TextStyle(
                color: AppColors.black,
                fontSize: 18,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const Text(
              'Note for employee: ',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              order.status.offerCreatedDetails!.noteForEmployee,
              style: const TextStyle(
                color: AppColors.black,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
