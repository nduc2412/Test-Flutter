import 'auth_user.dart';

abstract class Provider {
  Future<void>  initProvider();
  AuthUser? get currentUser;
  Future<AuthUser?> logIn({required String email, required String password});
  Future<void> logOut();
  Future<AuthUser?> signUp({required String email, required String password});
  Future<void> sendEmailVerification();
  Future<void> sendPasswordChange();
}