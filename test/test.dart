import 'package:duckyapp/data/data_source/fire_base/auth_exceptions.dart';
import 'package:duckyapp/services/auth_user.dart';
import 'package:duckyapp/services/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:test/test.dart';
// email = "tductri123@gmail.com"
// password = ductri;
void main() {
  group("Auth provider test", () {
    Provider provider = MockProvider();
    
  }
  );
}

class NotInitializedException implements Exception {}
class MockProvider implements Provider {
  AuthUser? _user;
  bool _isInitialized = false;
  @override
  AuthUser? get currentUser {
    if (!_isInitialized) {
      throw NotInitializedException();
    }
    if (_user != null) {
      return _user;
    }
    else {
      return null;
    }
  }

  @override
  Future<void> initProvider() {
    Future.delayed(const Duration(seconds : 1));
    _isInitialized = true;
    return Future.value();
  }

  @override
  Future<AuthUser?> logIn({required String email, required String password}) async {
    Future.delayed(const Duration(seconds: 1));
    if (_isInitialized == false) throw NotInitializedException();
    if (email != "tductri123@gmail.com") throw UserNotFound();
    if (password != "ductri") throw WrongPassword();
    const AuthUser user = AuthUser(id: "my_id", email: "tductri123@gmail.com" , isVerified: false);
    return Future.value(user);
  }

  @override
  Future<void> logOut() {
    if (_isInitialized == false) throw NotInitializedException();
    if (_user == null) throw UserNotFound();
    _user = null;
    return Future.value();
  }

  @override
  Future<void> sendEmailVerification() {
    if (_isInitialized == false) throw NotInitializedException();
    if (_user == null) throw UserNotFound();
    const user = AuthUser(id: "my_id", email: "tductri123@gmail.com" , isVerified: true);
    _user = user;
    return Future.value();


  }

  @override
  Future<void> sendPasswordChange() {
    // TODO: implement sendPasswordChange
    throw UnimplementedError();
  }

  @override
  Future<AuthUser?> signUp({required String email, required String password}) async {
    if (_isInitialized == false) throw NotInitializedException();
    await (Future.delayed(const Duration(seconds: 1)));
    logIn(email: email, password: password);
    return Future.value(_user);
  }

}