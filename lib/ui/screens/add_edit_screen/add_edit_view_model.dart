// @dart=2.9

import 'package:flutter/material.dart';
import 'package:notekeeper/core/helper/notes_db_helper.dart';
import 'package:notekeeper/core/service_locator.dart';
import 'package:notekeeper/core/utils/colors_list.dart';

class AddNoteViewModel extends ChangeNotifier {
  TextEditingController noteTitleEditingController = TextEditingController();
  TextEditingController noteDataEditingController = TextEditingController();

  DBHelper dbHelper = serviceLocator.get<DBHelper>();

  int titleMaxLines = 10;
  int dataMaxLines = 1000;

  int isPinnedValue = 0;
  int isArchiveValue = 0;

  Color noteColor = ColorList.appbackgroundColorDark;
  String noteColorName = "default";

  // TODO :- Change font to something meaningful
  String noteFont = "roboto";

  RegExp regExp = RegExp(r'^#');

  void setUpEditingController() async {
    noteDataEditingController.addListener(() async {
      //print(_noteDataEditingController.text);
      if (regExp.hasMatch(noteDataEditingController.text)) {
        print("match found");
        await Future.delayed(Duration(seconds: 2));
        noteDataEditingController.text =
            noteDataEditingController.text.replaceAll("#", "");
        notifyListeners();
      }
    });
  }

  void changePinnedValue() {
    isPinnedValue = 1 - isPinnedValue;
    notifyListeners();
  }

  void changeArchiveValue() {
    isArchiveValue = 1 - isArchiveValue;
    notifyListeners();
  }

  void disposeTextController() {
    noteTitleEditingController.dispose();
    noteDataEditingController.dispose();
  }

  void funcSaveNote(var uuid) async {
    int untitledCount = await dbHelper.getUntitledCount();
    if ((noteDataEditingController.text.length >= 1) &&
        (noteTitleEditingController.text.length == 0)) {
      dbHelper.add(
          uuid.v1(),
          "Untitled ${untitledCount + 1}",
          noteDataEditingController.text,
          DateTime.now().millisecondsSinceEpoch,
          DateTime.now().millisecondsSinceEpoch,
          noteColorName,
          isPinnedValue,
          isArchiveValue,
          "none");
    }
    if ((noteDataEditingController.text.length >= 1) &&
        (noteTitleEditingController.text.length != 0)) {
      dbHelper.add(
          uuid.v1(),
          noteTitleEditingController.text,
          noteDataEditingController.text,
          DateTime.now().millisecondsSinceEpoch,
          DateTime.now().millisecondsSinceEpoch,
          noteColorName,
          isPinnedValue,
          isArchiveValue,
          "none");
    }
  }

  void changeNoteColor(int index) async {
    noteColor = ColorList.kNoteColorsMap[ColorList.kNoteColors[index]];
    noteColorName = ColorList.kNoteColors[index];
    notifyListeners();
  }

  void changeNoteFont(String choice) async {
    noteFont = choice;
    notifyListeners();
  }
}
