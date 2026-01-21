import 'package:duckyapp/common/main_views_widgets/note_preview.dart';

import '../../domain/entities/note_entity.dart';

class AllNotesLoadedSuccessState implements NoteState {
  final List<NoteEntity> notes;
  const AllNotesLoadedSuccessState({required this.notes});
}
class NotesNeedReloadState implements NoteActionState {}
class AddNoteSuccessState implements NoteState {}
class NoteLoadingState implements NoteState {}
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
class NoteIsChangingState implements NoteActionState {}
class NoteIsReadingState implements NoteActionState {}
class NoteViewBackButtonTappedState implements NoteActionState {}

abstract class NoteState {}
abstract class NoteActionState implements NoteState {}