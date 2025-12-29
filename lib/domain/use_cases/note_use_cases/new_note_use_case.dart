import 'package:duckyapp/domain/repository/note_repository.dart';
import 'package:duckyapp/domain/use_cases/use_case.dart';

import '../../entities/note_entity.dart';

class NewNoteUseCase implements UseCase<NoteEntity, NewNoteParams> {
  NoteRepository noteRepo;
  NewNoteUseCase ({required this.noteRepo});

  @override
  Future<NoteEntity> call(params) {
    return noteRepo.createNote(ownerId: params.userId);
  }
}

class NewNoteParams implements Parameters {
  final String userId;
  NewNoteParams({required this.userId});
}