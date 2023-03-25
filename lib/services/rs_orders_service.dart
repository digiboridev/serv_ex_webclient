// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:serv_expert_webclient/data/dto/repair_service/new_order.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/details.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/order.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/repair_part.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/sign.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/status.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/status_details/cancelled.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/status_details/confirmed_offer.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/status_details/declined_offer.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/status_details/work_finished.dart';
import 'package:serv_expert_webclient/data/reposiotories/repair_service/orders_repository.dart';

// TODO move to backend
class RSOrdersService {
  final RSOrdersRepository _ordersRepository;
  RSOrdersService({
    required RSOrdersRepository ordersRepository,
  }) : _ordersRepository = ordersRepository;

  Future createOrder({required RSNewOrderDTO order}) async {
    if (order.validate() == false) throw Exception('Invalid order');

    RSOrder newOrder = RSOrder(
      id: _ordersRepository.generateId(),
      customerInfo: order.customerInfo!,
      details: RSOrderDetails(
        categoryId: order.categoryId!,
        issueIds: order.issueIds!,
        description: order.description!,
        deviceWet: order.deviceWet!,
        wetDescription: order.wetDescription!,
        accesoriesIncluded: order.accesoriesIncluded!,
        accesoriesDescription: order.accesoriesDescription!,
        hasWaranty: order.hasWaranty!,
        hasPassword: order.hasPassword!,
      ),
      status: RSOStatus(currentStatus: RSOStatusType.newOrder),
      paymentStatus: PaymentStatus.notPaid,
      deviceLocation: DeviceLocation.client,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await _ordersRepository.setOrder(newOrder);
  }

  Future cancelOrder({required String orderId, required RSOCancellDetails details}) async {
    RSOrder order = await _ordersRepository.orderById(id: orderId);
    if (order.status.currentStatus == RSOStatusType.canceled) throw Exception('Order already canceled');

    RSOStatus newStatus = order.status.copyWith(
      currentStatus: RSOStatusType.canceled,
      cancellDetails: details,
    );

    RSOrder newOrder = order.copyWith(
      status: newStatus,
      updatedAt: DateTime.now(),
    );

    await _ordersRepository.setOrder(newOrder);
  }

  Future confirmOffer({required String orderId, required List<RepairPart> parts}) async {
    RSOrder order = await _ordersRepository.orderById(id: orderId);
    if (order.status.currentStatus != RSOStatusType.offerCreated) throw Exception('Invalid order status');

    RSOStatus newStatus = order.status.copyWith(
      currentStatus: RSOStatusType.confirmedOffer,
      confirmedOfferDetails: RSOrderConfirmedOfferDetails(
        confirmationSkipped: false,
        parts: parts,
      ),
    );

    RSOrder newOrder = order.copyWith(
      status: newStatus,
      updatedAt: DateTime.now(),
    );

    await _ordersRepository.setOrder(newOrder);
  }

  Future declineOffer({required String orderId}) async {
    RSOrder order = await _ordersRepository.orderById(id: orderId);
    if (order.status.currentStatus != RSOStatusType.offerCreated) throw Exception('Invalid order status');

    if (order.status.offerCreatedDetails!.afterDiagnostic) {
      RSOStatus newStatus = order.status.copyWith(
        currentStatus: RSOStatusType.declinedOffer,
        declinedOfferDetails: RSOrderDeclinedOfferDetails(afterDiagnostic: true),
      );

      RSOrder newOrder = order.copyWith(
        status: newStatus,
        updatedAt: DateTime.now(),
      );

      await _ordersRepository.setOrder(newOrder);
    } else {
      RSOStatus newStatus = order.status.copyWith(
        currentStatus: RSOStatusType.workFinished,
        declinedOfferDetails: RSOrderDeclinedOfferDetails(afterDiagnostic: false),
        workFinishedDetails: RSOrderWorkFinishedDetails(
          finishedAfter: FinishedAfterType.offer,
          paymentRequired: false,
          signRequested: false,
        ),
      );

      RSOrder newOrder = order.copyWith(
        status: newStatus,
        updatedAt: DateTime.now(),
      );

      await _ordersRepository.setOrder(newOrder);
    }
  }

  Future payForDiagnostic({required String orderId}) async {
    RSOrder order = await _ordersRepository.orderById(id: orderId);

    if (order.status.currentStatus == RSOStatusType.declinedOffer) {
      RSOrderDeclinedOfferDetails declinedOfferDetails = order.status.declinedOfferDetails!;
      if (declinedOfferDetails.afterDiagnostic == false) throw Exception('Invalid order state');

      RSOStatus newStatus = order.status.copyWith(
        currentStatus: RSOStatusType.workFinished,
        workFinishedDetails: RSOrderWorkFinishedDetails(
          finishedAfter: FinishedAfterType.offer,
          paymentRequired: false,
          signRequested: false,
        ),
      );

      RSOrder newOrder = order.copyWith(
        status: newStatus,
        paymentStatus: PaymentStatus.paid,
        updatedAt: DateTime.now(),
      );

      await _ordersRepository.setOrder(newOrder);
    } else if (order.status.currentStatus == RSOStatusType.workFinished) {
      RSOrderWorkFinishedDetails workFinishedDetails = order.status.workFinishedDetails!;
      if (!workFinishedDetails.paymentRequired || (workFinishedDetails.finishedAfter != FinishedAfterType.diagnistic)) throw Exception('Invalid order state');

      RSOrder newOrder = order.copyWith(
        paymentStatus: PaymentStatus.paid,
        updatedAt: DateTime.now(),
      );

      await _ordersRepository.setOrder(newOrder);
    } else {
      throw Exception('Invalid order status');
    }
  }

  Future payForOffer({required String orderId}) async {
    RSOrder order = await _ordersRepository.orderById(id: orderId);
    if (order.status.confirmedOfferDetails == null) throw Exception('Invalid order state');

    RSOrder newOrder = order.copyWith(
      paymentStatus: PaymentStatus.paid,
      updatedAt: DateTime.now(),
    );

    await _ordersRepository.setOrder(newOrder);
  }

  Future sendSignature({required String orderId, required RSOrderSign signnature}) async {
    RSOrder order = await _ordersRepository.orderById(id: orderId);
    if (order.status.currentStatus != RSOStatusType.workFinished) throw Exception('Invalid order state');
    if (order.status.workFinishedDetails!.signRequested == false) throw Exception('Invalid order state');

    RSOStatus newStatus = order.status.copyWith(
      workFinishedDetails: order.status.workFinishedDetails!.copyWith(
        signnature: signnature,
      ),
    );

    RSOrder newOrder = order.copyWith(
      status: newStatus,
      updatedAt: DateTime.now(),
    );

    await _ordersRepository.setOrder(newOrder);
  }
}
