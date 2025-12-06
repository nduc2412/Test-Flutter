import 'package:duckyapp/domain/entities/user_entity.dart';

import '../models/auth_user_model.dart';

abstract class AuthDataSource {
  Future<AuthUserModel> getCurrentUser({required String userId});
  Future<List<AuthUserModel>> getAllUsers();
  Future<AuthUserModel> addUser({required AuthUserModel user});
  Future<void> updateUser({ required String userId});
  Future<void> deleteUser({required String userId});
}