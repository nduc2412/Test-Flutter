import '../models/note_model.dart';

abstract class NoteDataSource {
  Future<NoteModel> createNote({required String ownerId});
  Future<void> deleteNote({required String noteId, required String ownerId});
  Stream<Iterable<NoteModel>> allNotes({required String ownerId});
  Future<void> updateNote({required String noteId, required String text, required String title});
  Stream<NoteModel> getNote({required String noteId});
}