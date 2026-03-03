import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duckyapp/data/data_source/fire_store/fire_store_constant.dart';

class NoteEntity {
  final String id;
  final String title;
  final String text;
  final String ownerId;
  NoteEntity({required this.id, required this.title, required this.ownerId, this.text = "", });
  factory NoteEntity.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return NoteEntity(
      id: doc.id,
      title: data[fireStoreTitleFieldName] ?? '',
      text: data[fireStoreTextFieldName] ?? '',
      ownerId: data[fireStoreOwnerIdFieldName] ?? '',
    );
  }
}