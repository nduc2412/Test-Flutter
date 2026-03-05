
import '../entities/note_entity.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<AuthUserEntity> getCurrentUser();
  Future<void> deleteCurrentUser();
  // Authentication
  Future<void> sendEmailVerification();
  Future<void> sendPasswordChange({required String email});
  Future<void> signOut();
  Future<AuthUserEntity> logIn({required String email, required String password});
  Future<AuthUserEntity> signUp({    required String email,
    required String password,
    required String userName,
    required String firstName,
    required String lastName,
    required String phoneNumber,});
  Future<AuthUserEntity> reloadUser();
  Future<void> deleteFavouriteNote({required String noteId, required String ownerId});
  Future<void> addFavourite({required String userId, required String noteId});
  Future<List<NoteEntity>> getAllFavourite({required List<String> favouriteNotes});
  Future<void> updateUserVerifiedStatus(String userId);
}
