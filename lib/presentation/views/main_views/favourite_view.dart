import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/main_views_widgets/note_drawer.dart';
import '../../../common/main_views_widgets/note_preview.dart';
import '../../../domain/entities/note_entity.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../utils/const/field_radius.dart';
import '../../../utils/const/note_space.dart';
import '../../../utils/const/note_text.dart';
import '../../../utils/routes/routes.dart';
import '../../note_bloc/note_bloc.dart';
import '../../note_bloc/note_events.dart';
import '../../note_bloc/note_state.dart';

class FavouriteView extends StatefulWidget {
  const FavouriteView({super.key});

  @override
  State<FavouriteView> createState() => _FavouriteViewState();
}

class _FavouriteViewState extends State<FavouriteView> {
  late final AuthUserEntity user;

  @override
  void didChangeDependencies() {
    if (ModalRoute.of(context)!.settings.arguments == null) {
      user = AuthUserEntity(
        id: 'L87kkoZcovRi2KRGdDVIGOwN1y83',
        email: 'phuocduc2007@gmail.com',
        isEmailVerified: true,
        userName: 'pduc2412312',
        firstName: 'Nguyen',
        lastName: 'Duc',
        phoneNumber: '0123456789',
        favourite: [],
      );
    } else {
      user = ModalRoute.of(context)!.settings.arguments as AuthUserEntity;
    }

    // Vẫn gọi GetAllNotes để lấy dữ liệu mới nhất từ server
    context.read<NoteBloc>().add(GetAllNotesEvent(userId: user.id));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteBloc, NoteState>(
      bloc: context.read<NoteBloc>(),
      listenWhen: (_, state) => state is NoteActionState,
      listener: (context, state) async {
        if (state is NotesNeedReloadState) {
          context.read<NoteBloc>().add(GetAllNotesEvent(userId: user.id));
        } else if (state is NoteTappedState || state is NoteSuggestionTappedState) {
          final note = (state is NoteTappedState) ? state.note : (state as NoteSuggestionTappedState).note;
          await Navigator.pushNamed(context, Routes.noteView, arguments: note);
        } else if (state is NeedToDeleteLocalFavouriteNoteState) {
          setState(() {
            user.favourite.remove(state.noteId);
          });
        } else if (state is NeedToAddLocalFavouriteNoteState) {
          setState(() {
            user.favourite.add(state.noteId);
          });
        }
      },
      buildWhen: (_, state) => state is! NoteActionState && state is! NoteIsReadingState,
      builder: (context, state) {
        // Render nội dung dựa trên State
        return Scaffold(
          drawer: NoteDrawer(
            user: user,
            currentRoute: ModalRoute.of(context)!.settings.name!,
          ),
          appBar: _buildAppBar(),
          body: _buildBody(state),
        );
      },
    );
  }

  // --- Widget Components ---

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text("Favourite"),
      centerTitle: true,
      backgroundColor: Colors.yellow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(
          bottomStart: Radius.circular(NRadius.barRadius),
          bottomEnd: Radius.circular(NRadius.barRadius),
        ),
      ),
    );
  }

  Widget _buildBody(NoteState state) {
    if (state is NoteLoadingState) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is AllNotesLoadedSuccessState) {
      // Logic quan trọng: Lọc danh sách chỉ lấy những note đã favourite
      final favouriteNotes = state.notes.where((note) => user.favourite.contains(note.id)).toList();

      if (favouriteNotes.isEmpty) {
        return const Center(child: Text("No favourite notes yet!"));
      }

      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: NSpace.paddingScreenSpaceHorizontal,
          vertical: NSpace.paddingScreenSpaceVertical / 2,
        ),
        child: Column(
          children: [
            _buildSearchAnchor(favouriteNotes),
            SizedBox(height: NSpace.paddingScreenSpaceVertical / 2),
            Expanded(
              child: ListView.builder(
                itemCount: favouriteNotes.length,
                itemBuilder: (context, index) {
                  return Note(
                    note: favouriteNotes[index],
                    isFavourite: true, // Vì đã lọc nên chắc chắn là true
                  );
                },
              ),
            ),
          ],
        ),
      );
    }

    return Center(child: Text("Error loading notes: ${state.runtimeType}"));
  }

  Widget _buildSearchAnchor(List<NoteEntity> favouriteNotes) {
    return SearchAnchor.bar(
      barLeading: const Icon(Icons.search),
      barHintText: "Search your favourite note",
      suggestionsBuilder: (searchContext, controller) {
        final query = controller.text.toLowerCase();
        final results = favouriteNotes.where((note) {
          return note.title.toLowerCase().contains(query);
        }).toList();

        if (results.isEmpty) {
          return [ListTile(title: Text(NText.noResultsFound))];
        }

        return results.map((note) => ListTile(
          title: Text(note.title),
          subtitle: Text(note.text, maxLines: 1, overflow: TextOverflow.ellipsis),
          onTap: () => context.read<NoteBloc>().add(NoteSuggestionTapEvent(note: note)),
        )).toList();
      },
    );
  }
}
