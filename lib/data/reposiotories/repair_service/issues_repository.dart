import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:serv_expert_webclient/data/exceptions.dart';
import 'package:serv_expert_webclient/data/models/repair_service/issue.dart';

abstract class RSIssuesRepository {
  Future<List<RSIssue>> issues({String? categoryId});
  Future<RSIssue> issue(String id);
}

class RSIssuesRepositoryImpl implements RSIssuesRepository {
  CollectionReference get _ref => FirebaseFirestore.instance.collection('rs_issues');

  @override
  Future<List<RSIssue>> issues({String? categoryId}) async {
    try {
      Query query = _ref;

      query = query.where('categoryId', isEqualTo: categoryId, isNull: categoryId == null);

      QuerySnapshot snapshot = await query.get();
      return snapshot.docs.map((e) => RSIssue.fromMap(e.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      if (e is FirebaseException && e.code == 'permission-denied') {
        throw PermissionDenied(e.message!);
      } else {
        throw UnknownException(e.toString());
      }
    }
  }

  @override
  Future<RSIssue> issue(String id) async {
    try {
      DocumentSnapshot snapshot = await _ref.doc(id).get();
      if (!snapshot.exists) throw UnexistedResource('RSIssue with id $id does not exist');
      return RSIssue.fromMap(snapshot.data() as Map<String, dynamic>);
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
}
