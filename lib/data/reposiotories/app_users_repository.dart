import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:serv_expert_webclient/data/exceptions.dart';
import 'package:serv_expert_webclient/data/models/user/app_user.dart';
import 'package:serv_expert_webclient/data/models/user/user_contact.dart';

abstract class AppUsersRepository {
  Future setAppUser(AppUser appUser);
  Future updateAppUserContacts({required String id, required List<AppUserContact> contacts});
  Future<AppUser> appUserById({required String id, bool forceNetwork = false});
  Stream<AppUser> appUserByIdStream({required String id});
  Future<AppUser> findAppUserByEmailOrPhone(String value);
}

class AppUsersRepositoryImpl implements AppUsersRepository {
  CollectionReference get _ref => FirebaseFirestore.instance.collection('app_users');

  @override
  Future setAppUser(AppUser appUser) async {
    try {
      await _ref.doc(appUser.id).set(appUser.toMap());
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        throw PermissionDenied(e.message!);
      } else {
        throw UnknownException(e.toString());
      }
    }
  }

  @override
  Future updateAppUserContacts({required String id, required List<AppUserContact> contacts}) async {
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

  @override
  Future<AppUser> appUserById({required String id, bool forceNetwork = false}) async {
    try {
      DocumentSnapshot snapshot = await _ref.doc(id).get(forceNetwork ? const GetOptions(source: Source.server) : null);

      if (snapshot.exists) {
        return AppUser.fromMap(snapshot.data() as Map<String, dynamic>);
      } else {
        throw UnexistedResource('AppUser $id does not exist');
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
  Stream<AppUser> appUserByIdStream({required String id}) {
    return _ref.doc(id).snapshots().transform(
          StreamTransformer<DocumentSnapshot<Map<String, dynamic>>, AppUser>.fromHandlers(
            handleData: (snapshot, sink) {
              if (snapshot.exists) {
                sink.add(AppUser.fromMap(snapshot.data() as Map<String, dynamic>));
              } else {
                sink.addError(UnexistedResource('AppUser $id does not exist'));
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
