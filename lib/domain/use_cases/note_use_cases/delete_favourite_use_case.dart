import 'package:duckyapp/domain/repository/auth_repository.dart';

import '../use_case.dart';
import 'delete_note_use_case.dart';

class DeleteFavouriteNoteUseCase implements UseCase<void, DeleteFavouriteNoteParams> {
  AuthRepository repo;
  DeleteFavouriteNoteUseCase({required this.repo});
  @override
  Future<void> call(DeleteFavouriteNoteParams params)  {
    return repo.deleteFavouriteNote(noteId: params.noteId, ownerId: params.userId);
  }
}

class DeleteFavouriteNoteParams implements Parameters {
  final String noteId;
  final String userId;
  DeleteFavouriteNoteParams({required this.noteId, required this.userId});
}