import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:serv_expert_webclient/data/exceptions.dart';
import 'package:serv_expert_webclient/data/models/repair_service/vendor.dart';

abstract class RSVendorsRepository {
  Future setVendor(RSVendor vendor);
  Future<List<RSVendor>> vendors();
  Stream<List<RSVendor>> vendorsStream();
  Future<RSVendor> vendorById({required String id, bool forceNetwork = false});
}

class RSVendorsRepositoryImpl implements RSVendorsRepository {
  CollectionReference get _ref => FirebaseFirestore.instance.collection('repair_service_vendors');

  @override
  Future setVendor(RSVendor vendor) async {
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

  @override
  Future<List<RSVendor>> vendors() async {
    try {
      QuerySnapshot snapshot = await _ref.get();
      return snapshot.docs.map((e) => RSVendor.fromMap(e.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      if (e is FirebaseException && e.code == 'permission-denied') {
        throw PermissionDenied(e.message!);
      } else {
        throw UnknownException(e.toString());
      }
    }
  }

  @override
  Stream<List<RSVendor>> vendorsStream() {
    return _ref.snapshots().transform(
          StreamTransformer<QuerySnapshot<Map<String, dynamic>>, List<RSVendor>>.fromHandlers(
            handleData: (snapshot, sink) {
              sink.add(snapshot.docs.map((e) => RSVendor.fromMap(e.data())).toList());
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
  Future<RSVendor> vendorById({required String id, bool forceNetwork = false}) async {
    try {
      DocumentSnapshot snapshot = await _ref.doc(id).get(forceNetwork ? const GetOptions(source: Source.server) : null);

      if (snapshot.exists) {
        return RSVendor.fromMap(snapshot.data() as Map<String, dynamic>);
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

  Stream<RSVendor> vendorByIdStream({required String id}) {
    return _ref.doc(id).snapshots().transform(
          StreamTransformer<DocumentSnapshot<Map<String, dynamic>>, RSVendor>.fromHandlers(
            handleData: (snapshot, sink) {
              if (snapshot.exists) {
                sink.add(RSVendor.fromMap(snapshot.data() as Map<String, dynamic>));
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
