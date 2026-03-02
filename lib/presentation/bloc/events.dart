abstract class AuthEvent {
  const AuthEvent();
}

// Initial event
class AuthInitialEvent implements AuthEvent {}

// Login event
class LoginButtonClickedEvent implements AuthEvent {
  final String email;
  final String password;
  final bool rememberMe;

  LoginButtonClickedEvent({
    required this.email,
    required this.password,
    this.rememberMe = false,
  });
}

// Sign up event
class SignUpButtonClickedEvent implements AuthEvent {
  final String email;
  final String password;
  final String userName;
  final String firstName;
  final String lastName;
  final String phoneNumber;

  SignUpButtonClickedEvent({
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.password,
  });
}

class SignUpNavigationClickedEvent implements AuthEvent {}

// Log out event
class LogoutButtonClickedEvent implements AuthEvent {}

// Email Verify event
class SendEmailVerifyEvent implements AuthEvent {}

class EmailVerifyCheckReloadEvent implements AuthEvent {}

// Forgot password event
class ForgotPasswordButtonClickedEvent implements AuthEvent {
  final String email;

  ForgotPasswordButtonClickedEvent({required this.email});
}

// Note view navigation event
class NoteViewNavigationClickedEvent implements AuthEvent {}
