import 'package:duckyapp/presentation/note_bloc/note_state.dart';
import 'package:duckyapp/utils/const/color.dart';
import 'package:duckyapp/utils/const/font_weight.dart';
import 'package:duckyapp/utils/const/size/text_size.dart';
import 'package:duckyapp/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/note_entity.dart';
import '../../../utils/const/note_space.dart';
import '../../note_bloc/note_bloc.dart';
import '../../note_bloc/note_events.dart';

class NoteView extends StatefulWidget {
  const NoteView({super.key});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  late final NoteEntity note;
  late final TextEditingController _contentController;
  late final TextEditingController _titleController;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController();
    _titleController = TextEditingController();
    context.read<NoteBloc>().add(ReadNoteEvent());
  }

  @override
  void dispose() {
    _contentController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (ModalRoute.of(context)!.settings.arguments != null) {
      note = ModalRoute.of(context)!.settings.arguments as NoteEntity;
    } else {
      note = NoteEntity(id: "", title: "", text: "Error!", ownerId: "");
    }
    _contentController.text = note.text;
    _titleController.text = note.title;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteBloc, NoteState>(
      listenWhen: (_, state) => state is NoteActionState,
      listener: (context, state) {
        if (state is NoteViewBackButtonTappedState) {
          context.read<NoteBloc>().add(ReloadNoteEvent());
          Navigator.pop(context);
        } else if (state is NoteIsChangingState) {
          setState(() {
            isEditing = true;
          });
        } else if (state is NoteIsReadingState) {
          setState(() {
            isEditing = false;
          });
        }
      },
      buildWhen: (_, state) => state is! NoteActionState,
      builder: (context, state) {
        if (state is NoteLoadingState) {
          return Stack(
            children: [
              NoteScreen(
                note: note,
                contentController: _contentController,
                titleController: _titleController,
                isEditing: true,
              ),
              Center(child: CircularProgressIndicator()),
            ],
          );
        } else {
          return NoteScreen(
            titleController: _titleController,
            contentController: _contentController,
            note: note,
            isEditing: isEditing,
          );
        }
      },
    );
  }
}

class NoteScreen extends StatefulWidget {
  const NoteScreen({
    super.key,
    required this.note,
    required TextEditingController contentController,
    required this.isEditing,
    required TextEditingController titleController,
  }) : _contentController = contentController,
       _titleController = titleController;

  final NoteEntity note;
  final TextEditingController _contentController;
  final TextEditingController _titleController;
  final bool isEditing;

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  late final FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC99180),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(
          horizontal: NSpace.paddingScreenSpaceHorizontal / 2,
          vertical: NSpace.paddingScreenSpaceVertical / 2,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Return and change(save) button
              Row(
                // Return button
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_rounded),
                    onPressed: () {
                      context.read<NoteBloc>().add(
                        NoteViewBackButtonTapEvent(),
                      );
                    },
                  ),
                  Spacer(),
                  // Change(save) button
                  IconButton(
                    icon: widget.isEditing
                        ? Icon(Icons.save)
                        : Icon(Icons.note_alt_rounded),
                    onPressed: () {
                      if (widget.isEditing) {
                        context.read<NoteBloc>().add(
                          NoteSaveButtonClickEvent(
                            note: NoteEntity(
                              title: widget._titleController.text,
                              text: widget._contentController.text,
                              id: widget.note.id,
                              ownerId: widget.note.ownerId,
                            ),
                          ),
                        );
                      } else {
                        context.read<NoteBloc>().add(
                          NoteChangeButtonClickEvent(),
                        );
                        myFocusNode.requestFocus();
                      }
                    },
                  ),
                ],
              ),
              // Title
              Hero(
                tag: "${widget.note.id}title",
                child: Material(
                  color: Color(0xFFC99180),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: TextField(
                      controller: widget._titleController,
                      style: TextStyle(
                        fontSize: NTextSize.titleFontSize,
                        fontWeight: NFontWeight.boldFontWeight,
                      ),
                      decoration: InputDecoration(border: InputBorder.none),
                      readOnly: !widget.isEditing,
                    ),
                  ),
                ),
              ),
              SizedBox(height: NSpace.spaceBtwItems / 3),

              // Date created / nearest modified date
              Hero(
                tag: "${widget.note.id}date",
                child: Material(
                  color: Color(0xFFC99180),

                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "1/1/1",
                      style: TextStyle(
                        fontWeight: NFontWeight.boldFontWeight,
                        fontSize: NTextSize.noteTitleFontSize,
                        color: NColors.black,
                      ),
                    ),
                  ),
                ),
              ),
              // Main content of the note
              Container(
                alignment: Alignment.topLeft,
                child: TextField(
                  controller: widget._contentController,
                  maxLines: null,
                  readOnly: !widget.isEditing,
                  focusNode: widget.isEditing ? myFocusNode : null,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
