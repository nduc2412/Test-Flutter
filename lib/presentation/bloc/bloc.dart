
import 'package:duckyapp/domain/use_cases/auth_use_cases/forgot_password_use_case.dart';
import 'package:duckyapp/domain/use_cases/auth_use_cases/login_use_case.dart';
import 'package:duckyapp/domain/use_cases/auth_use_cases/sign_up_use_case.dart';
import 'package:duckyapp/presentation/bloc/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/auth_use_cases/reset_password_use_case.dart';
import '../../domain/use_cases/auth_use_cases/sign_out_use_case.dart';
import 'events.dart';
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  LoginUseCase _loginUseCase;
  SignUpUseCase _signUpUseCase;
  SignOutUseCase _signOutUseCase;
  ResetPasswordUseCase _resetPasswordUseCase;
  ForgotPasswordUseCase _forgotPasswordUseCase;
  AuthBloc({
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
        super(LoadingState()) {
    on<LoginEvent>((event, emit) {
      // Bloc will automatically inject the object event(what we pass) and emit function(Bloc created) into this callback function

      emit(LoadingState());
      state.toString();
    });
    on<RegisterEvent>((event, emit) {
      emit(LoadingState());
      state.toString();
    });
    on<LogoutEvent>((event, emit) {
      emit(LoadingState());
      state.toString();
    });
    on<PasswordResetEvent>((event, emit) {
      emit(LoadingState());
      state.toString();
    });
    on<EmailVerifyEvent>((event, emit) {
      emit(LoadingState());
      state.toString();
    });
  }
}
