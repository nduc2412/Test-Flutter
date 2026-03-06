import 'package:duckyapp/domain/entities/user_entity.dart';

import '../../domain/entities/note_entity.dart';

class GetAllNotesEvent implements NoteEvent {
  final String userId;

  const GetAllNotesEvent({required this.userId});
}

class AddNoteEvent implements NoteEvent {
  final String userId;

  const AddNoteEvent({required this.userId});
}

class UpdateNoteEvent implements NoteEvent {
  final String userId;

  const UpdateNoteEvent({required this.userId});
}
class NoteIsReadyToBuildAgainEvent implements NoteEvent {
  final List<NoteEntity> notes;

  const NoteIsReadyToBuildAgainEvent({required this.notes});
}
class ReloadNoteEvent implements NoteEvent {
  const ReloadNoteEvent();
}
class DeleteNoteEvent implements NoteEvent {
  final String noteId;
  final String userId;

  const DeleteNoteEvent({required this.noteId, required this.userId});
}
// Profile view events
class DeleteFavouriteNoteEvent implements NoteEvent {
  final NoteEntity note;

  DeleteFavouriteNoteEvent({
    required this.note
  });
}

class AddFavouriteNoteEvent implements NoteEvent {
  final NoteEntity note;

  AddFavouriteNoteEvent({
    required this.note
  });
}

// Search suggestions tap event
class NoteSuggestionTapEvent implements NoteEvent {
  final NoteEntity note;

  const NoteSuggestionTapEvent({required this.note});
}

class NoteTapEvent implements NoteEvent {
  final NoteEntity note;

  const NoteTapEvent({required this.note});
}

// Note view initial event
class ReadNoteEvent implements NoteEvent {}

// Note view button events
class NoteChangeButtonClickEvent implements NoteEvent {}

class NoteSaveButtonClickEvent implements NoteEvent {
  final NoteEntity note;

  NoteSaveButtonClickEvent({required this.note});
}

class NoteViewBackButtonTapEvent implements NoteEvent {}

abstract class NoteEvent {}
