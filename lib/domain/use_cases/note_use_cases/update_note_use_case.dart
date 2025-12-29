import 'package:duckyapp/domain/use_cases/use_case.dart';

import '../../repository/note_repository.dart';

class UpdateNoteUseCase implements UseCase<void, UpdateNoteParams> {
  NoteRepository noteRepo;
  UpdateNoteUseCase({required this.noteRepo});
  @override
  Future<void> call(UpdateNoteParams params) {
    return noteRepo.updateNote(noteId: params.noteId, text: params.text, title: params.title);
  }
}

class UpdateNoteParams implements Parameters {
  final String noteId;
  final String text;
  final String title;
  UpdateNoteParams({required this.noteId, required this.text, required this.title});
}