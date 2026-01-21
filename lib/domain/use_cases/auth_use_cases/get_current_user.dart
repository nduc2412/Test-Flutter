import 'package:duckyapp/domain/repository/auth_repository.dart';

import '../../entities/user_entity.dart';

class GetCurrentUserUseCase {
  final AuthRepository authRepository;
  GetCurrentUserUseCase({required this.authRepository});

  AuthUserEntity call() {
    return authRepository.getCurrentUser();
  }
}