
import 'package:duckyapp/data/data_source/fire_base/auth_exceptions.dart';
import 'package:duckyapp/services/auth_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'provider.dart';

class FirebaseProvider implements Provider {
  @override
  AuthUser? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return AuthUser.fromFirebase(user);
    }
    else {
      return null;
    }
  }

  @override
  Future<void> initProvider() async{
      await Firebase.initializeApp();
  }

  @override
  Future<AuthUser?> logIn ({required String password, required String email}) async {
    try {
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw UserNotFound();
      } else if (e.code == 'wrong-password') {
        throw WrongPassword();
      } else if (e.code == 'user-disabled') {
        throw UserDisabled();
      } else if (e.code == "invalid-email") {
        throw InvalidEmail();
      }
      else {
        throw GenericException();
      }
    }
    return AuthUser.fromFirebase(FirebaseAuth.instance.currentUser!);
  }

  @override
  Future<void> logOut() async{
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseAuth.instance.signOut();
    }
    else {
      throw UserNotLogIn();
    }
  }

  @override
  Future<void> sendPasswordChange() async{
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: user.email!);;
    }
    else {
      throw UserNotLogIn();
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    }
    else {
      throw UserNotLogIn();
    }
  }

  @override
  Future<AuthUser?> signUp({required String email, required String password}) async {
    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: email, password: password);
    } on FirebaseAuthException catch (e) {
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
    return AuthUser.fromFirebase(FirebaseAuth.instance.currentUser!);
  }
}

