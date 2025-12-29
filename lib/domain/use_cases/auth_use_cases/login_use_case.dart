import 'package:duckyapp/domain/repository/auth_repository.dart';
import 'package:duckyapp/domain/use_cases/use_case.dart';
import 'package:duckyapp/services/auth_user.dart';

import '../../entities/user_entity.dart';

class LoginUseCase implements UseCase<AuthUserEntity, LoginParams> {
  AuthRepository authRepository;
  LoginUseCase({required this.authRepository});

  @override
  Future<AuthUserEntity> call(LoginParams params)  {
    return authRepository.logIn(email: params.email, password: params.password);
  }
}
class LoginParams implements Parameters {
  final String email;
  final String password;
  LoginParams({required this.email, required this.password});
}