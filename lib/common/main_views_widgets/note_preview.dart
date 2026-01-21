import 'package:duckyapp/presentation/note_bloc/note_bloc.dart';
import 'package:duckyapp/presentation/note_bloc/note_events.dart';
import 'package:duckyapp/utils/const/font_weight.dart';
import 'package:duckyapp/utils/const/note_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/note_entity.dart';


class Note extends StatelessWidget {
  final NoteEntity note;

   const Note({
    super.key,
    required this.note,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          context.read<NoteBloc>().add(NoteTapEvent(note: note));
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
                        tag: "${note.id}title",
                        child: Text(
                          note.title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: NFontWeight.titleFontWeight,
                          ),
                        ),
                      ),
                      Text(
                        note.text,
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 17,
                          fontWeight: NFontWeight.blurFontWeight,
                          color: Colors.black.withValues(alpha: 0.5),
                        ),
                      ),
                      // Day created
                      Hero(
                        tag: "${note.id}date",
                        child: Text(
                          "1/1/1",
                          style: TextStyle(
                            fontWeight: NFontWeight.boldFontWeight,
                            fontSize: 19,
                          ),
                        ),
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
