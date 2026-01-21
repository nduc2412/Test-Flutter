import 'package:duckyapp/domain/entities/note_entity.dart';
import 'package:duckyapp/domain/repository/note_repository.dart';
import 'package:duckyapp/domain/use_cases/use_case.dart';

import '../../repository/auth_repository.dart';

class GetAllNotesUseCase
    implements UseCase<List<NoteEntity>, GetAllNotesParams> {
  final NoteRepository repo;

  const GetAllNotesUseCase({required this.repo});

  @override
  Future<List<NoteEntity>> call(GetAllNotesParams params) async {
    final notes = await repo
        .allNotes(ownerId: params.userId)
        .first;
    return notes.toList();
  }
}

class GetAllNotesParams implements Parameters {
  final String userId;

  const GetAllNotesParams({required this.userId});
}
