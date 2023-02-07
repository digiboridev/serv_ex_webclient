import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:serv_expert_webclient/data/exceptions.dart';
import 'package:serv_expert_webclient/data/models/repair_service/category.dart';

class RSCategoriesRepository {
  // CollectionReference get _globalCatRef => FirebaseFirestore.instance.collection('repair_service_categories');
  CollectionReference _vendorCatRef(String vendorId) => FirebaseFirestore.instance.collection('repair_service_vendors').doc(vendorId).collection('categories');

  // String generateId() => _globalCatRef.doc().id;

  // Future setGlobalCategory(RSCategory category) async {
  //   try {
  //     await _globalCatRef.doc(category.id).set(category.toMap());
  //   } on FirebaseException catch (e) {
  //     if (e.code == 'permission-denied') {
  //       throw PermissionDenied(e.message!);
  //     } else {
  //       throw UnknownException(e.toString());
  //     }
  //   }
  // }

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

  // Future<List<RSCategory>> globalCategories({RSCType? type, String? parentId}) async {
  //   try {
  //     Query query = _globalCatRef;

  //     if (type != null) query = query.where('type', isEqualTo: type.name);
  //     if (parentId != null) query = query.where('parentId', isEqualTo: parentId);

  //     QuerySnapshot snapshot = await query.get();
  //     return snapshot.docs.map((e) => RSCategory.fromMap(e.data() as Map<String, dynamic>)).toList();
  //   } catch (e) {
  //     if (e is FirebaseException && e.code == 'permission-denied') {
  //       throw PermissionDenied(e.message!);
  //     } else {
  //       throw UnknownException(e.toString());
  //     }
  //   }
  // }

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
