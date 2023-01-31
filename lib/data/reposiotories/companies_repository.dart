import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:serv_expert_webclient/data/exceptions.dart';
import 'package:serv_expert_webclient/data/models/company/company.dart';

class CompaniesRepository {
  CollectionReference get _ref => FirebaseFirestore.instance.collection('companies');

  Future createCompany({
    required String publicId,
    required String companyName,
    required String companyEmail,
    required String memberId,
  }) async {
    String id = _ref.doc().id;

    Company newCompany = Company(
      id: id,
      publicId: publicId,
      name: companyName,
      email: companyEmail,
      membersIds: [memberId],
    );

    try {
      await _ref.doc(id).set(newCompany.toMap());
    } catch (e) {
      if (e is FirebaseException && e.code == 'permission-denied') {
        throw PermissionDenied(e.message!);
      } else {
        throw UnknownException(e.toString());
      }
    }
  }

  Future<Company> companyById({required String id, bool forceNetwork = false}) async {
    try {
      DocumentSnapshot snapshot = await _ref.doc(id).get(forceNetwork ? const GetOptions(source: Source.server) : null);

      if (snapshot.exists) {
        return Company.fromMap(snapshot.data() as Map<String, dynamic>);
      } else {
        throw UnexistedResource('Copmany with id $id does not exist');
      }
    } catch (e) {
      if (e is FirebaseException && e.code == 'permission-denied') {
        throw PermissionDenied(e.message!);
      } else {
        throw UnknownException(e.toString());
      }
    }
  }

  Future<List<Company>> companiesByMemberId({required String memberId}) async {
    try {
      QuerySnapshot snapshot = await _ref.where('membersIds', arrayContains: memberId).get();

      return snapshot.docs.map((e) => Company.fromMap(e.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      if (e is FirebaseException && e.code == 'permission-denied') {
        throw PermissionDenied(e.message!);
      } else {
        throw UnknownException(e.toString());
      }
    }
  }

  Stream<List<Company>> companiesByMemberIdStream({required String memberId}) {
    return _ref
        .where('membersIds', arrayContains: memberId)
        .snapshots()
        .transform(StreamTransformer<QuerySnapshot<Map<String, dynamic>>, List<Company>>.fromHandlers(
          handleData: (snapshot, sink) async {
            List<Company> c = await compute((docs) => docs.map((e) => Company.fromMap(e.data())).toList(), snapshot.docs);
            sink.add(c);
          },
          handleError: (error, stackTrace, sink) {
            if (error is FirebaseException && error.code == 'permission-denied') {
              sink.addError(PermissionDenied(error.message!));
            } else {
              sink.addError(UnknownException(error.toString()));
            }
          },
          handleDone: (sink) => sink.close(),
        ));
  }
}
