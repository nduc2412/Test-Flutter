
import '../entities/user_entity.dart';

abstract class AuthRepository {
  AuthUserEntity getCurrentUser();
  Future<void> deleteCurrentUser();
  // Authentication
  Future<void> sendEmailVerification();
  Future<void> sendPasswordChange({required String email});
  Future<void> signOut();
  Future<AuthUserEntity> logIn({required String email, required String password});
  Future<AuthUserEntity> signUp({required String email, required String password});
  Future<AuthUserEntity> reloadUser();
}