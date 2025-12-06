import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'auth_exceptions.dart';
@immutable
class AuthUser {
    final String id;
    final bool isVerified;
    final String email;
    const AuthUser({required this.id, required  this.isVerified, required this.email});
    factory AuthUser.fromFirebase(User user) {
        return AuthUser(id: user.uid, isVerified: false, email: user.email!);
    }
}
