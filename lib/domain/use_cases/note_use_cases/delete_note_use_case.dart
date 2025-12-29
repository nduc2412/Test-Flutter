import 'package:duckyapp/domain/repository/note_repository.dart';
import 'package:duckyapp/domain/use_cases/use_case.dart';

class DeleteNoteUseCase implements UseCase<void, DeleteNoteParams> {
  NoteRepository noteRepo;
  DeleteNoteUseCase({required this.noteRepo});
  @override
  Future<void> call(DeleteNoteParams params)  {
   return noteRepo.deleteNote(noteId: params.noteId, ownerId: params.userId);
  }
}

class DeleteNoteParams implements Parameters {
    final String noteId;
    final String userId;
    DeleteNoteParams({required this.noteId, required this.userId});
}
