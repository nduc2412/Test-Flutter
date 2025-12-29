import 'package:duckyapp/domain/bloc/states.dart';
import 'package:duckyapp/domain/use_cases/auth_use_cases/forgot_password_use_case.dart';
import 'package:duckyapp/domain/use_cases/auth_use_cases/login_use_case.dart';
import 'package:duckyapp/domain/use_cases/auth_use_cases/sign_up_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../use_cases/auth_use_cases/reset_password_use_case.dart';
import '../use_cases/auth_use_cases/sign_out_use_case.dart';
import 'events.dart';

class AppBloc extends Bloc<AuthEvent, AuthState> {
  LoginUseCase _loginUseCase;
  SignUpUseCase _signUpUseCase;
  SignOutUseCase _signOutUseCase;
  ResetPasswordUseCase _resetPasswordUseCase;
  ForgotPasswordUseCase _forgotPasswordUseCase;
  AppBloc({
    required LoginUseCase loginUseCase,
    required SignUpUseCase signUpUseCase,
    required SignOutUseCase signOutUseCase,
    required ResetPasswordUseCase resetPasswordUseCase,
    required ForgotPasswordUseCase forgotPasswordUseCase,
  })   : _loginUseCase = loginUseCase,
        _signUpUseCase = signUpUseCase,
        _signOutUseCase = signOutUseCase,
        _resetPasswordUseCase = resetPasswordUseCase,
        _forgotPasswordUseCase = forgotPasswordUseCase,
        super(WaitingState()) {
    on<LoginEvent>((event, emit) {
      // Bloc will automatically inject the object event(what we pass) and emit function(Bloc created) into this callback function

      emit(WaitingState());
      state.toString();
    });
    on<RegisterEvent>((event, emit) {
      emit(WaitingState());
      state.toString();
    });
    on<LogoutEvent>((event, emit) {
      emit(WaitingState());
      state.toString();
    });
    on<EmailVerifyEvent>((event, emit) {
      emit(WaitingState());
      state.toString();
    });
  }
}
