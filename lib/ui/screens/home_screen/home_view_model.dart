import 'package:flutter/material.dart';
import 'package:notekeeper/core/helper/notes_db_helper.dart';
import 'package:notekeeper/core/models/note_model.dart';
import 'package:notekeeper/core/service_locator.dart';
import 'package:notekeeper/main.dart';


class HomeViewModel extends ChangeNotifier{
  DBHelper dbHelper=serviceLocator.get<DBHelper>();
  List<NoteModel> notesList=[];

  bool isGrid = true;

  List<String> listOfSorting=[
    'TITLE ASC',
    'TITLE DESC',
    'LASTUPDATETIME ASC',
    'LASTUPDATETIME DESC'
  ];
  var selectedSorting="TITLE ASC";


  Future<void> fetchInitialList()async{
    var noteList=await dbHelper.getListOfNotes();
    notesList=noteList.map((data) => NoteModel.fromJson(data)).toList();
    notifyListeners();
  }



  void toggleGrid() async{
    isGrid=!isGrid;
    notifyListeners();
  }

  Future<void> chooseSortingType(String choice)async{
    selectedSorting=choice;
    notifyListeners();
  }

  Future refreshNoteList() async {
    await fetchInitialList();
    notifyListeners();
  }



}