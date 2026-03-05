import 'dart:ffi';

import 'package:duckyapp/data/data_source/auth_data_source.dart';
import 'package:duckyapp/data/data_source/fire_base/auth_exceptions.dart';
import 'package:duckyapp/data/models/auth_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FireBaseAuthDataSource implements AuthDataSource {
  final FirebaseAuth firebase;

  FireBaseAuthDataSource(this.firebase);

  @override
  Future<void> deleteCurrentUser() {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  AuthUserModel getCurrentUser() {
    final currentUser = firebase.currentUser;
    if (currentUser == null) {
      throw UserNotLogIn();
    }
    return AuthUserModel.fromFirebase(currentUser);
  }

  @override
  Future<AuthUserModel> logIn({
    required String email,
    required String password,
  }) async {
    final UserCredential userCredential;
    try {
      userCredential = await firebase.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw UserNotFound();
      } else if (e.code == 'wrong-password') {
        throw WrongPassword();
      } else if (e.code == 'user-disabled') {
        throw UserDisabled();
      } else if (e.code == "invalid-email") {
        throw InvalidEmail();
      } else if (e.code == "invalid-credential") {
        throw UserNotFound();
      } else {
        print("email: " + email);
        print("pass: " + password);
        print(e.code);
        print(e.message);
        throw GenericException();
      }
    }
    // if the function reaches here, it means that user is created and not null;
    final user = userCredential.user;
    if (user == null) {
      throw UserNotLogIn();
    }
    return AuthUserModel.fromFirebase(user);
  }

  @override
  Future<AuthUserModel> signUp({
    required String email,
    required String password,
  }) async {
    final newUserModel;
    try {
      newUserModel = await firebase
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((userCre) => userCre.user)
          .then((user) => AuthUserModel.fromFirebase(user!));
      return newUserModel;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPassword();
      } else if (e.code == 'email-already-in-use') {
        throw UserAlreadyExists();
      } else if (e.code == 'invalid-email') {
        throw InvalidEmail();
      } else {
        print(e.code);
        print(e.message);
        throw GenericException();
      }
    }
    // if the function reaches here, it means that user is created and not null;
  }

  @override
  Future<void> sendEmailVerification() async {
    final currentUser = firebase.currentUser;
    print(currentUser?.email);
    if (currentUser == null) {
      throw UserNotLogIn();
    } else {
      try {
        await currentUser.sendEmailVerification();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'too-many-requests') {
          throw TooManyRequest();
        } else if (e.code == 'invalid-recipient-email') {
          throw InvalidRecipientEmail();
        } else {
          throw GenericException();
        }
      }
    }
  }

  @override
  Future<void> sendPasswordChange({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw UserNotFound();
      } else if (e.code == 'invalid-email') {
        throw InvalidEmail();
      } else if (e.code == 'missing-email') {
        throw MissingEmail();
      } else {
        print(e.code);
        throw GenericException();
      }
    }
  }

  @override
  Future<void> signOut() async {
    final user = firebase.currentUser;
    if (user == null) {
      throw UserNotLogIn();
    } else {
      await firebase.signOut();
    }
  }

  @override
  Future<AuthUserModel> reloadUser() async {
    final user = firebase.currentUser;
    if (user == null) {
      throw UserNotLogIn();
    } else {
      await user.reload();
      return Future.value(AuthUserModel.fromFirebase(firebase.currentUser!));
    }
  }
}
