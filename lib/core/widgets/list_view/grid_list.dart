// @dart=2.9

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notekeeper/core/models/note_model.dart';
import 'package:notekeeper/core/widgets/note_grid_card.dart';
import 'package:notekeeper/main.dart';
import 'package:notekeeper/ui/screens/home_screen/home_view_model.dart';
import 'package:provider/provider.dart';

class NotesGridList extends StatelessWidget {

  List<NoteModel> noteList;
  HomeViewModel viewModel;

  NotesGridList({
    Key key,
    this.noteList,
    this.viewModel
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
            child: StaggeredGridView.countBuilder(
                crossAxisCount: 4,
                itemCount: noteList.length,
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
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
                staggeredTileBuilder: (index) => StaggeredTile.fit(2))
    );
  }
}






