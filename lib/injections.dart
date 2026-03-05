import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duckyapp/data/data_source/fire_base/fire_base.dart';
import 'package:duckyapp/data/repositories_impl/auth_repo_impl.dart';
import 'package:duckyapp/data/repositories_impl/note_repo_impl.dart';
import 'package:duckyapp/domain/repository/auth_repository.dart';
import 'package:duckyapp/domain/use_cases/auth_use_cases/login_use_case.dart';
import 'package:duckyapp/domain/use_cases/auth_use_cases/user_reload_use_case.dart';
import 'package:duckyapp/domain/use_cases/note_use_cases/delete_note_use_case.dart';
import 'package:duckyapp/domain/use_cases/note_use_cases/new_note_use_case.dart';
import 'package:duckyapp/domain/use_cases/note_use_cases/update_note_use_case.dart';
import 'package:duckyapp/presentation/bloc/bloc.dart';
import 'package:duckyapp/presentation/note_bloc/note_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import 'app_router.dart';
import 'data/data_source/auth_data_source.dart';
import 'data/data_source/fire_store/fire_store_note.dart';
import 'data/data_source/fire_store/fire_store_user.dart';
import 'data/data_source/note_data_source.dart';
import 'data/data_source/user_data_source.dart';
import 'domain/repository/note_repository.dart';
import 'domain/use_cases/auth_use_cases/forgot_password_use_case.dart';
import 'domain/use_cases/auth_use_cases/get_current_user.dart';
import 'domain/use_cases/auth_use_cases/send_email_verification_use_case.dart';
import 'domain/use_cases/auth_use_cases/sign_out_use_case.dart';
import 'domain/use_cases/auth_use_cases/sign_up_use_case.dart';
import 'domain/use_cases/auth_use_cases/update_user_verified_use_case.dart';
import 'domain/use_cases/note_use_cases/add_favourite_use_case.dart';
import 'domain/use_cases/note_use_cases/delete_favourite_use_case.dart';
import 'domain/use_cases/note_use_cases/get_all_favourite_use_case.dart';
import 'domain/use_cases/note_use_cases/get_all_notes_use_caes.dart';

final locator = GetIt.I;

void setUpDependency() {
  locator.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  locator.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );
  // Create data source
  locator.registerSingleton<AuthDataSource>(
    FireBaseAuthDataSource(locator<FirebaseAuth>()),
  );
  locator.registerSingleton<NoteDataSource>(
    FireStoreNoteDataSource(locator<FirebaseFirestore>()),
  );
  locator.registerSingleton<UserDataSource>(
    FireStoreUserDataSource(locator<FirebaseFirestore>()),
  );
  // Create repositories
  locator.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(
      authDataSource: locator<AuthDataSource>(),
      userDataSource: locator<UserDataSource>(),
    ),
  );
  locator.registerLazySingleton<NoteRepository>(
    () => NoteRepositoryImpl(noteDataSource: locator<NoteDataSource>()),
  );

  // Login use case
  locator.registerSingleton<LoginUseCase>(
    LoginUseCase(authRepository: locator<AuthRepository>()),
  );
  // Sign up use case
  locator.registerSingleton<SignUpUseCase>(
    SignUpUseCase(authRepository: locator<AuthRepository>()),
  );
  // Sign out use case
  locator.registerSingleton<SignOutUseCase>(
    SignOutUseCase(authRepository: locator<AuthRepository>()),
  );
  // Send reset password use case
  locator.registerSingleton<SendResetPasswordUseCase>(
    SendResetPasswordUseCase(authRepository: locator<AuthRepository>()),
  );
  // Email verification use case
  locator.registerSingleton<SendEmailVerificationUseCase>(
    SendEmailVerificationUseCase(authRepository: locator<AuthRepository>()),
  );
  // Reload user use case
  locator.registerSingleton<ReloadUserUseCase>(
    ReloadUserUseCase(authRepository: locator<AuthRepository>()),
  );
  // Get current user use case
  locator.registerSingleton<GetCurrentUserUseCase>(
    GetCurrentUserUseCase(authRepository: locator<AuthRepository>()),
  );
  // Update user verified status use case
  locator.registerSingleton<UpdateUserVerifiedUseCase>(
    UpdateUserVerifiedUseCase(authRepository: locator<AuthRepository>()),
  );
  // Get notes use case
  locator.registerLazySingleton<GetAllNotesUseCase>(
    () => GetAllNotesUseCase(repo: locator<NoteRepository>()),
  );
  // Add note use case
  locator.registerLazySingleton(
    () => NewNoteUseCase(noteRepo: locator<NoteRepository>()),
  );
  // Update note use case
  locator.registerLazySingleton(
    () => UpdateNoteUseCase(noteRepo: locator<NoteRepository>()),
  );
  // Delete note use case
  locator.registerLazySingleton(
    () => DeleteNoteUseCase(noteRepo: locator<NoteRepository>()),
  );
  //Delete favourite note use case
  locator.registerLazySingleton(
        () => DeleteFavouriteNoteUseCase(repo: locator<AuthRepository>()),
  );
  // Add favourite note use case
  locator.registerLazySingleton(
        () => AddFavouriteNoteUseCase(repo: locator<AuthRepository>()),
  );
  // Get all favourite notes use case
  locator.registerLazySingleton(
        () => GetAllFavouriteUseCase(repo: locator<AuthRepository>()),
  );

  // Note bloc
  locator.registerLazySingleton<NoteBloc>(
    () => NoteBloc(
      createNoteUseCase: locator<NewNoteUseCase>(),
      getAllNotesUseCase: locator<GetAllNotesUseCase>(),
      updateNoteUseCase: locator<UpdateNoteUseCase>(),
      deleteNoteUseCase: locator<DeleteNoteUseCase>(),
      reloadUserUseCase: locator<ReloadUserUseCase>(),
    ),
  );

  locator.registerLazySingleton<AppRouter>(
    () => AppRouter(noteBloc: locator<NoteBloc>()),
  );
}
