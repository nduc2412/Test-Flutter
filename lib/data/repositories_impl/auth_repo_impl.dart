
import 'package:duckyapp/data/models/auth_user_model.dart';
import 'package:duckyapp/domain/entities/user_entity.dart';
import 'package:duckyapp/domain/repository/auth_repository.dart';

import '../data_source/auth_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource dataSource;
  AuthRepositoryImpl({required this.dataSource});

  @override
  Future<void> deleteCurrentUser() {
    return dataSource.deleteCurrentUser();
  }

  @override
  AuthUserEntity getCurrentUser() {
    final userModel = dataSource.getCurrentUser();
    final userEntity = userModel.toEntity();
    return userEntity;
  }

  @override
  Future<void> sendEmailVerification()  {
    return dataSource.sendEmailVerification();
  }

  @override
  Future<AuthUserEntity> logIn({required String email, required String password}) {
    final userEntity = dataSource.logIn(email: email, password: password).then((model) => model.toEntity());
    return userEntity;
  }


  @override
  Future<void> sendPasswordChange({required String email}) {
    return dataSource.sendPasswordChange(email: email);
  }

  @override
  Future<void> signOut() {
    return dataSource.signOut();
  }

  @override
  Future<AuthUserEntity> signUp({required String email, required String password}) {
    final userEntity = dataSource.signUp(email: email, password: password).then((model) => model.toEntity());
    return userEntity;
  }

  @override
  Future<AuthUserEntity> reloadUser() async {
      return dataSource.reloadUser().then((model) => model.toEntity());
  }
}
