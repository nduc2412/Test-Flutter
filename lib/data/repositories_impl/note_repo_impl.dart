import 'package:duckyapp/data/data_source/note_data_source.dart';
import 'package:duckyapp/data/models/note_model.dart';
import 'package:duckyapp/domain/entities/note_entity.dart';
import 'package:duckyapp/domain/repository/note_repository.dart';

import '../data_source/fire_store/fire_store.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteDataSource noteDataSource = FireStoreNoteDataSource();
  @override
  Future<NoteEntity> createNote({required String ownerId}) async {
    final fetchedNote = await noteDataSource.createNote(ownerId: ownerId).then((model) => model.toEntity());
    return fetchedNote;
  }

  @override
  Future<void> deleteNote({required String noteId, required String ownerId}) async {
    await noteDataSource.deleteNote(noteId: noteId, ownerId: ownerId);
  }

  @override
  Stream<Iterable<NoteEntity>> allNotes({required String ownerId})  {
    final allNotes = noteDataSource.allNotes(ownerId: ownerId).map((model) => model.map((model) => model.toEntity()));
    return allNotes;
  }

  @override
  Stream<NoteEntity> getNote({required String noteId}) {
    final fetchedNote = noteDataSource.getNote(noteId: noteId).map((model) => model.toEntity());
    return fetchedNote;
  }

  @override
  Future<void> updateNote({required String noteId, required String text, required String title}) async {
    await noteDataSource.updateNote(noteId: noteId, text: text, title: title);
  }
}