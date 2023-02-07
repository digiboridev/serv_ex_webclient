import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:serv_expert_webclient/data/exceptions.dart';
import 'package:serv_expert_webclient/data/models/repair_service/vendor.dart';

class RepairServiceVendorsRepository {
  CollectionReference get _ref => FirebaseFirestore.instance.collection('repair_service_vendors');

  Future setVendor(RepairServiceVendor vendor) async {
    try {
      await _ref.doc(vendor.id).set(vendor.toMap());
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        throw PermissionDenied(e.message!);
      } else {
        throw UnknownException(e.toString());
      }
    }
  }

  Future<List<RepairServiceVendor>> vendors() async {
    try {
      QuerySnapshot snapshot = await _ref.get();
      return snapshot.docs.map((e) => RepairServiceVendor.fromMap(e.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      if (e is FirebaseException && e.code == 'permission-denied') {
        throw PermissionDenied(e.message!);
      } else {
        throw UnknownException(e.toString());
      }
    }
  }

  Stream<List<RepairServiceVendor>> vendorsStream() {
    return _ref.snapshots().transform(
          StreamTransformer<QuerySnapshot<Map<String, dynamic>>, List<RepairServiceVendor>>.fromHandlers(
            handleData: (snapshot, sink) {
              sink.add(snapshot.docs.map((e) => RepairServiceVendor.fromMap(e.data() as Map<String, dynamic>)).toList());
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

  Future<RepairServiceVendor> vendorById({required String id, bool forceNetwork = false}) async {
    try {
      DocumentSnapshot snapshot = await _ref.doc(id).get(forceNetwork ? const GetOptions(source: Source.server) : null);

      if (snapshot.exists) {
        return RepairServiceVendor.fromMap(snapshot.data() as Map<String, dynamic>);
      } else {
        throw UnexistedResource('Vendor $id does not exist');
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

  Stream<RepairServiceVendor> vendorByIdStream({required String id}) {
    return _ref.doc(id).snapshots().transform(
          StreamTransformer<DocumentSnapshot<Map<String, dynamic>>, RepairServiceVendor>.fromHandlers(
            handleData: (snapshot, sink) {
              if (snapshot.exists) {
                sink.add(RepairServiceVendor.fromMap(snapshot.data() as Map<String, dynamic>));
              } else {
                sink.addError(UnexistedResource('Vendor $id does not exist'));
              }
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
}
