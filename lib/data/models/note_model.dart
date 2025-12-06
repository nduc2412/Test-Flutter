import 'package:cloud_firestore/cloud_firestore.dart';
import '../data_source/fire_store/fire_store_constant.dart';
import '../data_source/data_source_exceptions.dart';
import 'package:duckyapp/domain/entities/note_entity.dart';
class NoteModel {
  final String id;
  final String title;
  final String text;
  final String ownerId;
  NoteModel({required this.id, required this.title, required this.ownerId, this.text = ""});
  factory NoteModel.fromQueryDocSnap(QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return NoteModel(id: snapshot.id, title: data[fireStoreTitleFieldName], text: data[fireStoreTextFieldName], ownerId: data[fireStoreOwnerIdFieldName]);
  }
  factory NoteModel.fromDocSnap(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    if (data == null) {
      throw CannotCreateEntity();
    }
    return NoteModel(id: snapshot.id, title: data[fireStoreTitleFieldName], text: data[fireStoreTextFieldName], ownerId: data[fireStoreOwnerIdFieldName]);
  }
  NoteEntity toEntity() {
    return NoteEntity(id: id, title: title, text: text, ownerId: ownerId);
  }
}