import 'package:duckyapp/presentation/note_bloc/note_bloc.dart';
import 'package:duckyapp/presentation/note_bloc/note_events.dart';
import 'package:duckyapp/utils/const/font_weight.dart';
import 'package:duckyapp/utils/const/note_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/note_entity.dart';

class Note extends StatefulWidget {
  final NoteEntity note;
  bool isFavourite;
  Note({super.key, required this.note, required this.isFavourite});

  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  late bool _isFavourite;
  @override
  void initState() {
    _isFavourite = widget.isFavourite;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          context.read<NoteBloc>().add(NoteTapEvent(note: widget.note));
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Color(0xFFC99180).withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Hero(
                        tag: "${widget.note.id}title",
                        child: Text(
                          widget.note.title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: NFontWeight.titleFontWeight,
                          ),
                        ),
                      ),
                      Text(
                        widget.note.text,
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 17,
                          fontWeight: NFontWeight.blurFontWeight,
                          color: Colors.black.withValues(alpha: 0.5),
                        ),
                      ),
                      // Day created and favourite
                      Row(
                        children: [
                          Hero(
                            tag: "${widget.note.id}date",
                            child: Text(
                              "1/1/1",
                              style: TextStyle(
                                fontWeight: NFontWeight.boldFontWeight,
                                fontSize: 19,
                              ),
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            icon: _isFavourite ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
                            color: Colors.red,
                            onPressed: () {
                              if (_isFavourite) {
                                context.read<NoteBloc>().add(
                                  DeleteFavouriteNoteEvent(
                                    note: widget.note,
                                  ),
                                );
                              }
                              else {
                                context.read<NoteBloc>().add(
                                  AddFavouriteNoteEvent(
                                    note: widget.note,
                                  ),
                                );
                              }
                              setState(() {
                                _isFavourite = !_isFavourite;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
