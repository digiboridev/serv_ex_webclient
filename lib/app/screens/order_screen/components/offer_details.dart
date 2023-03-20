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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RepairPartsTable(parts: order.statusesDetails.offerSentDetails!.parts),
        SizedBox(height: 16),
        Row(
          children: [
            Text(
              'Payment required:',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 18,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              order.statusesDetails.offerSentDetails!.paymentRequired ? 'Yes' : 'No',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 18,
              ),
            ),
          ],
        ),
        SizedBox(height: 32),
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
              order.statusesDetails.offerSentDetails!.noteForClient,
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
              order.statusesDetails.offerSentDetails!.noteForEmployee,
              style: TextStyle(
                color: AppColors.black,
                fontSize: 18,
              ),
            ),
          ],
        ),
        SizedBox(height: 32),
        Row(
          children: [
            Text(
              'Employee nickname: ',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 18,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              order.statusesDetails.offerSentDetails!.fantomasName,
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
