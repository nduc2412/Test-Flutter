import 'dart:developer';

import 'package:duckyapp/data/models/auth_user_model.dart';
import 'package:duckyapp/domain/entities/user_entity.dart';
import 'package:duckyapp/domain/repository/auth_repository.dart';
import 'package:flutter/animation.dart';

import '../../domain/entities/note_entity.dart';
import '../data_source/auth_data_source.dart';
import '../data_source/user_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;
  final UserDataSource userDataSource;

  AuthRepositoryImpl({
    required this.userDataSource,
    required this.authDataSource,
  });

  @override
  Future<void> deleteCurrentUser() {
    return authDataSource.deleteCurrentUser();
  }

  @override
  Future<AuthUserEntity> getCurrentUser() async {
    // 1. Lấy thông tin phiên đăng nhập hiện tại từ Auth (UID, Email, isVerified)
    final authModel = authDataSource.getCurrentUser();

    // 2. Lấy thông tin chi tiết từ Firestore
    final userModel = await userDataSource.getUser(authModel.id);

    // 3. Kết hợp thông tin
    final completeModel = AuthUserModel(
      id: authModel.id,
      email: authModel.email,
      isVerified: userModel?.isVerified ?? false,
      userName: userModel?.userName ?? '',
      firstName: userModel?.firstName ?? '',
      lastName: userModel?.lastName ?? '',
      phoneNumber: userModel?.phoneNumber ?? '',
      favourite: userModel?.favourite ?? [],
    );
    log(completeModel.isVerified.toString());
    return completeModel.toEntity();
  }

  @override
  Future<void> sendEmailVerification() {
    return authDataSource.sendEmailVerification();
  }

  @override
  Future<AuthUserEntity> logIn ({
    required String email,
    required String password,
  }) async {
    // Auth model
    final authModel = await authDataSource.logIn(
      email: email,
      password: password,
    );

    // Information model
    final userModel = await userDataSource.getUser(authModel.id);
    // Mix to complete model
    print(userModel!.userName);
    final completeModel = AuthUserModel(
      id: authModel.id,
      email: authModel.email,
      isVerified: authModel.isVerified,
      userName: userModel!.userName,
      firstName: userModel.firstName,
      lastName: userModel.lastName,
      phoneNumber: userModel.phoneNumber,
      favourite: userModel.favourite,
    );

    // 4. Trả về Entity cho tầng UI
    return completeModel.toEntity();
  }

  @override
  Future<void> sendPasswordChange({required String email}) {
    return authDataSource.sendPasswordChange(email: email);
  }

  @override
  Future<void> signOut() {
    return authDataSource.signOut();
  }

  @override
  Future<AuthUserEntity> signUp({
    required String email,
    required String password,
    required String userName,
    required String firstName,
    required String lastName,
    required String phoneNumber,
  }) async {
    try {
      final authModel = await authDataSource.signUp(
        email: email,
        password: password,
      );
      final completeModel = AuthUserModel(
        id: authModel.id,
        email: authModel.email,
        isVerified: false,
        userName: userName,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        favourite: [],
      );

      await userDataSource.createUser(
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        userName: userName,
        userId: authModel.id,
        email: email,
        isVerified: false,
      );

      return completeModel.toEntity();
    } catch (e) {
      print('Lỗi trong quá trình đăng ký: $e');
      rethrow;
    }
  }

  @override
  Future<AuthUserEntity> reloadUser() async {
      final authModel = await authDataSource.reloadUser();

      // 3. Kéo lại dữ liệu từ Firestore (để đảm bảo đồng bộ, ví dụ như list favourite)
      final userModel = await userDataSource.getUser(authModel.id);

      // 4. Kết hợp lại để trả về Entity hoàn chỉnh
      final completeModel = AuthUserModel(
        id: authModel.id,
        email: authModel.email,
        isVerified: authModel.isVerified,
        userName: userModel?.userName ?? '',
        firstName: userModel?.firstName ?? '',
        lastName: userModel?.lastName ?? '',
        phoneNumber: userModel?.phoneNumber ?? '',
        favourite: userModel?.favourite ?? [],
      );
      if (authModel.isVerified == false) {
        log(name: "auth repo at firebase user is not verified at verifying", completeModel.toString());
      }
      return completeModel.toEntity();
    }

  @override
  Future<void> deleteFavouriteNote({required String noteId, required String ownerId}) async {
      userDataSource.deleteFavourite(userId: ownerId, noteId: noteId);
  }

  @override
  Future<void> addFavourite({required String userId, required String noteId}) async {
    await userDataSource.addFavourite(userId: userId, noteId: noteId);
  }

  @override
  Future<List<NoteEntity>> getAllFavourite({required List<String> favouriteNotes}) async {
    return userDataSource.getAllFavourite(favouriteNotes: favouriteNotes);
  }

  @override
  Future<void> updateUserVerifiedStatus(String userId) async {
    await userDataSource.updateUserVerifiedStatus(userId);
  }
}
