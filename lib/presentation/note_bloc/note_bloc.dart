import 'package:duckyapp/domain/use_cases/auth_use_cases/user_reload_use_case.dart';
import 'package:duckyapp/presentation/bloc/events.dart';
import 'package:duckyapp/presentation/bloc/states.dart';
import 'package:duckyapp/presentation/note_bloc/note_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/auth_use_cases/get_current_user.dart';
import '../../domain/use_cases/note_use_cases/add_favourite_use_case.dart';
import '../../domain/use_cases/note_use_cases/delete_favourite_use_case.dart';
import '../../domain/use_cases/note_use_cases/delete_note_use_case.dart';
import '../../domain/use_cases/note_use_cases/get_all_notes_use_caes.dart';
import '../../domain/use_cases/note_use_cases/new_note_use_case.dart';
import '../../domain/use_cases/note_use_cases/update_note_use_case.dart';
import '../../injections.dart';
import 'note_events.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final GetAllNotesUseCase getAllNotesUseCase;
  final NewNoteUseCase createNoteUseCase;
  final UpdateNoteUseCase updateNoteUseCase;
  final DeleteNoteUseCase deleteNoteUseCase;
  final ReloadUserUseCase reloadUserUseCase;

  NoteBloc({
    required this.getAllNotesUseCase,
    required this.createNoteUseCase,
    required this.updateNoteUseCase,
    required this.deleteNoteUseCase,
    required this.reloadUserUseCase,
  }) : super(NoteLoadingState()) {
    on<GetAllNotesEvent>(_getAllNotes);
    on<AddNoteEvent>(_addNote);
    on<NoteSuggestionTapEvent>((event, emit) {
      emit(NoteSuggestionTappedState(note: event.note));
    });
    on<NoteChangeButtonClickEvent>((event, emit) {
      emit(NoteIsChangingState());
    });
    on<ReadNoteEvent>((event, emit) {
      emit(NoteIsReadingState());
    });
    on<NoteSaveButtonClickEvent>((event, emit) async {
      emit(NoteLoadingState());
      try {
        await updateNoteUseCase(
          UpdateNoteParams(
            noteId: event.note.id,
            text: event.note.text,
            title: event.note.title,
          ),
        );
        await reloadUserUseCase.call();
      } catch (e) {
        print(e.toString());
      }
      emit(NoteIsReadingState());
      if (kDebugMode) {
        print("done");
      }
    });
    on<NoteViewBackButtonTapEvent>((event, emit) {
      emit(NoteViewBackButtonTappedState());
    });
    on<NoteTapEvent>((event, emit) {
      emit(NoteTappedState(note: event.note));
    });
    on<ReloadNoteEvent>((event, emit) async {
      emit(NoteLoadingState());
      await reloadUserUseCase.call();
      emit(NotesNeedReloadState());
    });
    on<DeleteFavouriteNoteEvent>((event, emit) async {
      String userId = event.note.ownerId;
      String noteId = event.note.id;
      emit(NeedToDeleteLocalFavouriteNoteState(noteId: noteId));
      try {
        await locator<DeleteFavouriteNoteUseCase>().call(
          DeleteFavouriteNoteParams(userId:userId, noteId:noteId),
        );
      } catch (e) {
        print(e.toString());
      }
    });

    on<AddFavouriteNoteEvent>((event, emit) async {
      String userId = event.note.ownerId;
      String noteId = event.note.id;
      emit(NeedToAddLocalFavouriteNoteState(noteId: noteId));
      try {
        await locator<AddFavouriteNoteUseCase>().call(
          AddFavouriteNoteParams(userId:userId, noteId:noteId),
        );
      } catch (e) {
        print(e.toString());
      }
    });
  }

  // Function
  Future<void> _addNote(AddNoteEvent event, Emitter<NoteState> emit) async {
    emit(NoteLoadingState());
    try {
      final note = await locator<NewNoteUseCase>().call(
        NewNoteParams(userId: event.userId),
      );
      reloadUserUseCase.call();
      emit(NotesNeedReloadState());
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _getAllNotes(
    GetAllNotesEvent event,
    Emitter<NoteState> emit,
  ) async {
    emit(NoteLoadingState());
    try {
      final notes = await locator<GetAllNotesUseCase>().call(
        GetAllNotesParams(userId: event.userId),
      );
      emit(AllNotesLoadedSuccessState(notes: notes));
    } catch (e) {
      print(e.toString());
    }
  }
}
