import 'package:duckyapp/domain/repository/auth_repository.dart';
import 'package:duckyapp/domain/use_cases/use_case.dart';

class SignOutUseCase implements UseCaseNoParams<void> {
  AuthRepository authRepo;
  SignOutUseCase({required this.authRepo});
  @override
  Future<void> call() {
    return authRepo.signOut();
  }
}

