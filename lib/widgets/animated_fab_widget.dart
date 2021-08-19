// @dart=2.9

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:notekeeper/helper/notes_db_helper.dart';

class AnimatedFABWIdget extends StatefulWidget {
  ContainerTransitionType transitionType;
  DBHelper dbHelper;
  VoidCallback callback;

  AnimatedFABWIdget({
    transitionType,
    dbHelper,
    callback
});
  @override
  _AnimatedFABWIdgetState createState() => _AnimatedFABWIdgetState();
}

class _AnimatedFABWIdgetState extends State<AnimatedFABWIdget>
    with TickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )
      ..forward()
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Container(
            decoration: ShapeDecoration(
              color: Colors.white.withOpacity(0.5),
              shape: CircleBorder(),
            ),
            child: Padding(
              padding: EdgeInsets.all(
                8.0 * animationController.value,
              ),
              child: child,
            ),
          );
        },
        child: Container(
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: CircleBorder(),
          ),
          child: IconButton(
            onPressed: () {
              print('button tapped');
              this.widget.callback;
            },
            color: Colors.blue,
            icon: Icon(
              Icons.calendar_today,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}