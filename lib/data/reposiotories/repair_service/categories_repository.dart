import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:serv_expert_webclient/data/exceptions.dart';
import 'package:serv_expert_webclient/data/models/repair_service/category.dart';

abstract class RSCategoriesRepository {
  Future setCategory(RSCategory category);
  Future<RSCategory> categoryById({required String categoryId});
  Future<List<RSCategory>> categories({String? parentId});
}

class RSCategoriesRepositoryImpl implements RSCategoriesRepository {
  CollectionReference get _ref => FirebaseFirestore.instance.collection('rs_categories');

  @override
  Future setCategory(RSCategory category) async {
    try {
      await _ref.doc(category.id).set(category.toMap());
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        throw PermissionDenied(e.message!);
      } else {
        throw UnknownException(e.toString());
      }
    }
  }

  @override
  Future<RSCategory> categoryById({required String categoryId}) async {
    try {
      DocumentSnapshot snapshot = await _ref.doc(categoryId).get();
      return RSCategory.fromMap(snapshot.data() as Map<String, dynamic>);
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        throw PermissionDenied(e.message!);
      } else {
        throw UnknownException(e.toString());
      }
    }
  }

  @override
  Future<List<RSCategory>> categories({String? parentId}) async {
    try {
      Query query = _ref;

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
