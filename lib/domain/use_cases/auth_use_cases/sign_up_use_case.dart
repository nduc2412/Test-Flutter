import 'package:duckyapp/domain/entities/user_entity.dart';
import 'package:duckyapp/domain/repository/auth_repository.dart';
import 'package:duckyapp/domain/use_cases/use_case.dart';

class SignUpUseCase implements UseCase<AuthUserEntity, SignUpParams> {
  AuthRepository authRepository;
  SignUpUseCase({required this.authRepository});

  @override
  Future<AuthUserEntity> call(SignUpParams params) {
    return authRepository.signUp(email: params.email, password: params.password);
  }

}
class SignUpParams implements Parameters {
  final String email;
  final String password;
  SignUpParams({required this.email, required this.password});

}