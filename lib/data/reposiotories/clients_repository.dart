import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:serv_expert_webclient/data/exceptions.dart';
import 'package:serv_expert_webclient/data/models/client/client.dart';
import 'package:serv_expert_webclient/data/models/client/client_contact.dart';

class ClientsRepository {
  CollectionReference get _ref => FirebaseFirestore.instance.collection('clients');

  Future setClient(Client client) async {
    try {
      await _ref.doc(client.id).set(client.toMap());
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        throw PermissionDenied(e.message!);
      } else {
        rethrow;
      }
    }
  }

  Future updateClientContacts({required String id, required List<ClientContact> contacts}) async {
    try {
      await _ref.doc(id).update({'contacts': contacts.map((e) => e.toMap()).toList()});
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        throw PermissionDenied(e.message!);
      } else {
        rethrow;
      }
    }
  }

  Future<Client> clientById({required String id, bool forceNetwork = false}) async {
    try {
      DocumentSnapshot snapshot = await _ref.doc(id).get(forceNetwork ? const GetOptions(source: Source.server) : null);

      if (snapshot.exists) {
        return Client.fromMap(snapshot.data() as Map<String, dynamic>);
      } else {
        throw UnexistedResource('Client with id $id does not exist');
      }
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        throw PermissionDenied(e.message!);
      } else {
        rethrow;
      }
    }
  }
}
