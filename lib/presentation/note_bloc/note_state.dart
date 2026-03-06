import 'package:duckyapp/common/main_views_widgets/note_preview.dart';

import '../../domain/entities/note_entity.dart';

class NoteIsReadyToBuildState implements NoteState {
  final List<NoteEntity> notes;

  const NoteIsReadyToBuildState({required this.notes});
}
class NoteLoadedSucceedState implements NoteState {

}
class NotesNeedReloadState implements NoteActionState {}

class AddNoteSuccessState implements NoteState {}

class NoteLoadingState implements NoteState {}

class NoteNeedToDeleteLocalState implements NoteActionState {
  String noteId;

  NoteNeedToDeleteLocalState({required this.noteId});
}
class NeedToDeleteLocalFavouriteNoteState implements NoteActionState {
  String noteId;

  NeedToDeleteLocalFavouriteNoteState({required this.noteId});
}
class NeedToAddLocalFavouriteNoteState implements NoteActionState {
  String noteId;

  NeedToAddLocalFavouriteNoteState({required this.noteId});
}

// Profile view states
// Search suggestion state
class NoteSuggestionTappedState implements NoteActionState {
  final NoteEntity note;

  const NoteSuggestionTappedState({required this.note});
}

class NoteTappedState implements NoteActionState {
  final NoteEntity note;

  const NoteTappedState({required this.note});
}

// Note view state
class NoteIsChangingState implements NoteState {}

class NoteIsReadingState implements NoteState {}

class NoteViewBackButtonTappedState implements NoteActionState {}

abstract class NoteState {}

abstract class NoteActionState implements NoteState {}
