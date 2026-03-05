import '../../repository/auth_repository.dart';
import '../use_case.dart';

class UpdateUserVerifiedUseCase implements UseCase<void, UpdateUserVerifiedParams> {
  AuthRepository authRepository;
  UpdateUserVerifiedUseCase({required this.authRepository});
  @override
  Future<void> call(UpdateUserVerifiedParams params) {
    return authRepository.updateUserVerifiedStatus(params.userId);
  }
}

class UpdateUserVerifiedParams implements Parameters {
  final String userId;
  UpdateUserVerifiedParams({required this.userId});
}