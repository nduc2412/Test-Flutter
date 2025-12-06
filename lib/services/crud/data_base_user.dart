import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
class DatabaseAlreadyOpenException implements Exception {}
class DocumentPathCannotFoundException implements Exception {}
class DatabaseIsNotOpenException implements Exception {}
class CannotDeleteUser implements Exception {}
class NoteView {
  Database?  _db;
  Future<void> deleteUser({required String email}) async {
    final db = _getDatabaseOrThrow();
    int deleteCount = await db.delete(userTable, where: '$emailColumn = ?', whereArgs: [email]);
    if (deleteCount == 0) {
      throw CannotDeleteUser();
    }
  }
  // write getUserorCreateUser(email), createUser(email) , updateUser, deleteUser(email), ensureDbIsOpen

  Database _getDatabaseOrThrow() {
    final db = _db;
    if (db == null) {
      throw DatabaseIsNotOpenException();
    } else {
      return db;
    }
  }
  Future<void> open() async{
    if (_db != null) {
      throw DatabaseAlreadyOpenException();
    }
    try {
      final docsPath = await getApplicationDocumentsDirectory();
      final dbPath = join(docsPath.path, dbName);
      Database db = await openDatabase(dbPath);
      _db = db;
      await db.execute(createTableUser);
      await db.execute(createTableNote);
    } on MissingPlatformDirectoryException {
      throw DocumentPathCannotFoundException();
    }
  }
  Future<void> close() async {
      final db = _getDatabaseOrThrow();
      await db.close();
      _db = null;
  }
}





class DataBaseUser {
  final int id;
  final String email;

  DataBaseUser({
    required this.id,
    required this.email,
  });

  DataBaseUser.fromDatabase(Map<String, Object?> map)
      : id = map[idColumn] as int,
        email = map[emailColumn] as String;
  @override
  String toString() {
    return "DataBaseUser{id: $id, email: $email}";
  }
  @override
  int get hashCode => id.hashCode;
  @override
  bool operator ==(covariant DataBaseUser other) {
    return this.id == other.id && this.email == other.email;
  }

}
class DataBaseNote {
  final int id;
  final int userId;
  final String text;
  DataBaseNote({
    required this.id,
    required this.userId,
    required this.text
  });

  DataBaseNote.fromDatabase(Map<String, Object?> map)
      : id = map[idColumn] as int,
        userId = map[userIdColumn] as int,
        text = map[textColumn] as String;

  @override
  String toString() {
    return "Note{ id: $id, userId: $userId, text: $text }";
  }
  @override
  int get hashCode => id.hashCode;
  @override
  bool operator ==(covariant DataBaseUser other) {
    return this.id == other.id;
  }
}
const String idColumn = "id";
const String emailColumn = "email";
// note column
const String userIdColumn = "user_id";
const String textColumn = "text";
// table name
const String userTable = "user";
const String noteTable = "user_note";
const dbName = 'notes.db';
const createTableUser = ''' CREATE TABLE IF NOT EXISTS "user" (
	"id"	INTEGER NOT NULL,
	"email"	TEXT NOT NULL,
	PRIMARY KEY("id")
); ''';
const createTableNote = ''' CREATE TABLE IF NOT EXISTS "user_note" (
	"id"	INTEGER NOT NULL,
	"user_id"	INTEGER NOT NULL,
	"text"	TEXT,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("id") REFERENCES ""
); ''';