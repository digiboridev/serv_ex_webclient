import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/data/exceptions.dart';
import 'package:serv_expert_webclient/data/models/client/client.dart';

class ClientsRepository {
  CollectionReference get _ref => FirebaseFirestore.instance.collection('cells');

  Future setClient(Client client) async {
    await _ref.doc(client.id).set(client.toMap());
  }

  Future<Client> clientById({required String id, bool forceNetwork = false}) async {
    DocumentSnapshot snapshot = await _ref.doc(id).get(forceNetwork ? const GetOptions(source: Source.server) : null);

    if (snapshot.exists) {
      return Client.fromMap(snapshot.data() as Map<String, dynamic>);
    } else {
      throw UnexistedResource('Client with id $id does not exist');
    }
  }
}

final clientsRepositoryProvider = Provider<ClientsRepository>((ref) {
  return ClientsRepository();
});
