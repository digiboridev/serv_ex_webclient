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
    for (var part in order.statusesDetails.offerCreatedDetails!.parts) {
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
            Text(
              'Employee nickname: ',
              style: TextStyle(color: AppColors.black, fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text(
              order.statusesDetails.offerCreatedDetails!.employeeNick,
              style: TextStyle(color: AppColors.black, fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        SizedBox(height: 32),
        RepairPartsTable(parts: order.statusesDetails.offerCreatedDetails!.parts),
        SizedBox(height: 16),
        Row(
          children: [
            Text(
              'Total:',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Spacer(),
            Text(
              totalCost.toString(),
              style: TextStyle(
                color: AppColors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Text(
              'With Payment:',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 18,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              order.statusesDetails.offerCreatedDetails!.withPayment ? 'Yes' : 'No',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 18,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Text(
              'Prepay required:',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 18,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              order.statusesDetails.offerCreatedDetails!.prepayRequired ? 'Yes' : 'No',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 18,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Text(
              'Confirmation required:',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 18,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              order.statusesDetails.offerCreatedDetails!.confirmationRequired ? 'Yes' : 'No',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 18,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Text(
              'Note for client: ',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 18,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              order.statusesDetails.offerCreatedDetails!.noteForClient,
              style: TextStyle(
                color: AppColors.black,
                fontSize: 18,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Text(
              'Note for employee: ',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 18,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              order.statusesDetails.offerCreatedDetails!.noteForEmployee,
              style: TextStyle(
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
