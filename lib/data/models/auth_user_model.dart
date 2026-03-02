import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/user_entity.dart';
import '../data_source/fire_store/fire_store_constant.dart';

class AuthUserModel {
  final String id;
  final String email;
  final bool isVerified;
  final String userName;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final List<String> favourite;

  AuthUserModel({
    required this.id,
    required this.email,
    required this.isVerified,
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.favourite,
  });

  factory AuthUserModel.fromFirebase(User firebaseUser) {
    return AuthUserModel(
      id: firebaseUser.uid,
      email: firebaseUser.email!,
      isVerified: firebaseUser.emailVerified,
      userName: '',
      firstName: '',
      lastName: '',
      phoneNumber: '',
      favourite: [],
    );
  }

  AuthUserEntity toEntity() {
    return AuthUserEntity(
      id: id,
      email: email,
      isEmailVerified: isVerified,
      userName: userName,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      favourite: favourite,
    );
  }
}