class NoteEntity {
  final String id;
  final String title;
  final String text;
  final String ownerId;
  NoteEntity({required this.id, required this.title, required this.ownerId, this.text = "", });
}