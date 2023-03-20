import 'package:flutter/material.dart';
import 'package:serv_expert_webclient/core/app_colors.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/status.dart';

class OrderAcceptDetails extends StatelessWidget {
  const OrderAcceptDetails({
    required this.acceptDetails,
    super.key,
  });

  final RSOrderAcceptDetails acceptDetails;

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
            'ACCEPT DETAILS',
            style: TextStyle(
              color: AppColors.black,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Device name:',
            style: TextStyle(
              color: AppColors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            acceptDetails.deviceName,
            style: TextStyle(
              color: AppColors.black,
              fontSize: 22,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Problem description:',
            style: TextStyle(
              color: AppColors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            acceptDetails.problemDescription,
            style: TextStyle(
              color: AppColors.black,
              fontSize: 22,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Condition:',
            style: TextStyle(
              color: AppColors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            acceptDetails.conditionDescription,
            style: TextStyle(
              color: AppColors.black,
              fontSize: 22,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Diagnosis required:',
            style: TextStyle(
              color: AppColors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            acceptDetails.diagnosticRequired ? 'Yes' : 'No',
            style: TextStyle(
              color: AppColors.black,
              fontSize: 22,
            ),
          ),
          SizedBox(height: 32),
        ],
      ),
    );
  }
}
