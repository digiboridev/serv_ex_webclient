import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:serv_expert_webclient/data/exceptions.dart';
import 'package:serv_expert_webclient/data/models/company/company.dart';

abstract class CompaniesRepository {
  Future<Company> createCompany({
    required String publicId,
    required String companyName,
    required String companyEmail,
    required String memberId,
  });

  Future updateCompanyMembers({required String companyId, required List<String> membersIds});

  Future<Company> companyById({required String id, bool forceNetwork = false});

  Future<List<Company>> companiesByMemberId({required String memberId, bool forceNetwork = false});

  Stream<List<Company>> companiesByMemberIdStream({required String memberId});
}

class CompaniesRepositoryImpl implements CompaniesRepository {
  CollectionReference get _ref => FirebaseFirestore.instance.collection('companies');

  @override
  Future<Company> createCompany({
    required String publicId,
    required String companyName,
    required String companyEmail,
    required String memberId,
  }) async {
    try {
      String id = _ref.doc().id;

      Company newCompany = Company(
        id: id,
        publicId: publicId,
        name: companyName,
        email: companyEmail,
        membersIds: [memberId],
      );

      await _ref.doc(id).set(newCompany.toMap());

      return newCompany;
    } catch (e) {
      if (e is FirebaseException && e.code == 'permission-denied') {
        throw PermissionDenied(e.message!);
      } else {
        throw UnknownException(e.toString());
      }
    }
  }

  @override
  Future updateCompanyMembers({required String companyId, required List<String> membersIds}) async {
    try {
      await _ref.doc(companyId).update({'membersIds': membersIds});
    } catch (e) {
      if (e is FirebaseException && e.code == 'permission-denied') {
        throw PermissionDenied(e.message!);
      } else {
        throw UnknownException(e.toString());
      }
    }
  }

  @override
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

  @override
  Future<List<Company>> companiesByMemberId({required String memberId, bool forceNetwork = false}) async {
    try {
      QuerySnapshot snapshot = await _ref.where('membersIds', arrayContains: memberId).get(forceNetwork ? const GetOptions(source: Source.server) : null);

      return snapshot.docs.map((e) => Company.fromMap(e.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      if (e is FirebaseException && e.code == 'permission-denied') {
        throw PermissionDenied(e.message!);
      } else {
        throw UnknownException(e.toString());
      }
    }
  }

  @override
  Stream<List<Company>> companiesByMemberIdStream({required String memberId}) {
    return _ref.where('membersIds', arrayContains: memberId).snapshots().transform(
          StreamTransformer<QuerySnapshot<Map<String, dynamic>>, List<Company>>.fromHandlers(
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
          ),
        );
  }
}
