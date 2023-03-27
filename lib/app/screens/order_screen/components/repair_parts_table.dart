// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:serv_expert_webclient/core/app_colors.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/repair_part.dart';

class RepairPartsTable extends StatelessWidget {
  const RepairPartsTable({required this.parts, this.showSelection = false, super.key});

  final List<RepairPart> parts;
  final bool showSelection;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        partsTableHeader(),
        const SizedBox(height: 16),
        ...parts.map((part) {
          return Column(
            children: [
              partTile(part),
              ...part.subparts.map((subpart) => subpartTile(part, subpart)).toList(),
              const SizedBox(height: 16),
            ],
          );
        }).toList(),
      ],
    );
  }

  Widget partsTableHeader() {
    return Row(
      children: [
        if (showSelection) const SizedBox(width: 40),
        const Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Name',
              textAlign: TextAlign.start,
            ),
          ),
        ),
        const SizedBox(
          width: 1,
        ),
        const SizedBox(
          width: 100,
          child: Text(
            'Date',
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          width: 1,
        ),
        const SizedBox(
          width: 80,
          child: Text(
            'Price',
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget partTile(RepairPart part) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 50,
          margin: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.backgroundTable,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.primary, width: 1),
          ),
          child: IntrinsicHeight(
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                if (showSelection) ...[
                  const SizedBox(width: 8),
                  Icon(part.selected ? Icons.check_box : Icons.check_box_outline_blank),
                  const SizedBox(width: 8),
                  Container(
                    width: 1,
                    height: double.infinity,
                    color: AppColors.primary,
                  ),
                ],
                Expanded(
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        part.name,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: double.infinity,
                  color: AppColors.primary,
                ),
                SizedBox(
                  width: 100,
                  child: Text(
                    DateFormat.yMMMd().format(part.date),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: 1,
                  height: double.infinity,
                  color: AppColors.primary,
                ),
                SizedBox(
                  width: 80,
                  child: Text(
                    part.price.toString(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (part.note.isNotEmpty)
          SizedBox(
            width: 546,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.backgroundTable,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.primary, width: 1),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                'Note: ${part.note}',
                textAlign: TextAlign.start,
              ),
            ),
          ),
      ],
    );
  }

  Widget subpartTile(RepairPart part, RepairSubpart subpart) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 50,
          margin: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.backgroundTable,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.primary, width: 1),
          ),
          child: IntrinsicHeight(
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                if (showSelection) ...[
                  const SizedBox(width: 8),
                  Icon(part.selected ? Icons.check_box : Icons.check_box_outline_blank),
                  const SizedBox(width: 8),
                  Container(
                    width: 1,
                    height: double.infinity,
                    color: AppColors.primary,
                  ),
                ],
                Expanded(
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        subpart.name,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: double.infinity,
                  color: AppColors.primary,
                ),
                SizedBox(
                  width: 100,
                  child: Text(
                    DateFormat.yMMMd().format(subpart.date),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: 1,
                  height: double.infinity,
                  color: AppColors.primary,
                ),
                SizedBox(
                  width: 80,
                  child: Text(
                    subpart.price.toString(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (subpart.note.isNotEmpty)
          SizedBox(
            width: 546,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.backgroundTable,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.primary, width: 1),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                'Note: ${subpart.note}',
                textAlign: TextAlign.start,
              ),
            ),
          ),
      ],
    );
  }
}
