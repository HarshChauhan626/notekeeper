// @dart=2.9

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:notekeeper/core/widgets/note_grid_card.dart';
import 'package:notekeeper/main.dart';
import 'package:notekeeper/ui/screens/home_screen/home_view_model.dart';

class NotesGridList extends StatelessWidget {

  List<Map<String,dynamic>> noteList;


  NotesGridList({
    Key key,
    this.noteList
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: GridView.count(
        crossAxisCount: 2,
        children: List.generate(
          noteList.length,
              (int index) {
            return AnimationConfiguration.staggeredGrid(
              position: index,
              duration: const Duration(milliseconds: 375),
              columnCount: 2,
              child: ScaleAnimation(
                child: FadeInAnimation(
                  child: NoteGridCard(index: index,note: noteList[index],),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}




