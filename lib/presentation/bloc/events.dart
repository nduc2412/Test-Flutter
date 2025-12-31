abstract class AuthEvent {
  const AuthEvent();
}
class LoginEvent implements AuthEvent {}
class RegisterEvent implements AuthEvent {}
class LogoutEvent implements AuthEvent {}
class EmailVerifyEvent implements AuthEvent {}
class PasswordResetEvent implements AuthEvent {}