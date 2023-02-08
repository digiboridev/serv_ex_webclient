import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:serv_expert_webclient/data/exceptions.dart';
import 'package:serv_expert_webclient/data/models/repair_service/category.dart';

class RSCategoriesRepository {
  CollectionReference _vendorCatRef(String vendorId) => FirebaseFirestore.instance.collection('repair_service_vendors').doc(vendorId).collection('categories');

  Future setVendorCategory({required vendorId, required RSCategory category}) async {
    try {
      await _vendorCatRef(vendorId).doc(category.id).set(category.toMap());
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        throw PermissionDenied(e.message!);
      } else {
        throw UnknownException(e.toString());
      }
    }
  }

  Future<RSCategory> vendorCategory({required String vendorId, required String categoryId}) async {
    try {
      DocumentSnapshot snapshot = await _vendorCatRef(vendorId).doc(categoryId).get();
      return RSCategory.fromMap(snapshot.data() as Map<String, dynamic>);
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        throw PermissionDenied(e.message!);
      } else {
        throw UnknownException(e.toString());
      }
    }
  }

  Future<List<RSCategory>> vendorCategories(String vendorId, {String? parentId}) async {
    try {
      Query query = _vendorCatRef(vendorId);

      query = query.where('parentId', isEqualTo: parentId, isNull: parentId == null);

      QuerySnapshot snapshot = await query.get();
      return snapshot.docs.map((e) => RSCategory.fromMap(e.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      if (e is FirebaseException && e.code == 'permission-denied') {
        throw PermissionDenied(e.message!);
      } else {
        throw UnknownException(e.toString());
      }
    }
  }
}
