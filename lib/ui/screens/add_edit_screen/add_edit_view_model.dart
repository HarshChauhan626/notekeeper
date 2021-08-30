import 'package:flutter/material.dart';


class AddNoteViewModel extends ChangeNotifier{
  TextEditingController _noteTitleEditingController=TextEditingController();
  TextEditingController _noteDataEditingController=TextEditingController();


  DBHelper dbHelper=serviceLocator.get<DBHelper>();


  int titleMaxLines=10;
  int dataMaxLines=1000;

  int isPinnedValue=0;
  int isArchiveValue=0;

  Color noteColor=color_list.appbackgroundColorDark;
  String noteColorName="default";

  RegExp regExp=RegExp(r'^#');
}


