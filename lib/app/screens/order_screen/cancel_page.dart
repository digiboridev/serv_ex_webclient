import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/core/app_colors.dart';
import 'package:serv_expert_webclient/core/log.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/status_details/cancelled.dart';
import 'package:serv_expert_webclient/global_providers.dart';
import 'package:serv_expert_webclient/services/rs_orders_service.dart';
import 'package:serv_expert_webclient/widgets/fillable_scrollable_wrapper.dart';
import 'package:serv_expert_webclient/widgets/headline.dart';
import 'package:serv_expert_webclient/widgets/loading_wrapper.dart';
import 'package:serv_expert_webclient/widgets/min_spacer.dart';
import 'package:serv_expert_webclient/widgets/regular_button.dart';

class OrderCancellPage extends ConsumerStatefulWidget {
  const OrderCancellPage({@PathParam('orderId') required this.orderId, super.key});

  final String orderId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrderCancellPageState();
}

class _OrderCancellPageState extends ConsumerState<OrderCancellPage> {
  bool busy = false;

  RSOCancellationReasons? selectedReason;
  String description = '';

  onReasonSelected(RSOCancellationReasons reason) {
    setState(() {
      selectedReason = reason;
    });
  }

  bool get isDescriptionEnabled => selectedReason == RSOCancellationReasons.other;

  onCancel() async {
    if (selectedReason == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select reason'),
        ),
      );
      return;
    }

    RSOCancellDetails cancellDetails = RSOCancellDetails(
      reason: selectedReason!,
      description: description,
      actor: RSOCancelledActor.customer,
    );

    RSOrdersService ordersService = ref.read(rsOrdersServiceProvider);

    setState(() => busy = true);
    try {
      await ordersService.cancelOrder(orderId: widget.orderId, details: cancellDetails);
      if (mounted) context.router.navigateBack();
    } catch (e, s) {
      log(e, stackTrace: s);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to cancel order: $e'),
        ),
      );
    }
    if (mounted) setState(() => busy = false);
  }

  @override
  Widget build(BuildContext context) {
    return FillableScrollableWrapper(
      child: LoadingWrapper(
        busy: busy,
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 8),
              topBar,
              const SizedBox(height: 42),
              SizedBox(width: double.infinity, child: Headline(text: 'Cancel order')),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: Text(
                  'Choose reason for cancellation',
                  style: const TextStyle(
                    color: AppColors.black60,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              reasonsList(),
              const SizedBox(height: 20),
              Align(alignment: Alignment.centerLeft, child: SizedBox(width: 546, child: descriptionField())),
              MinSpacer(
                minHeight: 32,
              ),
              SizedBox(
                width: 546,
                child: RegularButton(
                  onTap: () => onCancel(),
                  text: 'Cancel',
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                  ),
                  color: AppColors.red,
                  // padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  // borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget descriptionField() {
    return TextFormField(
      enabled: isDescriptionEnabled,
      keyboardType: TextInputType.text,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }

        return null;
      },
      onFieldSubmitted: (value) => onCancel(),
      onChanged: (value) => description = value,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w400,
        color: AppColors.black,
      ),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        counter: const SizedBox(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        filled: true,
        labelText: 'Description',
        fillColor: Colors.white70,
      ),
    );
  }

  Widget reasonsList() {
    return Column(
      children: RSOCancellationReasons.values.map((reason) {
        return Row(
          children: [
            Checkbox(
              activeColor: AppColors.primary,
              value: selectedReason == reason,
              onChanged: (value) => onReasonSelected(reason),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              reason.name,
              style: const TextStyle(
                color: AppColors.black,
                fontSize: 22,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget get topBar {
    return Row(
      children: [
        RegularButton(
          onTap: () {
            context.router.navigateBack();
          },
          text: 'Back',
          textStyle: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          color: AppColors.red,
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          borderRadius: BorderRadius.circular(4),
        ),
        const Spacer(),
      ],
    );
  }
}
