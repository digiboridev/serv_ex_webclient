// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:serv_expert_webclient/data/dto/repair_service/new_order.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/details.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/order.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/repair_part.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/status.dart';
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
      status: RSOrderStatus.newOrder,
      statusesDetails: const RSOrderStatusesDetails(),
      paymentStatus: PaymentStatus.notPaid,
      deviceLocation: DeviceLocation.client,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await _ordersRepository.setOrder(newOrder);
  }

  Future cancelOrder({required String orderId, required RSOCancellDetails details}) async {
    RSOrder order = await _ordersRepository.orderById(id: orderId);
    if (order.status == RSOrderStatus.canceled) throw Exception('Order already canceled');

    RSOrderStatusesDetails newStatusesDetails = order.statusesDetails.copyWith(
      cancellDetails: details,
    );

    RSOrder newOrder = order.copyWith(
      status: RSOrderStatus.canceled,
      statusesDetails: newStatusesDetails,
      updatedAt: DateTime.now(),
    );

    await _ordersRepository.setOrder(newOrder);
  }

  Future confirmOffer({required String orderId, required List<RepairPart> parts}) async {
    RSOrder order = await _ordersRepository.orderById(id: orderId);
    if (order.status != RSOrderStatus.offerCreated) throw Exception('Invalid order status');

    RSOrderStatusesDetails newStatusesDetails = order.statusesDetails.copyWith(
      confirmedOfferDetails: RSOrderConfirmedOfferDetails(
        confirmationSkipped: false,
        parts: parts,
      ),
    );

    RSOrder newOrder = order.copyWith(
      status: RSOrderStatus.confirmedOffer,
      statusesDetails: newStatusesDetails,
      updatedAt: DateTime.now(),
    );

    await _ordersRepository.setOrder(newOrder);
  }

  Future declineOffer({required String orderId}) async {
    RSOrder order = await _ordersRepository.orderById(id: orderId);
    if (order.status != RSOrderStatus.offerCreated) throw Exception('Invalid order status');

    if (order.statusesDetails.offerCreatedDetails!.afterDiagnostic) {
      RSOrderStatusesDetails newStatusesDetails = order.statusesDetails.copyWith(
        declinedOfferDetails: RSOrderDeclinedOfferDetails(afterDiagnostic: true),
      );

      RSOrder newOrder = order.copyWith(
        status: RSOrderStatus.declinedOffer,
        statusesDetails: newStatusesDetails,
        updatedAt: DateTime.now(),
      );

      await _ordersRepository.setOrder(newOrder);
    } else {
      RSOrderStatusesDetails newStatusesDetails = order.statusesDetails.copyWith(
        declinedOfferDetails: RSOrderDeclinedOfferDetails(afterDiagnostic: false),
        workFinishedDetails: RSOrderWorkFinishedDetails(
          finishedAfter: FinishedAfterType.offer,
          paymentRequired: false,
          signRequested: false,
        ),
      );

      RSOrder newOrder = order.copyWith(
        status: RSOrderStatus.workFinished,
        statusesDetails: newStatusesDetails,
        updatedAt: DateTime.now(),
      );

      await _ordersRepository.setOrder(newOrder);
    }
  }

  Future payForDiagnostic({required String orderId}) async {
    RSOrder order = await _ordersRepository.orderById(id: orderId);

    if (order.status == RSOrderStatus.declinedOffer) {
      RSOrderDeclinedOfferDetails declinedOfferDetails = order.statusesDetails.declinedOfferDetails!;
      if (declinedOfferDetails.afterDiagnostic == false) throw Exception('Invalid order state');

      RSOrderStatusesDetails newStatusesDetails = order.statusesDetails.copyWith(
        workFinishedDetails: RSOrderWorkFinishedDetails(
          finishedAfter: FinishedAfterType.offer,
          paymentRequired: false,
          signRequested: false,
        ),
      );

      RSOrder newOrder = order.copyWith(
        status: RSOrderStatus.workFinished,
        statusesDetails: newStatusesDetails,
        paymentStatus: PaymentStatus.paid,
        updatedAt: DateTime.now(),
      );

      await _ordersRepository.setOrder(newOrder);
    } else if (order.status == RSOrderStatus.workFinished) {
      RSOrderWorkFinishedDetails workFinishedDetails = order.statusesDetails.workFinishedDetails!;
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
    if (order.statusesDetails.confirmedOfferDetails == null) throw Exception('Invalid order state');

    RSOrder newOrder = order.copyWith(
      paymentStatus: PaymentStatus.paid,
      updatedAt: DateTime.now(),
    );

    await _ordersRepository.setOrder(newOrder);
  }

  Future sendSignature({required String orderId, required String sign}) async {
    RSOrder order = await _ordersRepository.orderById(id: orderId);
    if (order.status != RSOrderStatus.workFinished) throw Exception('Invalid order state');
    if (order.statusesDetails.workFinishedDetails!.signRequested == false) throw Exception('Invalid order state');

    RSOrderStatusesDetails newStatusesDetails = order.statusesDetails.copyWith(
      workFinishedDetails: order.statusesDetails.workFinishedDetails!.copyWith(
        sign: sign,
      ),
    );

    RSOrder newOrder = order.copyWith(
      statusesDetails: newStatusesDetails,
      updatedAt: DateTime.now(),
    );

    await _ordersRepository.setOrder(newOrder);
  }
}
