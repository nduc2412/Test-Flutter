import 'package:duckyapp/data/models/auth_user_model.dart';

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

}
