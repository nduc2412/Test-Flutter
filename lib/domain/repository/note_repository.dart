import 'package:duckyapp/domain/entities/note_entity.dart';

import '../../data/models/note_model.dart';

abstract class NoteRepository {

  Stream<NoteEntity> getNote({required String noteId});
  Stream<Iterable<NoteEntity>> allNotes({required String ownerId});
  Future<NoteEntity> createNote({required String ownerId});
  Future<void> updateNote({required String noteId, required String text, required String title});
  Future<void> deleteNote({required String noteId, required String ownerId});

}