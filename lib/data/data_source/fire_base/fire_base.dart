import 'dart:ffi';

import 'package:duckyapp/data/data_source/auth_data_source.dart';
import 'package:duckyapp/data/data_source/fire_base/auth_exceptions.dart';
import 'package:duckyapp/data/models/auth_user_model.dart';
import 'package:duckyapp/services/auth_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireBaseAuthDataSource implements AuthDataSource {
  final firebase = FirebaseAuth.instance;

  @override
  Future<void> deleteUser({required String userId}) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  AuthUserModel getCurrentUser({required String userId}) {
    final currentUser = firebase.currentUser;
    if (currentUser == null) {
      throw UserNotLogIn();
    }
    return AuthUserModel.fromFirebase(currentUser);
  }

  @override
  Future<AuthUserModel> logIn(
      {required String email, required String password}) {
    final Future<User?> userCredential;
    try {
      userCredential =
          firebase
              .signInWithEmailAndPassword(email: email, password: password)
              .then((userCre) => userCre.user);
    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw UserNotFound();
      } else if (e.code == 'wrong-password') {
        throw WrongPassword();
      } else if (e.code == 'user-disabled') {
        throw UserDisabled();
      }
      else if (e.code == "invalid-email") {
        throw InvalidEmail();
      }
      else {
        throw GenericException();
      }
    }
    // if the function reaches here, it means that user is created and not null;
    final user = userCredential.then((userCredential) =>
        AuthUserModel.fromFirebase(userCredential!));
    return user;
  }


  @override
  Future<AuthUserModel> signUp(
      {required String email, required String password}) async {
    final Future<AuthUserModel> newUserModel;
    try {
      newUserModel = firebase
          .createUserWithEmailAndPassword(
          email: email, password: password)
          .then((userCre) => userCre.user)
          .then((user) =>
          AuthUserModel.fromFirebase(user!));
      return newUserModel;
    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPassword();
      } else if (e.code == 'email-already-in-use') {
        throw UserAlreadyExists();
      } else if (e.code == 'invalid-email') {
        throw InvalidEmail();
      }
      else {
        throw GenericException();
      }
    }
    // if the function reaches here, it means that user is created and not null;
  }


  @override
  Future<void> sendEmailVerification() async {
    final currentUser = firebase.currentUser;
    if (currentUser == null) {
      throw UserNotLogIn();
    }
    else {
      await currentUser.sendEmailVerification();
    }
  }

  @override
  Future<void> sendPasswordChange() async {
    final currentUser = firebase.currentUser;
    if (currentUser == null) {
      throw UserNotLogIn();
    }
    else {
      await currentUser.sendEmailVerification();
    }
  }

  @override
  Future<void> signOut() async {
    final user = firebase.currentUser;
    if (user == null) {
      throw UserNotLogIn();
    }
    else {
      await firebase.signOut();
    }
  }
}
