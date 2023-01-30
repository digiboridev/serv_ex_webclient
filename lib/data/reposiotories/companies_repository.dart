import 'package:cloud_firestore/cloud_firestore.dart';
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
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        throw PermissionDenied(e.message!);
      } else {
        rethrow;
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
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        throw PermissionDenied(e.message!);
      } else {
        rethrow;
      }
    }
  }

  Future<List<Company>> companiesByMemberId({required String memberId}) async {
    try {
      QuerySnapshot snapshot = await _ref.where('membersIds', arrayContains: memberId).get();

      return snapshot.docs.map((e) => Company.fromMap(e.data() as Map<String, dynamic>)).toList();
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        throw PermissionDenied(e.message!);
      } else {
        rethrow;
      }
    }
  }
}
