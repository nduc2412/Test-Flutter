import 'package:duckyapp/domain/entities/user_entity.dart';

import '../../domain/entities/note_entity.dart';

abstract class AuthState {
  const AuthState();
}

abstract class AuthActionState extends AuthState {}

abstract class AuthErrorState extends AuthState {}

// Auth Error States

// Login error states
class UserNotFoundState extends AuthErrorState {}

class WrongPasswordState extends AuthErrorState {}

class InvalidEmailState extends AuthErrorState {}

class UserDisabledState extends AuthErrorState {}

class MissingEmailState extends AuthErrorState {}

// Sign up error states
class WeakPasswordState extends AuthErrorState {}

class UserAlreadyExistsState extends AuthErrorState {}

class UserNotLogInState extends AuthErrorState {}

// Email verification error states
class TooManyRequestState extends AuthErrorState {}

class InvalidRecipientEmailState extends AuthErrorState {}

// Generic error states
class GenericExceptionState extends AuthErrorState {}




class AuthInitialState extends AuthActionState {}

class LoadingState extends AuthState {}

class AuthLoadedState extends AuthState {}
// Login state
class LoginSuccessState extends AuthActionState {
  AuthUserEntity currentUser;
  LoginSuccessState(this.currentUser);
}
class GetCurrentUserSuccessState extends AuthActionState {
  AuthUserEntity currentUser;
  GetCurrentUserSuccessState(this.currentUser);
}
// Sign up state
class SignUpSuccessActionState extends AuthActionState {
  final AuthUserEntity user;
  SignUpSuccessActionState(this.user);
}
class SignUpNavigationClickedActionState extends AuthActionState {}
// Log out state
class LogoutButtonClickedActionState extends AuthActionState {}
// Email verify state
class EmailVerifyingWaitingActionState extends AuthActionState {
}
class EmailVerifySuccessActionState extends AuthActionState {}
class UserNotVerifiedActionState extends AuthActionState {}
// Forgot password state
class PasswordResetButtonClickedActionState extends AuthActionState {}

class NoteLoadedSuccessState extends AuthState {
  List<NoteEntity> notes;

  NoteLoadedSuccessState(this.notes);
}
class NoteViewNavigationClickedState extends AuthActionState {}
