import 'package:duckyapp/domain/entities/user_entity.dart';
import 'package:duckyapp/domain/repository/auth_repository.dart';
import 'package:duckyapp/domain/use_cases/use_case.dart';

class SignUpUseCase implements UseCase<AuthUserEntity, SignUpParams> {
  AuthRepository authRepository;

  SignUpUseCase({required this.authRepository});

  @override
  Future<AuthUserEntity> call(SignUpParams params) {
    return authRepository.signUp(
      email: params.email,
      password: params.password,
      userName: params.userName,
      firstName: params.firstName,
      lastName: params.lastName,
      phoneNumber: params.phoneNumber,
    );
  }
}

class SignUpParams {
  final String email;
  final String password;
  final String userName;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final List<String> favourite;

  SignUpParams({
    required this.email,
    required this.password,
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    this.favourite = const [],
  });
}
