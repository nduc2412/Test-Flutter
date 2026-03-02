import 'package:duckyapp/domain/repository/auth_repository.dart';

import '../../entities/user_entity.dart';

class GetCurrentUserUseCase {
  final AuthRepository authRepository;
  GetCurrentUserUseCase({required this.authRepository});

  Future<AuthUserEntity> call() {
    return authRepository.getCurrentUser();
  }
}