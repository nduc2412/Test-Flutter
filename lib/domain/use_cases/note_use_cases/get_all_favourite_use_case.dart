
import 'package:duckyapp/domain/repository/auth_repository.dart';

import '../../../data/data_source/user_data_source.dart';
import '../../entities/note_entity.dart';
import '../use_case.dart';

class GetAllFavouriteUseCase implements UseCase<List<NoteEntity>, GetAllNotesParams> {
  final AuthRepository repo;

  const GetAllFavouriteUseCase({required this.repo});

  @override
  Future<List<NoteEntity>> call(GetAllNotesParams params) async {
    final notes = await repo.getAllFavourite(favouriteNotes: params.favouriteIds);
    return notes;
  }
}

class GetAllNotesParams implements Parameters {
  final List<String> favouriteIds;

  const GetAllNotesParams({required this.favouriteIds});
}
