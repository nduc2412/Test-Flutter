import '../../repository/auth_repository.dart';
import '../use_case.dart';

class AddFavouriteNoteUseCase implements UseCase<void, AddFavouriteNoteParams> {
  AuthRepository repo;
  AddFavouriteNoteUseCase({required this.repo});
  @override
  Future<void> call(AddFavouriteNoteParams params)  {
    return repo.addFavourite(noteId: params.noteId, userId: params.userId);
  }
}

class AddFavouriteNoteParams implements Parameters {
  final String noteId;
  final String userId;
  AddFavouriteNoteParams({required this.noteId, required this.userId});
}