import 'package:duckyapp/domain/entities/user_entity.dart';
import 'package:duckyapp/domain/use_cases/use_case.dart';

import '../../repository/auth_repository.dart';

class ReloadUserUseCase implements UseCaseNoParams<void> {
  AuthRepository authRepository;
  ReloadUserUseCase({required this.authRepository});
  @override
  Future<AuthUserEntity> call() {
    return authRepository.reloadUser();
  }
}