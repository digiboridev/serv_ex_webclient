import 'dart:async';
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
        throw UnknownException(e.toString());
      }
    }
  }

  Future updateClientContacts({required String id, required List<ClientContact> contacts}) async {
    try {
      await _ref.doc(id).update({'contacts': contacts.map((e) => e.toMap()).toList()});
    } catch (e) {
      if (e is FirebaseException && e.code == 'permission-denied') {
        throw PermissionDenied(e.message!);
      } else {
        throw UnknownException(e.toString());
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

  Stream<Client> clientByIdStream({required String id}) {
    return _ref.doc(id).snapshots().transform(
          StreamTransformer<DocumentSnapshot<Map<String, dynamic>>, Client>.fromHandlers(
            handleData: (snapshot, sink) {
              if (snapshot.exists) {
                sink.add(Client.fromMap(snapshot.data() as Map<String, dynamic>));
              } else {
                sink.addError(UnexistedResource('Client with id $id does not exist'));
              }
            },
            handleError: (e, stackTrace, sink) {
              if (e is FirebaseException && e.code == 'permission-denied') {
                sink.addError(PermissionDenied(e.message!));
              } else {
                sink.addError(UnknownException(e.toString()));
              }
            },
            handleDone: (sink) => sink.close(),
          ),
        );
  }

  Future<Client> findClientByEmailOrPhone(String value) async {
    try {
      QuerySnapshot<Object?> emailSnapshot = await _ref.where('email', isEqualTo: value).get();
      QuerySnapshot<Object?> phoneSnapshot = await _ref.where('phone', isEqualTo: value).get();

      if (emailSnapshot.docs.isNotEmpty) {
        return Client.fromMap(emailSnapshot.docs.first.data() as Map<String, dynamic>);
      } else if (phoneSnapshot.docs.isNotEmpty) {
        return Client.fromMap(phoneSnapshot.docs.first.data() as Map<String, dynamic>);
      } else {
        throw UnexistedResource('Client with email or phone $value does not exist');
      }
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
