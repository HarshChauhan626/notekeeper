// @dart=2.9

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:notekeeper/ui/screens/add_edit_screen/edit_note_screen.dart';
import 'package:notekeeper/core/utils/colors_list.dart' as color_list;
import 'package:notekeeper/core/utils/textstyle_list.dart' as textstyle_list;
class NoteGridCard extends StatelessWidget {
  int index;
  Map<String,dynamic> note;
  NoteGridCard({
    Key key,
    this.index,
    this.note,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    print(note['noteColor']);
    //final minHeight = getMinHeight(index);
    final minHeight=140.0;

    return OpenContainer(
      transitionType: ContainerTransitionType.fade,
      transitionDuration: Duration(milliseconds:400),
      openBuilder: (context, _) {
        return EditNoteScreen(note:this.note);
      },
      closedColor: color_list.appbackgroundColorDark,
      closedBuilder: (context, VoidCallback openContainer) => GestureDetector(
        onTap: (){
          openContainer();
        },
        child: Card(
          color: color_list.appbackgroundColorDark,
          child: Container(
            decoration: BoxDecoration(
                color: note['noteColor']=="default"?color_list.containerColor:color_list.kNoteColorsMap[note['noteColor']],
                borderRadius: BorderRadius.circular(10)
            ),
            padding: EdgeInsets.all(8),
            constraints: BoxConstraints(minHeight: minHeight),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note['noteTitle'],
                  style: textstyle_list.whiteContentStyle,
                ),
                Text(
                  note['noteData'],
                  style: textstyle_list.whiteContentStyle,
                ),
                Text(note['noteColor'].toString())
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






