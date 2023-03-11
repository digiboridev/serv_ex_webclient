import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:serv_expert_webclient/data/dto/repair_service/new_contact.dart';
import 'package:serv_expert_webclient/data/exceptions.dart';
import 'package:serv_expert_webclient/data/models/user/app_user.dart';
import 'package:serv_expert_webclient/data/models/user/user_contact.dart';

abstract class UserRepository {
  Future submitUserdetails({required String firstName, required String lastName, required String email, required String phone});
  Future submitUserContacts({required List<NewContactDTO> contacts});
  Future<AppUser> appUser({required String userId, bool forceNetwork = false});
  Stream<AppUser> appUserStream({required String userId});
  Future<List<AppUserContact>> userContacts({required String userId, bool forceNetwork = false});
  Stream<List<AppUserContact>> userContactsStream({required String userId});
  Future<AppUser> findAppUserByEmailOrPhone(String value);
}

class UserRepositoryImpl implements UserRepository {
  CollectionReference get _ref => FirebaseFirestore.instance.collection('app_users');

  @override
  Future submitUserdetails({required String firstName, required String lastName, required String email, required String phone}) async {
    try {
      HttpsCallable c = FirebaseFunctions.instance.httpsCallable('userDetailsSubmit');
      await c.call({'firstName': firstName, 'lastName': lastName, 'email': email, 'phone': phone});
    } catch (e) {
      if (e is FirebaseFunctionsException && e.code == 'unauthenticated') {
        throw Unauthorized(e.message ?? 'Unauthorized');
      }
      if (e is FirebaseFunctionsException && e.code == 'invalid-argument') {
        throw InvalidArgument(e.message ?? 'Invalid argument');
      }
      throw UnknownException(e.toString());
    }
  }

  @override
  Future submitUserContacts({required List<NewContactDTO> contacts}) async {
    try {
      HttpsCallable c = FirebaseFunctions.instance.httpsCallable('userContactsSubmit');
      await c.call({'contacts': contacts.map((e) => e.toMap()).toList()});
    } catch (e) {
      if (e is FirebaseFunctionsException && e.code == 'unauthenticated') {
        throw Unauthorized(e.message ?? 'Unauthorized');
      }
      if (e is FirebaseFunctionsException && e.code == 'invalid-argument') {
        throw InvalidArgument(e.message ?? 'Invalid argument');
      }
      throw UnknownException(e.toString());
    }
  }

  @override
  Future<AppUser> appUser({required String userId, bool forceNetwork = false}) async {
    try {
      DocumentSnapshot snapshot = await _ref.doc(userId).get(forceNetwork ? const GetOptions(source: Source.server) : null);

      if (snapshot.exists) {
        return AppUser.fromMap(snapshot.data() as Map<String, dynamic>);
      } else {
        throw UnexistedResource('AppUser $userId does not exist');
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

  @override
  Stream<AppUser> appUserStream({required String userId}) {
    return _ref.doc(userId).snapshots().transform(
          StreamTransformer<DocumentSnapshot<Map<String, dynamic>>, AppUser>.fromHandlers(
            handleData: (snapshot, sink) {
              if (snapshot.exists) {
                sink.add(AppUser.fromMap(snapshot.data() as Map<String, dynamic>));
              } else {
                sink.addError(UnexistedResource('AppUser $userId does not exist'));
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

  @override
  Future<List<AppUserContact>> userContacts({required String userId, bool forceNetwork = false}) async {
    try {
      QuerySnapshot snapshot = await _ref.doc(userId).collection('contacts').get(forceNetwork ? const GetOptions(source: Source.server) : null);
      return snapshot.docs.map((e) => AppUserContact.fromMap(e.data() as Map<String, dynamic>)).toList();
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

  @override
  Stream<List<AppUserContact>> userContactsStream({required String userId}) {
    return _ref.doc(userId).collection('contacts').snapshots().transform(
          StreamTransformer<QuerySnapshot<Map<String, dynamic>>, List<AppUserContact>>.fromHandlers(
            handleData: (snapshot, sink) {
              sink.add(snapshot.docs.map((e) => AppUserContact.fromMap(e.data())).toList());
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

  @override
  Future<AppUser> findAppUserByEmailOrPhone(String value) async {
    try {
      QuerySnapshot<Object?> emailSnapshot = await _ref.where('email', isEqualTo: value).get();
      QuerySnapshot<Object?> phoneSnapshot = await _ref.where('phone', isEqualTo: value).get();

      if (emailSnapshot.docs.isNotEmpty) {
        return AppUser.fromMap(emailSnapshot.docs.first.data() as Map<String, dynamic>);
      } else if (phoneSnapshot.docs.isNotEmpty) {
        return AppUser.fromMap(phoneSnapshot.docs.first.data() as Map<String, dynamic>);
      } else {
        throw UnexistedResource('AppUser with email or phone $value does not exist');
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
