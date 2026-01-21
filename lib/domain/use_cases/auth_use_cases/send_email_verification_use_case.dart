import 'package:duckyapp/domain/repository/auth_repository.dart';
import 'package:duckyapp/domain/use_cases/use_case.dart';

class SendEmailVerificationUseCase implements UseCaseNoParams<void> {
  AuthRepository authRepository;
  SendEmailVerificationUseCase({required this.authRepository});
  @override
  Future<void> call()  {
      return authRepository.sendEmailVerification();
  }
}
