import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:serv_expert_webclient/data/exceptions.dart';
import 'package:serv_expert_webclient/data/models/repair_service/breaking_type.dart';

abstract class RSBreakingTypesRepository {
  Future setBreakingType(RSBreakingType rsBreakingType);
  Future<List<RSBreakingType>> breakingTypes({String? categoryId});
}

class RSBreakingTypesRepositoryImpl implements RSBreakingTypesRepository {
  CollectionReference get _ref => FirebaseFirestore.instance.collection('rs_breaking_types');

  @override
  Future setBreakingType(RSBreakingType rsBreakingType) async {
    try {
      await _ref.doc(rsBreakingType.id).set(rsBreakingType.toMap());
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        throw PermissionDenied(e.message!);
      } else {
        throw UnknownException(e.toString());
      }
    }
  }

  @override
  Future<List<RSBreakingType>> breakingTypes({String? categoryId}) async {
    try {
      Query query = _ref;

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
