import 'package:flutter/material.dart';
import 'package:serv_expert_webclient/app/screens/order_screen/components/repair_parts_table.dart';
import 'package:serv_expert_webclient/core/app_colors.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/order.dart';

class ConfirmedOfferDetails extends StatelessWidget {
  const ConfirmedOfferDetails({
    Key? key,
    required this.order,
  }) : super(key: key);

  final RSOrder order;

  double get totalCost {
    double total = 0;
    for (var part in order.status.confirmedOfferDetails!.parts) {
      if (part.selected) {
        total += part.price;
        for (var subpart in part.subparts) {
          total += subpart.price;
        }
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
              order.status.offerCreatedDetails!.employeeNick,
              style: TextStyle(color: AppColors.black, fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        SizedBox(height: 32),
        RepairPartsTable(
          parts: order.status.confirmedOfferDetails!.parts,
          showSelection: true,
        ),
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
              'With payment:',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 18,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              order.status.offerCreatedDetails!.withPayment ? 'Yes' : 'No',
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
              'Prepay reuired:',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 18,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              order.status.offerCreatedDetails!.prepayRequired ? 'Yes' : 'No',
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
              order.status.offerCreatedDetails!.noteForClient,
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
              order.status.offerCreatedDetails!.noteForEmployee,
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
