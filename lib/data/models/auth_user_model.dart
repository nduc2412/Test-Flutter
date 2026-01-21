import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/user_entity.dart';
import '../data_source/fire_store/fire_store_constant.dart';
class AuthUserModel {
  final String id;
  final String email;
  final bool isVerified;
  AuthUserModel({required this.id, required this.email, required this.isVerified});
  factory AuthUserModel.fromFirebase(User firebaseUser)
  {
      return AuthUserModel(id: firebaseUser.uid, email: firebaseUser.email!, isVerified: firebaseUser.emailVerified);
  }
  AuthUserEntity toEntity() {
    return AuthUserEntity(id: id, email: email, isEmailVerified: isVerified);
  }
}