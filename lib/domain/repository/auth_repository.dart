
import '../entities/user_entity.dart';

abstract class AuthRepository {
  AuthUserEntity getCurrentUser({required String id});
  List<AuthUserEntity> getAllUsers();
  void addUser({required AuthUserEntity user});
  void updateUser({ required String id});
  void deleteUser({required String id});
}