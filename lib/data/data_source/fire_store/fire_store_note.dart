import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duckyapp/data/data_source/note_data_source.dart';
import 'package:duckyapp/data/models/note_model.dart';
import 'fire_store_constant.dart';
import '../data_source_exceptions.dart';

class FireStoreNoteDataSource implements NoteDataSource {
  final FirebaseFirestore fireStore;

  FireStoreNoteDataSource(this.fireStore);

  late final notes = fireStore.collection(notesCollectionPath);

  @override
  Future<NoteModel> createNote({required String ownerId}) async {
    try {
      final now = DateTime.now();
      Map<String, dynamic> newNote = {
        fireStoreOwnerIdFieldName: ownerId,
        fireStoreTextFieldName: "",
        fireStoreTitleFieldName: "Title",
        fireStoreDayFieldName: now.day,
        fireStoreMonthFieldName: now.month,
        fireStoreYearFieldName: now.year,
      };
      final fetchedNoteSnapshot = await notes
          .add(newNote)
          .then(
            (docRef) => docRef.get(),
          ); // Add method receive Map<String, dynamic> and return Future<DocumentReference>, it will auto generate note id.
      final fetchedNote = fetchedNoteSnapshot.data()!;
      return NoteModel(
        id: fetchedNoteSnapshot.id,
        title: fetchedNote[fireStoreTitleFieldName],
        text: fetchedNote[fireStoreTextFieldName],
        ownerId: fetchedNote[fireStoreOwnerIdFieldName],
        day:  now.day,
        month: now.month,
        year: now.year,
      );
    } catch (e) {
      throw CannotCreateNote();
    }
  }

  @override
  Future<void> deleteNote({
    required String noteId,
    required String ownerId,
  }) async {
    try {
      await notes.doc(noteId).delete();
    } catch (e) {
      throw CannotDeleteNote();
    }
  }

  @override
  Stream<Iterable<NoteModel>> allNotes({required String ownerId}) {
    try {
      final allNotes = notes
          .where(fireStoreOwnerIdFieldName, isEqualTo: ownerId)
          .snapshots()
          .map(
            (snapshot) =>
                snapshot.docs.map((doc) => NoteModel.fromQueryDocSnap(doc)),
          );
      return allNotes;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> updateNote({
    required String noteId,
    required String text,
    required String title,
  }) async {
    try {
      final now = DateTime.now();
      final modifiedNote = {
        fireStoreTextFieldName: text,
        fireStoreTitleFieldName: title,
        fireStoreDayFieldName: now.day,
        fireStoreMonthFieldName: now.month,
        fireStoreYearFieldName: now.year,
      };
      await notes.doc(noteId).update(modifiedNote);
    } catch (e) {
      throw CannotUpdateNote();
    }
  }

  @override
  Stream<NoteModel> getNote({required String noteId}) {
    final fetchedNote = notes
        .doc(noteId)
        .snapshots()
        .map((snapshot) => NoteModel.fromDocSnap(snapshot));
    return fetchedNote;
  }
}
