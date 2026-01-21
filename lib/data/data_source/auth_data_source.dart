import 'package:duckyapp/domain/entities/user_entity.dart';

import '../models/auth_user_model.dart';

abstract class AuthDataSource {
  AuthUserModel getCurrentUser();
  Future<void> deleteCurrentUser();
  // Authentication
  Future<void> sendEmailVerification();
  Future<void> sendPasswordChange({required String email});
  Future<void> signOut();
  Future<AuthUserModel> logIn({required String email, required String password});
  Future<AuthUserModel> signUp({required String email, required String password});
  Future<AuthUserModel> reloadUser();
}