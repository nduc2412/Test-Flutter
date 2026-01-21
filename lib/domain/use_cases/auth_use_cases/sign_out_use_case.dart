import 'package:duckyapp/domain/repository/auth_repository.dart';
import 'package:duckyapp/domain/use_cases/use_case.dart';

class SignOutUseCase implements UseCaseNoParams<void> {
  AuthRepository authRepository;
  SignOutUseCase({required this.authRepository});
  @override
  Future<void> call() {
    return authRepository.signOut();
  }
}

