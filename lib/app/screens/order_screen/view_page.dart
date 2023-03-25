// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/app/providers/repair_service/order_provider.dart';
import 'package:serv_expert_webclient/app/screens/order_screen/components/confirmed_offer_details.dart';
import 'package:serv_expert_webclient/app/screens/order_screen/components/offer_details.dart';
import 'package:serv_expert_webclient/app/screens/order_screen/components/offer_form.dart';
import 'package:serv_expert_webclient/app/screens/order_screen/components/order_accept_details.dart';
import 'package:serv_expert_webclient/app/screens/order_screen/components/order_details_info.dart';
import 'package:serv_expert_webclient/app/screens/order_screen/components/sign_form.dart';
import 'package:serv_expert_webclient/app/screens/order_screen/components/sign_view.dart';
import 'package:serv_expert_webclient/core/app_colors.dart';
import 'package:serv_expert_webclient/core/log.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/order.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/repair_part.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/sign.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/status.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/status_details/closed.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/status_details/declined_offer.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/status_details/offer_created.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/status_details/work_finished.dart';
import 'package:serv_expert_webclient/global_providers.dart';
import 'package:serv_expert_webclient/router.gr.dart';
import 'package:serv_expert_webclient/widgets/fillable_scrollable_wrapper.dart';
import 'package:serv_expert_webclient/widgets/loading_wrapper.dart';
import 'package:serv_expert_webclient/widgets/min_spacer.dart';
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
  RSOStatusType? showPrevStatus;

  cancellOrder() {
    context.router.navigate(OrderCancellPageRoute());
  }

  onOfferAgree(List<RepairPart> parts) async {
    setState(() => busy = true);
    try {
      await ref.read(rsOrdersServiceProvider).confirmOffer(orderId: widget.orderId, parts: parts);
    } catch (e, s) {
      log(e, stackTrace: s);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
    if (mounted) setState(() => busy = false);
  }

  onOfferDecline() async {
    setState(() => busy = true);
    try {
      await ref.read(rsOrdersServiceProvider).declineOffer(orderId: widget.orderId);
    } catch (e, s) {
      log(e, stackTrace: s);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
    if (mounted) setState(() => busy = false);
  }

  onPayForDiagnostic() async {
    setState(() => busy = true);
    try {
      await ref.read(rsOrdersServiceProvider).payForDiagnostic(orderId: widget.orderId);
    } catch (e, s) {
      log(e, stackTrace: s);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
    if (mounted) setState(() => busy = false);
  }

  onPayForOffer() async {
    setState(() => busy = true);
    try {
      await ref.read(rsOrdersServiceProvider).payForOffer(orderId: widget.orderId);
    } catch (e, s) {
      log(e, stackTrace: s);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
    if (mounted) setState(() => busy = false);
  }

  sendSignature(RSOrderSign signnature) async {
    setState(() => busy = true);
    try {
      await ref.read(rsOrdersServiceProvider).sendSignature(orderId: widget.orderId, signnature: signnature);
    } catch (e, s) {
      log(e, stackTrace: s);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
    if (mounted) setState(() => busy = false);
  }

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
      child: FillableScrollableWrapper(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 16),
              const SizedBox(height: 32),
              orderId(order),
              const SizedBox(height: 16),
              paidAndLocation(order),
              SizedBox(height: 16),
              statuses(order),
              const SizedBox(height: 16),
              Expanded(child: body(order)),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox paidAndLocation(RSOrder order) {
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          if (order.deviceLocation == DeviceLocation.client) StatusTile(text: 'At Client', active: false),
          if (order.deviceLocation == DeviceLocation.laboratory) StatusTile(text: 'At laboratory', active: false),
          if (order.paymentStatus == PaymentStatus.paid) StatusTile(text: 'Paid', active: false),
          if (order.paymentStatus == PaymentStatus.notPaid) StatusTile(text: 'Paid\'nt', active: false),
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
    if (order.status.currentStatus == RSOStatusType.newOrder) {
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
    if (order.status.currentStatus == RSOStatusType.canceled) {
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

    if (order.status.currentStatus == RSOStatusType.accepted) {
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

    if (order.status.currentStatus == RSOStatusType.onDiagnostic) {
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

    if (order.status.currentStatus == RSOStatusType.offerCreated) {
      return SizedBox(
        width: double.infinity,
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            GestureDetector(
              child: StatusTile(text: 'Accepted order', active: showPrevStatus == RSOStatusType.accepted),
              onTap: () => setState(() => showPrevStatus = RSOStatusType.accepted),
            ),
            GestureDetector(
              child: StatusTile(text: 'Offer created', active: showPrevStatus == null),
              onTap: () => setState(() => showPrevStatus = null),
            ),
          ],
        ),
      );
    }

    if (order.status.currentStatus == RSOStatusType.confirmedOffer) {
      return SizedBox(
        width: double.infinity,
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            GestureDetector(
              child: StatusTile(text: 'Accepted order', active: showPrevStatus == RSOStatusType.accepted),
              onTap: () => setState(() => showPrevStatus = RSOStatusType.accepted),
            ),
            GestureDetector(
              child: StatusTile(text: 'Offer created', active: showPrevStatus == RSOStatusType.offerCreated),
              onTap: () => setState(() => showPrevStatus = RSOStatusType.offerCreated),
            ),
            GestureDetector(
              child: StatusTile(text: 'Offer confirmed', active: showPrevStatus == null),
              onTap: () => setState(() => showPrevStatus = null),
            ),
          ],
        ),
      );
    }

    if (order.status.currentStatus == RSOStatusType.declinedOffer) {
      return SizedBox(
        width: double.infinity,
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            GestureDetector(
              child: StatusTile(text: 'Accepted order', active: showPrevStatus == RSOStatusType.accepted),
              onTap: () => setState(() => showPrevStatus = RSOStatusType.accepted),
            ),
            GestureDetector(
              child: StatusTile(text: 'Offer created', active: showPrevStatus == RSOStatusType.offerCreated),
              onTap: () => setState(() => showPrevStatus = RSOStatusType.offerCreated),
            ),
            GestureDetector(
              child: StatusTile(text: 'Offer declined', active: showPrevStatus == null),
              onTap: () => setState(() => showPrevStatus = null),
            ),
          ],
        ),
      );
    }

    if (order.status.currentStatus == RSOStatusType.waitingForParts || order.status.currentStatus == RSOStatusType.inProgress) {
      return SizedBox(
        width: double.infinity,
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            GestureDetector(
              child: StatusTile(text: 'Accepted order', active: showPrevStatus == RSOStatusType.accepted),
              onTap: () => setState(() => showPrevStatus = RSOStatusType.accepted),
            ),
            GestureDetector(
              child: StatusTile(text: 'Offer created', active: showPrevStatus == RSOStatusType.offerCreated),
              onTap: () => setState(() => showPrevStatus = RSOStatusType.offerCreated),
            ),
            GestureDetector(
              child: StatusTile(text: 'Offer confirmed', active: showPrevStatus == RSOStatusType.confirmedOffer),
              onTap: () => setState(() => showPrevStatus = RSOStatusType.confirmedOffer),
            ),
            if (order.status.currentStatus == RSOStatusType.waitingForParts)
              GestureDetector(
                child: StatusTile(text: 'Wait for parts', active: showPrevStatus == null),
                onTap: () => setState(() => showPrevStatus = null),
              ),
            if (order.status.currentStatus == RSOStatusType.inProgress)
              GestureDetector(
                child: StatusTile(text: 'Work in progress', active: showPrevStatus == null),
                onTap: () => setState(() => showPrevStatus = null),
              ),
          ],
        ),
      );
    }

    if (order.status.currentStatus == RSOStatusType.workFinished) {
      return SizedBox(
        width: double.infinity,
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            GestureDetector(
              child: StatusTile(text: 'Accepted order', active: showPrevStatus == RSOStatusType.accepted),
              onTap: () => setState(() => showPrevStatus = RSOStatusType.accepted),
            ),
            if (order.status.workFinishedDetails!.finishedAfter == FinishedAfterType.offer) ...[
              GestureDetector(
                child: StatusTile(text: 'Offer created', active: showPrevStatus == RSOStatusType.offerCreated),
                onTap: () => setState(() => showPrevStatus = RSOStatusType.offerCreated),
              ),
              GestureDetector(
                child: StatusTile(text: 'Work finished', active: showPrevStatus == null),
                onTap: () => setState(() => showPrevStatus = null),
              ),
            ],
            if (order.status.workFinishedDetails!.finishedAfter == FinishedAfterType.diagnistic) ...[
              GestureDetector(
                child: StatusTile(text: 'Work finished, after diagnostic', active: showPrevStatus == null),
                onTap: () => setState(() => showPrevStatus = null),
              ),
            ],
          ],
        ),
      );
    }

    if (order.status.currentStatus == RSOStatusType.closed) {
      return SizedBox(
        width: double.infinity,
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            GestureDetector(
              child: StatusTile(text: 'Accepted order', active: showPrevStatus == RSOStatusType.accepted),
              onTap: () => setState(() => showPrevStatus = RSOStatusType.accepted),
            ),
            if (order.status.offerCreatedDetails != null)
              GestureDetector(
                child: StatusTile(text: 'Offer created', active: showPrevStatus == RSOStatusType.offerCreated),
                onTap: () => setState(() => showPrevStatus = RSOStatusType.offerCreated),
              ),
            if (order.status.confirmedOfferDetails != null)
              GestureDetector(
                child: StatusTile(text: 'Offer confirmed', active: showPrevStatus == RSOStatusType.confirmedOffer),
                onTap: () => setState(() => showPrevStatus = RSOStatusType.confirmedOffer),
              ),
            if (order.status.declinedOfferDetails != null)
              GestureDetector(
                child: StatusTile(text: 'Offer declined', active: showPrevStatus == RSOStatusType.declinedOffer),
                onTap: () => setState(() => showPrevStatus = RSOStatusType.declinedOffer),
              ),
            GestureDetector(
              child: StatusTile(text: 'Closed', active: showPrevStatus == null),
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

    if (showPrevStatus == RSOStatusType.accepted) {
      return acceptedOrderContent(order, onlyView: true);
    }

    if (showPrevStatus == RSOStatusType.offerCreated) {
      return offerCreatedOrderContent(order, onlyView: true);
    }

    if (showPrevStatus == RSOStatusType.confirmedOffer) {
      return offerConfirmedContent(order, onlyView: true);
    }

    if (showPrevStatus == RSOStatusType.declinedOffer) {
      return offerDeclinedContent(order, onlyView: true);
    }

    // actual status view

    if (order.status.currentStatus == RSOStatusType.newOrder) {
      return newOrderContent(order);
    }
    if (order.status.currentStatus == RSOStatusType.canceled) {
      return canceledOrderContent(order);
    }

    if (order.status.currentStatus == RSOStatusType.accepted) {
      return acceptedOrderContent(order);
    }

    if (order.status.currentStatus == RSOStatusType.onDiagnostic) {
      return onDiagnosticOrderContent(order);
    }

    if (order.status.currentStatus == RSOStatusType.offerCreated) {
      return offerCreatedOrderContent(order);
    }

    if (order.status.currentStatus == RSOStatusType.confirmedOffer) {
      return offerConfirmedContent(order);
    }

    if (order.status.currentStatus == RSOStatusType.declinedOffer) {
      return offerDeclinedContent(order);
    }

    if (order.status.currentStatus == RSOStatusType.waitingForParts) {
      return waitForPartsContent(order);
    }

    if (order.status.currentStatus == RSOStatusType.inProgress) {
      return inProgressContent(order);
    }

    if (order.status.currentStatus == RSOStatusType.workFinished) {
      return workFinishedContent(order);
    }

    if (order.status.currentStatus == RSOStatusType.closed) {
      return closedContent(order);
    }

    return SizedBox();
  }

  Column closedContent(RSOrder order) {
    RSOrderClosedDetails closedDetails = order.status.closedDetails!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 32),
        SignView(
          signnature: closedDetails.signnature,
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget workFinishedContent(RSOrder order) {
    RSOrderWorkFinishedDetails workFinishedDetails = order.status.workFinishedDetails!;

    if (workFinishedDetails.signRequested) {
      return SignForm(
        onSubmit: sendSignature,
        signnature: workFinishedDetails.signnature,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 32),
        MinSpacer(minHeight: 32),
        Text('Finished'),
        MinSpacer(minHeight: 32),
        if (workFinishedDetails.paymentRequired && order.paymentStatus != PaymentStatus.paid) ...[
          if (workFinishedDetails.finishedAfter == FinishedAfterType.offer)
            SizedBox(
              width: 546,
              child: RegularButton(
                onTap: onPayForOffer,
                text: 'Pay for work',
              ),
            ),
          if (workFinishedDetails.finishedAfter == FinishedAfterType.diagnistic)
            SizedBox(
              width: 546,
              child: RegularButton(
                onTap: onPayForDiagnostic,
                text: 'Pay for diagnostic',
              ),
            ),
        ],
        const SizedBox(height: 32),
      ],
    );
  }

  Column inProgressContent(RSOrder order) {
    RSOrderOfferCreatedDetails offerCreatedDetails = order.status.offerCreatedDetails!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 32),
        MinSpacer(minHeight: 32),
        Text('Work in progress'),
        MinSpacer(minHeight: 32),
        if (offerCreatedDetails.withPayment && order.paymentStatus != PaymentStatus.paid) ...[
          SizedBox(width: 546, child: RegularButton(onTap: onPayForOffer, text: 'Pay for work')),
        ],
        const SizedBox(height: 32),
      ],
    );
  }

  Column waitForPartsContent(RSOrder order) {
    RSOrderOfferCreatedDetails offerCreatedDetails = order.status.offerCreatedDetails!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 32),
        MinSpacer(minHeight: 32),
        Text('Waiting for parts'),
        MinSpacer(minHeight: 32),
        if (offerCreatedDetails.withPayment && order.paymentStatus != PaymentStatus.paid) ...[
          SizedBox(width: 546, child: RegularButton(onTap: onPayForOffer, text: 'Pay for work')),
        ],
        const SizedBox(height: 32),
      ],
    );
  }

  Column offerDeclinedContent(RSOrder order, {bool onlyView = false}) {
    RSOrderDeclinedOfferDetails declinedOfferDetails = order.status.declinedOfferDetails!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 32),
        OfferDetails(order: order),
        if (!onlyView)
          if (declinedOfferDetails.afterDiagnostic) ...[
            MinSpacer(minHeight: 32),
            SizedBox(width: 546, child: RegularButton(onTap: onPayForDiagnostic, text: 'Pay for diagnostic')),
          ],
        const SizedBox(height: 32),
      ],
    );
  }

  Column offerConfirmedContent(RSOrder order, {bool onlyView = false}) {
    RSOrderOfferCreatedDetails offerCreatedDetails = order.status.offerCreatedDetails!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 16),
        ConfirmedOfferDetails(order: order),
        SizedBox(height: 16),
        if (!onlyView)
          if (order.paymentStatus != PaymentStatus.paid && offerCreatedDetails.withPayment) ...[
            MinSpacer(minHeight: 32),
            if (offerCreatedDetails.prepayRequired)
              SizedBox(
                width: 546,
                child: RegularButton(
                  onTap: onPayForOffer,
                  text: 'Prepay',
                ),
              )
            else
              SizedBox(
                width: 546,
                child: RegularButton(
                  onTap: onPayForOffer,
                  text: 'Pay for work',
                ),
              ),
          ],
        const SizedBox(height: 32),
      ],
    );
  }

  Column offerCreatedOrderContent(RSOrder order, {bool onlyView = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 16),
        if (onlyView)
          OfferDetails(order: order)
        else
          Expanded(
            child: OfferForm(
              offerCreatedDetails: order.status.offerCreatedDetails!,
              onAgree: onOfferAgree,
              onDecline: onOfferDecline,
            ),
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
        Align(alignment: Alignment.centerLeft, child: OrderAcceptDetails(acceptDetails: order.status.acceptedDetails!)),
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
        Align(alignment: Alignment.centerLeft, child: OrderAcceptDetails(acceptDetails: order.status.acceptedDetails!)),
        const SizedBox(height: 32),
      ],
    );
  }

  Column newOrderContent(RSOrder order) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(alignment: Alignment.centerLeft, child: OrderDetailsInfo(order: order)),
        MinSpacer(minHeight: 32),
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
