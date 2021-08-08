// @dart=2.9

import 'package:flutter/material.dart';
import 'package:notekeeper/utils/colors_list.dart' as color_list;
import 'package:notekeeper/utils/textstyle_list.dart' as textstyle_list;
class NotesCard extends StatelessWidget {
  int index;
  Map<String,dynamic> note;
  NotesCard({
    Key key,
    this.index,
    this.note
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    print(note['noteColor']);
    final minHeight = getMinHeight(index);
    return Card(
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
            Text(note['color'].toString())
          ],
        ),
      ),
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






