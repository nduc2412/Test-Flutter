import 'package:duckyapp/data/models/auth_user_model.dart';

import '../../domain/entities/note_entity.dart';

abstract class UserDataSource {
  Future<AuthUserModel?> getUser(String id);

  Future<AuthUserModel> createUser({
    required String userId,
    required String email,
    required String firstName,
    required String lastName,
    required String userName,
    required String phoneNumber,
    required bool isVerified,
    List<String>? favourite,
  });

  Future<void> addFavourite({required String userId, required String noteId});

  Future<void> deleteFavourite({
    required String userId,
    required String noteId,
  });
  Future<List<NoteEntity>> getAllFavourite({required List<String> favouriteNotes});

}
