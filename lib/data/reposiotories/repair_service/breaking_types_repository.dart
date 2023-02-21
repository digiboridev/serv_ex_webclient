import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:serv_expert_webclient/data/exceptions.dart';
import 'package:serv_expert_webclient/data/models/repair_service/breaking_type.dart';

abstract class RSBreakingTypesRepository {
  Future setVendorBreakingType({required vendorId, required RSBreakingType rsBreakingType});
  Future<List<RSBreakingType>> vendorBreakingTypes(String vendorId, {String? categoryId});
}

class RSBreakingTypesRepositoryImpl implements RSBreakingTypesRepository {
  CollectionReference _vendorBrRef(String vendorId) =>
      FirebaseFirestore.instance.collection('repair_service_vendors').doc(vendorId).collection('breaking_types');

  @override
  Future setVendorBreakingType({required vendorId, required RSBreakingType rsBreakingType}) async {
    try {
      await _vendorBrRef(vendorId).doc(rsBreakingType.id).set(rsBreakingType.toMap());
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        throw PermissionDenied(e.message!);
      } else {
        throw UnknownException(e.toString());
      }
    }
  }

  @override
  Future<List<RSBreakingType>> vendorBreakingTypes(String vendorId, {String? categoryId}) async {
    try {
      Query query = _vendorBrRef(vendorId);

      query = query.where('categoryId', isEqualTo: categoryId, isNull: categoryId == null);

      QuerySnapshot snapshot = await query.get();
      return snapshot.docs.map((e) => RSBreakingType.fromMap(e.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      if (e is FirebaseException && e.code == 'permission-denied') {
        throw PermissionDenied(e.message!);
      } else {
        throw UnknownException(e.toString());
      }
    }
  }
}
