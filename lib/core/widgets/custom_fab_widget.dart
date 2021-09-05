// @dart=2.9

import 'package:animations/animations.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:notekeeper/ui/screens/add_edit_screen/add_note_screen.dart';

const double fabSize = 56;

class CustomFABWidget extends StatelessWidget {
  CustomFABWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => OpenContainer(
        transitionDuration: Duration(milliseconds: 400),
        openBuilder: (context, _) => AddNoteScreen(
            //voidCallBack: this.callback,
            ),
        closedShape: CircleBorder(),
        closedColor: Theme.of(context).primaryColor,
        closedBuilder: (context, openContainer) => Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).primaryColor,
          ),
          height: fabSize,
          width: fabSize,
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 40,
          ),
        ),
      );
}
