import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duckyapp/data/data_source/note_data_source.dart';
import 'package:duckyapp/data/models/note_model.dart';
import 'fire_store_constant.dart';
import '../data_source_exceptions.dart';
class FireStoreNoteDataSource implements NoteDataSource {
  static  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final notes = fireStore.collection(notesCollectionPath);
  @override
  Future<NoteModel> createNote({required String ownerId}) async {
    try {
      Map<String, dynamic> newNote = {
        fireStoreOwnerIdFieldName : ownerId,
        fireStoreTextFieldName : "",
        fireStoreTitleFieldName : "Title",
      };
      final fetchedNoteSnapshot = await notes.add(newNote).then((docRef) =>
          docRef.get()); // Add method receive Map<String, dynamic> and return Future<DocumentReference>, it will auto generate note id.
      final fetchedNote = fetchedNoteSnapshot.data()!;
      return NoteModel(id: fetchedNoteSnapshot.id,
          title: fetchedNote[fireStoreTitleFieldName],
          text: fetchedNote[fireStoreTextFieldName],
          ownerId: fetchedNote[fireStoreOwnerIdFieldName]);
    }
    catch (e) {
      throw CannotCreateNote();
    }
  }

  @override
  Future<void> deleteNote({required String noteId, required String ownerId}) async {
    try {
      await notes.doc(noteId).delete();
    }
    catch (e) {
      throw CannotDeleteNote();
    }
  }

  @override
  Stream<Iterable<NoteModel>> allNotes({required String ownerId} ) {
    final allNotes = notes
        .where(fireStoreOwnerIdFieldName, isEqualTo: ownerId)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => NoteModel.fromQueryDocSnap(doc))
    );
    return allNotes;
  }

  @override
  Future<void> updateNote({required String noteId, required String text, required String title}) async {
    try {
      final modifiedNote = {
        fireStoreTextFieldName : text,
        fireStoreTitleFieldName : title,
      };
      await notes.doc(noteId).update(modifiedNote);
    }
    catch (e) {
      throw CannotUpdateNote();
    }
  }

  @override
  Stream<NoteModel> getNote({required String noteId}) {
    final fetchedNote = notes.doc(noteId).snapshots().map((snapshot) =>
        NoteModel.fromDocSnap(snapshot));
    return fetchedNote;
  }
}