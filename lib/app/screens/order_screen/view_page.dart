// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/app/providers/repair_service/order_provider.dart';
import 'package:serv_expert_webclient/app/screens/order_screen/components/offer_details.dart';
import 'package:serv_expert_webclient/app/screens/order_screen/components/offer_form.dart';
import 'package:serv_expert_webclient/app/screens/order_screen/components/order_accept_details.dart';
import 'package:serv_expert_webclient/app/screens/order_screen/components/order_details_info.dart';
import 'package:serv_expert_webclient/app/screens/order_screen/components/repair_parts_table.dart';
import 'package:serv_expert_webclient/core/app_colors.dart';
import 'package:serv_expert_webclient/core/log.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/order.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/repair_part.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/status.dart';
import 'package:serv_expert_webclient/global_providers.dart';
import 'package:serv_expert_webclient/router.gr.dart';
import 'package:serv_expert_webclient/widgets/loading_wrapper.dart';
import 'package:serv_expert_webclient/widgets/regular_button.dart';
import 'package:serv_expert_webclient/widgets/status_tile.dart';

class OrderScreenViewPage extends ConsumerStatefulWidget {
  const OrderScreenViewPage({@PathParam('orderId') required this.orderId, super.key});
  final String orderId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrderScreenViewPageState();
}

class _OrderScreenViewPageState extends ConsumerState<OrderScreenViewPage> {
  bool busy = false;
  RSOrderStatus? showPrevStatus;

  cancellOrder() {
    context.router.navigate(OrderCancellPageRoute());
  }

  onOfferAgree(List<RepairPart> parts) async {
    setState(() => busy = true);
    try {
      await ref.read(rsOrdersServiceProvider).confirmOffer(orderId: widget.orderId, parts: parts);
    } catch (e, s) {
      log(e, stackTrace: s);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
    }
    if (mounted) setState(() => busy = false);
  }

  onOfferDecline() {}

  @override
  Widget build(BuildContext context) {
    RSOrder order = ref.watch(rsOrderStreamProvider(widget.orderId)).value!;

    ref.listen(rsOrderStreamProvider(widget.orderId), (p, n) {
      if (p?.value?.status != n.value?.status) {
        setState(() => showPrevStatus = null);
      }
    });

    return LoadingWrapper(
      busy: busy,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 16),
              const SizedBox(height: 32),
              orderId(order),
              const SizedBox(height: 16),
              paidAndLocation(),
              SizedBox(height: 16),
              statuses(order),
              const SizedBox(height: 16),
              body(order),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox paidAndLocation() {
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: const [
          StatusTile(text: 'Inside laboratory', active: false),
          StatusTile(text: 'Unpayed', active: false),
        ],
      ),
    );
  }

  Widget orderId(RSOrder order) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        'Order: ${order.id}',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 32,
        ),
        softWrap: true,
        textAlign: TextAlign.start,
      ),
    );
  }

  Widget statuses(RSOrder order) {
    if (order.status == RSOrderStatus.newOrder) {
      return SizedBox(
        width: double.infinity,
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: const [
            StatusTile(text: 'New order', active: true),
          ],
        ),
      );
    }
    if (order.status == RSOrderStatus.canceled) {
      return SizedBox(
        width: double.infinity,
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: const [
            StatusTile(text: 'Cancelled', active: true),
          ],
        ),
      );
    }

    if (order.status == RSOrderStatus.accepted) {
      return SizedBox(
        width: double.infinity,
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: const [
            StatusTile(text: 'Accepted order', active: true),
          ],
        ),
      );
    }

    if (order.status == RSOrderStatus.onDiagnostic) {
      return SizedBox(
        width: double.infinity,
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: const [
            StatusTile(text: 'Accepted order', active: false),
            StatusTile(text: 'On diagnostic', active: true),
          ],
        ),
      );
    }

    if (order.status == RSOrderStatus.offerSent) {
      return SizedBox(
        width: double.infinity,
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            GestureDetector(
              child: StatusTile(text: 'Accepted order', active: showPrevStatus == RSOrderStatus.accepted),
              onTap: () => setState(() => showPrevStatus = RSOrderStatus.accepted),
            ),
            GestureDetector(
              child: StatusTile(text: 'Offer sent', active: showPrevStatus == null),
              onTap: () => setState(() => showPrevStatus = null),
            ),
          ],
        ),
      );
    }

    if (order.status == RSOrderStatus.confirmedOffer) {
      return SizedBox(
        width: double.infinity,
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            GestureDetector(
              child: StatusTile(text: 'Accepted order', active: showPrevStatus == RSOrderStatus.accepted),
              onTap: () => setState(() => showPrevStatus = RSOrderStatus.accepted),
            ),
            if (order.statusesDetails.offerSentDetails != null)
              GestureDetector(
                child: StatusTile(text: 'Offer sent', active: showPrevStatus == RSOrderStatus.offerSent),
                onTap: () => setState(() => showPrevStatus = RSOrderStatus.offerSent),
              ),
            GestureDetector(
              child: StatusTile(text: 'Offer confirmed', active: showPrevStatus == null),
              onTap: () => setState(() => showPrevStatus = null),
            ),
          ],
        ),
      );
    }

    return SizedBox();
  }

  Widget body(RSOrder order) {
    // previous status view

    if (showPrevStatus == RSOrderStatus.accepted) {
      return acceptedOrderContent(order, onlyView: true);
    }

    if (showPrevStatus == RSOrderStatus.offerSent) {
      return offerSentOrderContent(order, onlyView: true);
    }

    // actual status view

    if (order.status == RSOrderStatus.newOrder) {
      return newOrderContent(order);
    }
    if (order.status == RSOrderStatus.canceled) {
      return canceledOrderContent(order);
    }

    if (order.status == RSOrderStatus.accepted) {
      return acceptedOrderContent(order);
    }

    if (order.status == RSOrderStatus.onDiagnostic) {
      return onDiagnosticOrderContent(order);
    }

    if (order.status == RSOrderStatus.offerSent) {
      return offerSentOrderContent(order);
    }

    if (order.status == RSOrderStatus.confirmedOffer) {
      return offerConfirmedContent(order);
    }

    return SizedBox();
  }

  Column offerConfirmedContent(RSOrder order) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RepairPartsTable(
          parts: order.statusesDetails.confirmedOfferDetails!.parts,
          showSelection: true,
        ),
        SizedBox(height: 16),
        const SizedBox(height: 16),
        SizedBox(width: 546, child: RegularButton(onTap: cancellOrder, text: 'Cancel order', color: AppColors.red)),
        const SizedBox(height: 32),
      ],
    );
  }

  Column offerSentOrderContent(RSOrder order, {bool onlyView = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 16),
        if (onlyView)
          Align(alignment: Alignment.centerLeft, child: OfferDetails(order: order))
        else
          OfferForm(
            offerSentDetails: order.statusesDetails.offerSentDetails!,
            onAgree: onOfferAgree,
            onDecline: onOfferDecline,
          ),
        const SizedBox(height: 32),
      ],
    );
  }

  Column onDiagnosticOrderContent(RSOrder order) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 16),
        Align(alignment: Alignment.centerLeft, child: OrderDetailsInfo(order: order)),
        const SizedBox(height: 16),
        Align(alignment: Alignment.centerLeft, child: OrderAcceptDetails(acceptDetails: order.statusesDetails.acceptedDetails!)),
        const SizedBox(height: 32),
      ],
    );
  }

  Column acceptedOrderContent(RSOrder order, {bool onlyView = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(alignment: Alignment.centerLeft, child: OrderDetailsInfo(order: order)),
        const SizedBox(height: 16),
        Align(alignment: Alignment.centerLeft, child: OrderAcceptDetails(acceptDetails: order.statusesDetails.acceptedDetails!)),
        const SizedBox(height: 32),
      ],
    );
  }

  Column newOrderContent(RSOrder order) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(alignment: Alignment.centerLeft, child: OrderDetailsInfo(order: order)),
        const SizedBox(height: 16),
        SizedBox(width: 546, child: RegularButton(onTap: cancellOrder, text: 'Cancel order', color: AppColors.red)),
        const SizedBox(height: 32),
      ],
    );
  }

  Column canceledOrderContent(RSOrder order) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: OrderDetailsInfo(
            order: order,
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
