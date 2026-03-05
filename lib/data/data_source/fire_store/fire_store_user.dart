import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duckyapp/data/models/auth_user_model.dart';
import 'package:duckyapp/domain/entities/note_entity.dart';
import 'package:flutter/foundation.dart';
import '../auth_data_source.dart';
import '../fire_base/auth_exceptions.dart';
import '../user_data_source.dart';
import 'fire_store_constant.dart';
import '../data_source_exceptions.dart';

class FireStoreUserDataSource implements UserDataSource {
  final FirebaseFirestore fireStore;

  late final users = fireStore.collection(usersCollectionPath);

  FireStoreUserDataSource(this.fireStore);

  @override
  Future<AuthUserModel> createUser({
    required String userId,
    required String firstName,
    required String lastName,
    required String userName,
    required String phoneNumber,
    required String email,
    required bool isVerified,
    List<String>? favourite,
  }) async {
    try {
      final Map<String, dynamic> userData = {
        userIdFieldName: userId,
        emailFieldName: email,
        isVerifiedFieldName: isVerified,
        firstNameFieldName: firstName,
        lastNameFieldName: lastName,
        userNameFieldName: userName,
        phoneNumberFieldName: phoneNumber,
        favouriteFieldName: favourite ?? [],
      };

      await users.doc(userId).set(userData);

      return AuthUserModel(
        id: userId,
        email: email,
        isVerified: isVerified,
        userName: userName,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        favourite: List<String>.from(favourite ?? []),
      );
    } catch (e) {
      throw CannotSyncData();
    }
  }

  @override
  Future<AuthUserModel?> getUser(String id) async {
    try {
      final snapshot = await users.doc(id).get();
      if (snapshot.exists) {
        log(name: "Firestore_user", "${snapshot.data().toString()}database");
        final data = snapshot.data()!;
        return AuthUserModel(
          id: data[userIdFieldName] ?? id,
          email: data[emailFieldName] ?? '',
          isVerified: data[isVerifiedFieldName] ?? false,
          userName: data[userNameFieldName] ?? '',
          firstName: data[firstNameFieldName] ?? '',
          lastName: data[lastNameFieldName] ?? '',
          phoneNumber: data[phoneNumberFieldName] ?? '',
          favourite: List<String>.from(data[favouriteFieldName] ?? []),
        );
      }
      return null;
    } catch (e) {
      print(e.runtimeType);
      print(e.toString());
      throw UserNotFound();
    }
  }

  @override
  Future<void> addFavourite({
    required String userId,
    required String noteId,
  }) async {
    try {
      final userDocRef = users.doc(userId);

      await userDocRef.update({
        favouriteFieldName: FieldValue.arrayUnion([noteId]),
      });
    } catch (e) {
      throw CannotSyncData();
    }
  }

  @override
  Future<void> deleteFavourite({
    required String userId,
    required String noteId,
  }) async {
    try {
      final userDocRef = users.doc(userId);

      await userDocRef.update({
        favouriteFieldName: FieldValue.arrayRemove([noteId]),
      });
    } catch (e) {
      throw CannotSyncData();
    }
  }

  @override
  Future<List<NoteEntity>> getAllFavourite({required List<String> favouriteNotes}) async {
    List<NoteEntity> notes = [];
    if (favouriteNotes.isEmpty) {
      return notes;
    }
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(notesCollectionPath)
          .where(FieldPath.documentId, whereIn: favouriteNotes)
          .get();
      return querySnapshot.docs
          .map((doc) => NoteEntity.fromFirestore(doc))
          .toList();

    } catch (e) {
      log(name: "Fire store user", e.toString());
      return [];
    }
  }

  @override
  Future<void> updateUserVerifiedStatus(String userId) async {
    try {
      await FirebaseFirestore.instance
          .collection(usersCollectionPath)
          .doc(userId)
          .set({
        isVerifiedFieldName: true,
      }, SetOptions(merge: true));

      log(name: "Fire store user update user status", "Update user verified status success");
    } catch (e) {
      log(name: "Fire store user update user status", "Update user verified status fail");
    }
  }


}
