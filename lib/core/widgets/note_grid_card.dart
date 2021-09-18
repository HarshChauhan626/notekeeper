// @dart=2.9

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:notekeeper/core/models/note_model.dart';
import 'package:notekeeper/core/utils/textstyle_list.dart';
import 'package:notekeeper/ui/screens/add_edit_screen/edit_note_screen.dart';
import 'package:notekeeper/core/utils/colors_list.dart';
class NoteGridCard extends StatelessWidget {
  int index;
  NoteModel note;
  NoteGridCard({
    Key key,
    this.index,
    this.note,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    print(note.noteColor.value.toString());
    //final minHeight = getMinHeight(index);
    final minHeight=140.0;

    return OpenContainer(
      transitionType: ContainerTransitionType.fade,
      transitionDuration: Duration(milliseconds:400),
      openBuilder: (context, _) {
        return EditNoteScreen(note:this.note);
      },
      closedColor: ColorList.appbackgroundColorDark,
      closedBuilder: (context, VoidCallback openContainer) => GestureDetector(
        onTap: (){
          openContainer();
        },
        child: Card(
          color: ColorList.appbackgroundColorDark,
          child: Container(
            decoration: BoxDecoration(
                color: note.noteColor,
                borderRadius: BorderRadius.circular(10)
            ),
            padding: EdgeInsets.all(8),
            constraints: BoxConstraints(minHeight: minHeight),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 20,
                ),
                Text(
                  note.noteTitle,
                  style: CustomTextStyle.whiteContentStyle,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  note.noteData,
                  style: CustomTextStyle.whiteContentStyle,
                ),
                //Text(note.not.toString())
              ],
            ),
          ),
        ),
      )
    );
  }


  double getMinHeight(int index) {
    switch (index % 4) {
      case 0:
        return 100;
      case 1:
        return 150;
      case 2:
        return 150;
      case 3:
        return 100;
      default:
        return 100;
    }
  }
}






