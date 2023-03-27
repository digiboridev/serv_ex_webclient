// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:serv_expert_webclient/core/app_colors.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/repair_part.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/status_details/offer_created.dart';
import 'package:serv_expert_webclient/widgets/min_spacer.dart';
import 'package:serv_expert_webclient/widgets/regular_button.dart';

class OfferForm extends StatefulWidget {
  const OfferForm({required this.offerCreatedDetails, required this.onAgree, required this.onDecline, super.key});
  final RSOrderOfferCreatedDetails offerCreatedDetails;
  final Function(List<RepairPart>) onAgree;
  final Function() onDecline;

  @override
  State<OfferForm> createState() => _OfferFormState();
}

class _OfferFormState extends State<OfferForm> {
  late List<RepairPart> parts;

  @override
  void initState() {
    super.initState();
    parts = widget.offerCreatedDetails.parts;
  }

  @override
  void didUpdateWidget(covariant OfferForm oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.offerCreatedDetails != widget.offerCreatedDetails) {
      parts = widget.offerCreatedDetails.parts;
    }
  }

  onPartSelect(RepairPart part) {
    int partIndex = parts.indexOf(part);
    parts[partIndex] = parts[partIndex].copyWith(selected: !parts[partIndex].selected);
    setState(() {});
  }

  onPartNoteEdit({required RepairPart part, required String value}) {
    int partIndex = parts.indexOf(part);
    parts[partIndex] = parts[partIndex].copyWith(note: value);
    setState(() {});
  }

  onSubpartNoteEdit({required RepairPart part, required RepairSubpart subpart, required String value}) {
    int partIndex = parts.indexOf(part);
    RepairPart topPart = parts[partIndex];
    int subpartIndex = topPart.subparts.indexOf(subpart);
    topPart.subparts[subpartIndex] = subpart.copyWith(note: value);
    parts[partIndex] = topPart;
    setState(() {});
  }

  double totalPrice() {
    double total = 0;
    for (var part in parts) {
      if (part.selected) {
        total += part.price;
        for (var subpart in part.subparts) {
          total += subpart.price;
        }
      }
    }
    return total;
  }

  bool get validForAgree {
    return parts.any((part) => part.selected);
  }

  onAgree() {
    widget.onAgree(parts);
  }

  onDecline() {
    widget.onDecline();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text(
              'Employee nickname: ',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.offerCreatedDetails.employeeNick,
              style: const TextStyle(
                color: AppColors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        partsTableHeader(),
        const SizedBox(height: 16),
        ...widget.offerCreatedDetails.parts.map((part) {
          return Column(
            children: [
              PartTile(
                part: part,
                onPartSelect: onPartSelect,
                onNoteEdit: (value) => onPartNoteEdit(part: part, value: value),
              ),
              ...part.subparts
                  .map(
                    (subpart) => SubpartTile(
                      part: part,
                      subpart: subpart,
                      onNoteEdit: (value) => onSubpartNoteEdit(part: part, subpart: subpart, value: value),
                    ),
                  )
                  .toList(),
              const SizedBox(height: 16),
            ],
          );
        }).toList(),
        const SizedBox(height: 16),
        Row(
          children: [
            const Text(
              'Total: ',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Text(
              totalPrice().toString(),
              style: const TextStyle(
                color: AppColors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
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
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.offerCreatedDetails.noteForClient,
              style: const TextStyle(
                color: AppColors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const MinSpacer(minHeight: 32),
        SizedBox(
          width: 546,
          child: RegularButton(
            onTap: validForAgree ? onAgree : null,
            text: 'Agree',
            color: validForAgree ? AppColors.primary : AppColors.gray,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: 546,
          child: RegularButton(
            onTap: onDecline,
            text: 'Decline',
            color: AppColors.red,
          ),
        ),
      ],
    );
  }

  Widget partsTableHeader() {
    return Row(
      children: const [
        SizedBox(width: 40),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Name',
              textAlign: TextAlign.start,
            ),
          ),
        ),
        SizedBox(
          width: 1,
        ),
        SizedBox(
          width: 100,
          child: Text(
            'Date',
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          width: 1,
        ),
        SizedBox(
          width: 80,
          child: Text(
            'Price',
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          width: 1,
        ),
        SizedBox(
          width: 80,
        ),
      ],
    );
  }
}

class PartTile extends StatefulWidget {
  const PartTile({Key? key, required this.part, required this.onPartSelect, required this.onNoteEdit}) : super(key: key);
  final RepairPart part;
  final Function(RepairPart) onPartSelect;
  final Function(String) onNoteEdit;

  @override
  State<PartTile> createState() => _PartTileState();
}

class _PartTileState extends State<PartTile> {
  bool showNote = false;

  @override
  void initState() {
    super.initState();
    showNote = widget.part.note.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
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
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => widget.onPartSelect(widget.part),
                  child: Icon(widget.part.selected ? Icons.check_box : Icons.check_box_outline_blank),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 1,
                  height: double.infinity,
                  color: AppColors.primary,
                ),
                Expanded(
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        widget.part.name,
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
                    DateFormat.yMMMd().format(widget.part.date),
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
                    widget.part.price.toString(),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: 1,
                  height: double.infinity,
                  color: AppColors.primary,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() => showNote = true);
                  },
                  child: const SizedBox(
                    width: 60,
                    child: Icon(Icons.comment, color: AppColors.primary),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (showNote) ...[
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            width: 546,
            child: noteField(),
          ),
          const SizedBox(
            height: 8,
          ),
        ]
      ],
    );
  }

  Widget noteField() {
    return TextFormField(
      initialValue: widget.part.note,
      keyboardType: TextInputType.text,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }

        return null;
      },
      onChanged: (value) => widget.onNoteEdit(value),
      decoration: InputDecoration(
        isDense: true,
        counter: const SizedBox(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        filled: true,
        labelText: 'Note',
        fillColor: Colors.white70,
      ),
    );
  }
}

class SubpartTile extends StatefulWidget {
  const SubpartTile({Key? key, required this.part, required this.subpart, required this.onNoteEdit}) : super(key: key);
  final RepairPart part;
  final RepairSubpart subpart;

  final Function(String) onNoteEdit;

  @override
  State<SubpartTile> createState() => _SubpartTileState();
}

class _SubpartTileState extends State<SubpartTile> {
  bool showNote = false;

  @override
  void initState() {
    super.initState();
    showNote = widget.subpart.note.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
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
                const SizedBox(width: 8),
                Icon(widget.part.selected ? Icons.check_box : Icons.check_box_outline_blank),
                const SizedBox(width: 8),
                Container(
                  width: 1,
                  height: double.infinity,
                  color: AppColors.primary,
                ),
                Expanded(
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        widget.subpart.name,
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
                    DateFormat.yMMMd().format(widget.subpart.date),
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
                    widget.subpart.price.toString(),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: 1,
                  height: double.infinity,
                  color: AppColors.primary,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() => showNote = true);
                  },
                  child: const SizedBox(
                    width: 60,
                    child: Icon(Icons.comment, color: AppColors.primary),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (showNote) ...[
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            width: 546,
            child: noteField(),
          ),
          const SizedBox(
            height: 8,
          ),
        ]
      ],
    );
  }

  Widget noteField() {
    return TextFormField(
      initialValue: widget.subpart.note,
      keyboardType: TextInputType.text,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }

        return null;
      },
      onChanged: (value) => widget.onNoteEdit(value),
      decoration: InputDecoration(
        isDense: true,
        counter: const SizedBox(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        filled: true,
        labelText: 'Note',
        fillColor: Colors.white70,
      ),
    );
  }
}
