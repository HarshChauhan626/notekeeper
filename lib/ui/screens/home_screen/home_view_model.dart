import 'package:flutter/material.dart';
import 'package:notekeeper/core/helper/notes_db_helper.dart';
import 'package:notekeeper/main.dart';


class HomeViewModel extends ChangeNotifier{
  DBHelper dbHelper=getItInstance.get<DBHelper>();
  List<Map<String,dynamic>> notesList=[];
  bool isGrid = true;
  List<String> listOfSorting=[
    'TITLE ASC',
    'TITLE DESC',
    'LASTUPDATETIME ASC',
    'LASTUPDATETIME DESC'
  ];
  var selectedSorting="TITLE ASC";


  Future<void> fetchInitialList()async{
    notesList=await dbHelper.getListOfNotes();
    notifyListeners();
  }

  Future<void> searchList(String searchText)async{
    if(searchText.length==0){
      notesList=await dbHelper.getListOfNotes();
    }
    else{
      notesList=await dbHelper.getSearchList(searchText: "'%${searchText}%'");
    }
  }

  void toggleGrid() async{
    isGrid=!isGrid;
    notifyListeners();
  }

  Future<void> chooseSortingType(String choice)async{
    selectedSorting=choice;
    notifyListeners();
  }



}