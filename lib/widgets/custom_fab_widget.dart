// @dart=2.9


import 'package:animations/animations.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:notekeeper/screens/add_note_screen.dart';

const double fabSize = 56;

class CustomFABWidget extends StatelessWidget {
  final ContainerTransitionType transitionType;
  final dbHelper;
  final VoidCallback callback;

  const CustomFABWidget({
    Key key,
    @required this.transitionType,
    @required this.dbHelper,
    @required this.callback
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => OpenContainer(
    transitionDuration: Duration(milliseconds: 400),
    openBuilder: (context, _) => AddNoteScreen(
      dbHelper: dbHelper,
      callback: this.callback,
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
      child: Icon(Icons.add, color: Colors.white,size: 40,),
    ),
  );
}