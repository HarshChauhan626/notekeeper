// @dart=2.9


import 'package:flutter/material.dart';
import 'package:notekeeper/core/helper/notes_db_helper.dart';
import 'package:notekeeper/core/service_locator.dart';
import 'package:notekeeper/core/utils/colors_list.dart' as color_list;


class EditNoteViewModel extends ChangeNotifier{
  TextEditingController noteTitleEditingController=TextEditingController();
  TextEditingController noteDataEditingController=TextEditingController();


  DBHelper dbHelper=serviceLocator.get<DBHelper>();


  int titleMaxLines=10;
  int dataMaxLines=1000;

  int isPinnedValue=0;
  int isArchiveValue=0;

  Color noteColor;
  String noteColorName;

  int isPinned;
  int isArchive;
  int result;

  RegExp regExp=RegExp(r'^#');


  void initData()async{

  }

  void setUpEditingController()async{
    noteDataEditingController.addListener(() async{
      //print(_noteDataEditingController.text);
      if(regExp.hasMatch(noteDataEditingController.text)){
        print("match found");
        await Future.delayed(Duration(seconds: 2));
        noteDataEditingController.text=noteDataEditingController.text.replaceAll("#", "");
        notifyListeners();
      }
    });
  }


  void changePinnedValue(){
    isPinnedValue=1-isPinnedValue;
    notifyListeners();
  }

  void changeArchiveValue(){
    isArchiveValue=1-isArchiveValue;
    notifyListeners();
  }


  void disposeTextController(){
    noteTitleEditingController.dispose();
    noteDataEditingController.dispose();
  }

  void funcSaveNote(var uuid)async{
    int untitledCount=await dbHelper.getUntitledCount();
    var result=await dbHelper.updateNote(notesID,noteTitleEditingController.text, noteDataEditingController.text,DateTime.now().millisecondsSinceEpoch,noteColorName,isPinnedValue,isArchiveValue,"none");
  }

  void changeNoteColor(int index)async{
    noteColor=color_list.kNoteColorsMap[color_list.kNoteColors[index]];
    noteColorName=color_list.kNoteColors[index];
    notifyListeners();
  }

}
