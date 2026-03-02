import 'dart:async';
import 'dart:developer';

import 'package:duckyapp/data/data_source/fire_base/auth_exceptions.dart';
import 'package:duckyapp/domain/use_cases/auth_use_cases/forgot_password_use_case.dart';
import 'package:duckyapp/domain/use_cases/auth_use_cases/get_current_user.dart';
import 'package:duckyapp/domain/use_cases/auth_use_cases/login_use_case.dart';
import 'package:duckyapp/domain/use_cases/auth_use_cases/sign_up_use_case.dart';
import 'package:duckyapp/domain/use_cases/auth_use_cases/user_reload_use_case.dart';
import 'package:duckyapp/presentation/bloc/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import '../../domain/use_cases/auth_use_cases/send_email_verification_use_case.dart';
import '../../domain/use_cases/auth_use_cases/sign_out_use_case.dart';
import '../../injections.dart';
import 'events.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  LoginUseCase _loginUseCase;
  SignUpUseCase _signUpUseCase;
  SignOutUseCase _signOutUseCase;
  SendEmailVerificationUseCase _sendEmailVerificationUseCase;
  SendResetPasswordUseCase _sendResetPasswordUseCase;
  GetCurrentUserUseCase _getCurrentUserUseCase;

  AuthBloc({
    required LoginUseCase loginUseCase,
    required SignUpUseCase signUpUseCase,
    required SignOutUseCase signOutUseCase,
    required SendEmailVerificationUseCase sendEmailVerificationUseCase,
    required SendResetPasswordUseCase sendResetPasswordUseCase,
    required GetCurrentUserUseCase getCurrentUserUseCase,
  }) : _loginUseCase = loginUseCase,
       _signUpUseCase = signUpUseCase,
       _signOutUseCase = signOutUseCase,
       _sendEmailVerificationUseCase = sendEmailVerificationUseCase,
       _sendResetPasswordUseCase = sendResetPasswordUseCase,
       _getCurrentUserUseCase = getCurrentUserUseCase,
       super(LoadingState()) {
    // Auth initial
    on<AuthInitialEvent>(authInitial);
    // Login
    on<LoginButtonClickedEvent>(loginButtonClicked);
    // Sign up
    on<SignUpButtonClickedEvent>(signUpButtonClicked);
    on<SignUpNavigationClickedEvent>(signUpNavigation);
    // Log out
    on<LogoutButtonClickedEvent>((event, emit) async {
      emit(LoadingState());
      await _signOutUseCase.call();
      emit(UserNotLogInState());
    });
    // Forgot password
    on<ForgotPasswordButtonClickedEvent>(forgotPasswordButtonClicked);
    // Email verification
    on<SendEmailVerifyEvent>(sendEmailVerification);
    // Check email verification
    on<EmailVerifyCheckReloadEvent>(emailVerifyCheck);
    // Note view navigation
    on<NoteViewNavigationClickedEvent>((event, emit) {
      emit(NoteViewNavigationClickedState());
    });
  }

  // Event handlers
  Future<void> loginButtonClicked(
    LoginButtonClickedEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(LoadingState());
      final currentUser = await _loginUseCase.call(
        LoginParams(email: event.email, password: event.password),
      );
      emit(LoginSuccessState(currentUser));
    } catch (e) {
      if (e.runtimeType == UserNotFound) {
        emit(UserNotFoundState());
      } else if (e.runtimeType == WrongPassword) {
        emit(WrongPasswordState());
      } else if (e.runtimeType == InvalidEmail) {
        emit(InvalidEmailState());
      } else if (e.runtimeType == UserDisabled) {
        emit(UserDisabledState());
      } else {
        print(e.runtimeType);
        emit(GenericExceptionState());
      }
    }
  }

  Future<void> authInitial(
    AuthInitialEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(LoadingState());
    try {
      final user = await _getCurrentUserUseCase.call();
      if (user.isEmailVerified == false) {
        log(name: "AuthBloc" ,"Error: User is not verified");
        emit(EmailVerifyingWaitingActionState());
        return;
      }
      log(name: "AuthBloc" , "Login success initial");
      emit(LoginSuccessState(user));
    } catch (e) {
      if (e.runtimeType == UserNotLogIn) {
        log(name: "AuthBloc", "Error: User not log in");
        emit(UserNotLogInState());
      } else {
        print(e.runtimeType);
        print(e.toString());
        emit(UserNotLogInState());
      }
    }
  }

  Future<void> signUpButtonClicked(
    SignUpButtonClickedEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(LoadingState());
      final currentUser = await _signUpUseCase.call(
        SignUpParams(
          email: event.email,
          password: event.password,
          userName: event.userName,
          firstName: event.firstName,
          lastName: event.lastName,
          phoneNumber: event.phoneNumber,
        ),
      );
      emit(SignUpSuccessActionState());
    } catch (e) {
      if (e is WeakPassword) {
        emit(WeakPasswordState());
      } else if (e is UserAlreadyExists) {
        emit(UserAlreadyExistsState());
      } else {
        print(e.runtimeType);
        if (e is FirebaseAuthException) {
          print(e.code);
        }
        emit(GenericExceptionState());
      }
    }
  }

  Future<void> forgotPasswordButtonClicked(
    ForgotPasswordButtonClickedEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(LoadingState());
    try {
      await _sendResetPasswordUseCase.call(
        SendResetPasswordParams(email: event.email),
      );
    } catch (e) {
      if (e.runtimeType == UserNotFound) {
        emit(UserNotFoundState());
      } else if (e.runtimeType == InvalidEmail) {
        emit(InvalidEmailState());
      } else if (e.runtimeType == MissingEmail) {
        emit(MissingEmailState());
      } else {
        emit(GenericExceptionState());
      }
    }
  }

  Future<void> sendEmailVerification(
    SendEmailVerifyEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(LoadingState());
      await _sendEmailVerificationUseCase();
      emit(EmailVerifyingWaitingActionState());
    } catch (e) {
      if (e.runtimeType == UserNotLogIn) {
        emit(UserNotLogInState());
      } else if (e.runtimeType == TooManyRequest) {
        emit(TooManyRequestState());
      } else if (e.runtimeType == InvalidRecipientEmail) {
        emit(InvalidRecipientEmailState());
      } else {
        emit(GenericExceptionState());
      }
    }
  }

  void signUpNavigation(
    SignUpNavigationClickedEvent event,
    Emitter<AuthState> emit,
  ) {
    emit(SignUpNavigationClickedActionState());
  }

  void emailVerifyCheck(
    EmailVerifyCheckReloadEvent event,
    Emitter<AuthState> emit,
  ) async {
    final currentUser = await locator<ReloadUserUseCase>().call();
    if (currentUser.isEmailVerified) {
      emit(EmailVerifySuccessActionState());
    } else {
      emit(EmailVerifyingWaitingActionState());
    }
  }
}
