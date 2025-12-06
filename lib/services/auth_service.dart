import 'package:duckyapp/services/auth_user.dart';
import 'package:duckyapp/services/provider.dart';

class AuthService implements Provider {
  Provider provider;
  AuthService({required this.provider});

  @override
  AuthUser? get currentUser {
    return provider.currentUser;
  }

  @override
  Future<void> initProvider() async {
    await provider.initProvider();
  }

  @override
  Future<AuthUser?> logIn({required String email, required String password}) async{
    return await provider.logIn(email: email, password: password);
  }

  @override
  Future<void> logOut() async{
    await provider.logOut() ;
  }

  @override
  Future<void> sendEmailVerification() async{
    await provider.sendEmailVerification();
  }

  @override
  Future<void> sendPasswordChange() async{
    await provider.sendPasswordChange();
  }

  @override
  Future<AuthUser?> signUp({required String email, required String password}) async{
    return await provider.signUp(email: email, password: password);
  }
}