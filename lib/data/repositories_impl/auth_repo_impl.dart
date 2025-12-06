import 'package:duckyapp/data/models/auth_user_model.dart';
import 'package:duckyapp/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final DataSource =
  @override
  void addUser({required AuthUserModel user}) {
    // TODO: implement addUser
  }

  @override
  void deleteUser({required String id}) {
    // TODO: implement deleteUser
  }

  @override
  List<AuthUserModel> getAllUsers() {
    // TODO: implement getAllUsers
    throw UnimplementedError();
  }

  @override
  AuthUserModel getCurrentUser({required String id}) {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  void updateUser({required String id}) {
    // TODO: implement updateUser
  }

}