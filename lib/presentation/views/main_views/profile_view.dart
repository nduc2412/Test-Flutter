import 'dart:developer';

import 'package:duckyapp/domain/use_cases/auth_use_cases/get_current_user.dart';
import 'package:duckyapp/presentation/bloc/states.dart';
import 'package:duckyapp/presentation/note_bloc/note_state.dart';
import 'package:duckyapp/common/main_views_widgets/note_preview.dart';
import 'package:duckyapp/utils/const/field_radius.dart';
import 'package:duckyapp/utils/const/font_weight.dart';
import 'package:duckyapp/utils/const/note_text.dart';
import 'package:duckyapp/utils/const/size/text_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/main_views_widgets/note_drawer.dart';
import '../../../domain/entities/note_entity.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/use_cases/auth_use_cases/user_reload_use_case.dart';
import '../../../injections.dart';
import '../../../utils/const/note_space.dart';
import '../../../utils/routes/routes.dart';
import '../../bloc/bloc.dart';
import '../../bloc/events.dart';
import '../../note_bloc/note_bloc.dart';
import '../../note_bloc/note_events.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late final AuthUserEntity user;
  late  List<NoteEntity> notes;
  @override
  void didChangeDependencies() {
    if (ModalRoute.of(context)!.settings.arguments == null) {
      context.read<AuthBloc>().add(GetCurrentUserEvent());
      super.didChangeDependencies();
      return;
    }
    else {
      user = ModalRoute.of(context)!.settings.arguments as AuthUserEntity;
    }
    context.read<NoteBloc>().add(GetAllNotesEvent(userId: user.id));
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments == null) {
      log(name: "ProfileView", "Error: van chua co argument");
    }
    return BlocConsumer<NoteBloc, NoteState>(
      bloc: context.read<NoteBloc>(),
      listenWhen: (_, state) => state is NoteActionState,
      listener: (context, state) async {
        if (state is NotesNeedReloadState) {
          context.read<NoteBloc>().add(GetAllNotesEvent(userId: user.id));
        } else if (state is NoteSuggestionTappedState) {
          Navigator.pushNamed(context, Routes.noteView, arguments: state.note);
        } else if (state is NoteTappedState) {
          await Navigator.pushNamed(context, Routes.noteView, arguments: state.note);
        }
        else if (state is NeedToDeleteLocalFavouriteNoteState) {
          user.favourite.remove(state.noteId);
        }
        else if (state is NeedToAddLocalFavouriteNoteState) {
          user.favourite.add(state.noteId);
        }
        else if (state is NoteNeedToDeleteLocalState) {
          setState(() {
            notes.removeWhere((note) => note.id == state.noteId);
          });
          context.read<NoteBloc>().add(NoteIsReadyToBuildAgainEvent(notes: notes));
        }
      },
      buildWhen: (_, state) => state is! NoteActionState && state is! NoteIsReadingState,
      builder: (context, state) {
        if (state is NoteLoadingState) {
          print(user.userName);
          return Scaffold(
            drawer: NoteDrawer(
              user: user,
              currentRoute: ModalRoute.of(context)!.settings.name!,
            ),
            appBar: AppBar(
              backgroundColor: Colors.yellow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.directional(
                  bottomStart: Radius.circular(NRadius.barRadius),
                  bottomEnd: Radius.circular(NRadius.barRadius),
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: NSpace.paddingScreenSpaceHorizontal,
                vertical: NSpace.paddingScreenSpaceVertical / 2,
              ),
              child: Column(
                children: [
                  SearchAnchor(
                    builder: (context, controller) {
                      return SearchBar(
                        controller: controller,
                        onTap: () {
                          controller.openView();
                        },
                        leading: const Icon(Icons.search),
                      );
                    },
                    suggestionsBuilder:
                        (BuildContext context, SearchController controller) {
                          return List.generate(5, (index) {
                            return ListTile(title: Text('Suggestion $index'));
                          });
                        },
                    shrinkWrap: false,
                  ),
                  Expanded(
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                ],
              ),
            ),
          );
        } else if (state is NoteIsReadyToBuildState) {
          notes = state.notes;
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                context.read<NoteBloc>().add(AddNoteEvent(userId: user.id));
              },
              child: Icon(Icons.add),
            ),
            drawer: NoteDrawer(
              user: user,
              currentRoute: ModalRoute.of(context)!.settings.name!,
            ),
            appBar: AppBar(
              backgroundColor: Colors.yellow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.directional(
                  bottomStart: Radius.circular(NRadius.barRadius),
                  bottomEnd: Radius.circular(NRadius.barRadius),
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: NSpace.paddingScreenSpaceHorizontal,
                vertical: NSpace.paddingScreenSpaceVertical / 2,
              ),
              child: Column(
                children: [
                  SearchAnchor.bar(
                    barLeading: Icon(Icons.search),
                    barHintText: "Search for your note",
                    suggestionsBuilder: (searchContext, controller) {
                      final query = controller.text.toLowerCase();
                      final results = notes.where((note) {
                        final title = note.title.toLowerCase();
                        return title.contains(query);
                      })..toList();
                      if (results.isEmpty) {
                        return [
                          ListTile(
                            title: Text(
                              NText.noResultsFound,
                              style: TextStyle(
                                fontWeight: NFontWeight.boldFontWeight,
                                fontSize: NTextSize.noteTitleFontSize,
                              ),
                            ),
                            onTap: () {
                              context.read<NoteBloc>().add(ReadNoteEvent());
                            },
                          ),
                        ];
                      } else {
                        return results.map((note) {
                          return ListTile(
                            title: Text(
                              note.title,
                              style: TextStyle(
                                fontWeight: NFontWeight.boldFontWeight,
                                fontSize: NTextSize.noteTitleFontSize,
                              ),
                            ),
                            subtitle: Text(
                              note.text,
                              style: TextStyle(
                                fontWeight: NFontWeight.blurFontWeight,
                                fontSize: NTextSize.noteSubtitleFontSize,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),

                            onTap: () {
                              context.read<NoteBloc>().add(
                                NoteSuggestionTapEvent(note: note),
                              );
                            },
                          );
                        });
                      }
                    },
                    shrinkWrap: false,
                  ),
                  SizedBox(height: NSpace.paddingScreenSpaceVertical / 2),
                  Expanded(
                    child: notes.isEmpty
                        ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.note_alt_outlined,
                            size: 80,
                            color: Colors.grey.withValues(alpha: 0.5),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "You don't have any notes yet",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )
                        : ListView.builder(
                      itemCount: notes.length,
                      itemBuilder: (context, index) {
                        return Note(
                          key: ValueKey(notes[index].id),
                          note: notes[index],
                          isFavourite: user.favourite.contains(notes[index].id),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          print(state.runtimeType);
          return Text(state.runtimeType.toString());
        }
      },
    );
  }
}
