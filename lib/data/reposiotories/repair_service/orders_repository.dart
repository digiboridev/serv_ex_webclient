import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:serv_expert_webclient/data/exceptions.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/order.dart';

abstract class RSOrdersRepository {
  String generateId();
  Future setOrder(RSOrder order);
  Future<List<RSOrder>> orders();
  Future<RSOrder> orderById({required String id, bool forceNetwork = false});
  Future<List<RSOrder>> ordersByCustomerId({required String id, bool forceNetwork = false});
  Stream<List<RSOrder>> ordersByCustomerIdStream({required String id});
  Future<List<RSOrder>> ordersByVendorId({required String id, bool forceNetwork = false});
}

class RSOrdersRepositoryImpl implements RSOrdersRepository {
  CollectionReference get _ref => FirebaseFirestore.instance.collection('repair_service_orders');

  @override
  String generateId() => _ref.doc().id;

  @override
  Future setOrder(RSOrder order) async {
    try {
      await _ref.doc(order.id).set(order.toMap());
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        throw PermissionDenied(e.message!);
      } else {
        throw UnknownException(e.toString());
      }
    }
  }

  @override
  Future<List<RSOrder>> orders() async {
    try {
      QuerySnapshot snapshot = await _ref.get();
      return snapshot.docs.map((e) => RSOrder.fromMap(e.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      if (e is FirebaseException && e.code == 'permission-denied') {
        throw PermissionDenied(e.message!);
      } else {
        throw UnknownException(e.toString());
      }
    }
  }

  @override
  Future<RSOrder> orderById({required String id, bool forceNetwork = false}) async {
    try {
      DocumentSnapshot snapshot = await _ref.doc(id).get(forceNetwork ? const GetOptions(source: Source.server) : null);
      if (snapshot.exists) {
        return RSOrder.fromMap(snapshot.data() as Map<String, dynamic>);
      } else {
        throw UnexistedResource('Order $id does not exist');
      }
    } catch (e) {
      if (e is FirebaseException && e.code == 'permission-denied') {
        throw PermissionDenied(e.message!);
      } else if (e is UnexistedResource) {
        rethrow;
      } else {
        throw UnknownException(e.toString());
      }
    }
  }

  @override
  Future<List<RSOrder>> ordersByCustomerId({required String id, bool forceNetwork = false}) async {
    try {
      QuerySnapshot snapshot = await _ref.where('customerInfo.customerId', isEqualTo: id).get(forceNetwork ? const GetOptions(source: Source.server) : null);
      return snapshot.docs.map((e) => RSOrder.fromMap(e.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      if (e is FirebaseException && e.code == 'permission-denied') {
        throw PermissionDenied(e.message!);
      } else {
        throw UnknownException(e.toString());
      }
    }
  }

  @override
  Stream<List<RSOrder>> ordersByCustomerIdStream({required String id}) {
    return _ref.where('customerInfo.customerId', isEqualTo: id).snapshots().transform(
          StreamTransformer<QuerySnapshot<Map<String, dynamic>>, List<RSOrder>>.fromHandlers(
            handleData: (snapshot, sink) {
              sink.add(snapshot.docs.map((e) => RSOrder.fromMap(e.data())).toList());
            },
            handleError: (e, stackTrace, sink) {
              if (e is FirebaseException && e.code == 'permission-denied') {
                sink.addError(PermissionDenied(e.message!));
              } else {
                sink.addError(UnknownException(e.toString()));
              }
            },
          ),
        );
  }

  @override
  Future<List<RSOrder>> ordersByVendorId({required String id, bool forceNetwork = false}) async {
    try {
      QuerySnapshot snapshot = await _ref.where('details.vendorId', isEqualTo: id).get(forceNetwork ? const GetOptions(source: Source.server) : null);
      return snapshot.docs.map((e) => RSOrder.fromMap(e.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      if (e is FirebaseException && e.code == 'permission-denied') {
        throw PermissionDenied(e.message!);
      } else {
        throw UnknownException(e.toString());
      }
    }
  }
}
