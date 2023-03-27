import 'package:flutter/material.dart';
import 'package:serv_expert_webclient/core/app_colors.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/status_details/accepted.dart';

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
          const SizedBox(height: 32),
          const Text(
            'ACCEPT DETAILS',
            style: TextStyle(
              color: AppColors.black,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Device name:',
            style: TextStyle(
              color: AppColors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            acceptDetails.deviceName,
            style: const TextStyle(
              color: AppColors.black,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Problem description:',
            style: TextStyle(
              color: AppColors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            acceptDetails.problemDescription,
            style: const TextStyle(
              color: AppColors.black,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Condition:',
            style: TextStyle(
              color: AppColors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            acceptDetails.conditionDescription,
            style: const TextStyle(
              color: AppColors.black,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Diagnosis required:',
            style: TextStyle(
              color: AppColors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            acceptDetails.diagnosticRequired ? 'Yes' : 'No',
            style: const TextStyle(
              color: AppColors.black,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
