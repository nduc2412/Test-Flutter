import 'package:duckyapp/domain/repository/auth_repository.dart';
import 'package:duckyapp/domain/use_cases/use_case.dart';

class SendResetPasswordUseCase implements UseCase<void, SendResetPasswordParams> {
  AuthRepository authRepository;
  SendResetPasswordUseCase({required this.authRepository});
  @override
  Future<void> call(SendResetPasswordParams params) {
    return authRepository.sendPasswordChange(email: params.email);
  }
}

class SendResetPasswordParams implements Parameters {
  final String email;
  SendResetPasswordParams({required this.email});
}


