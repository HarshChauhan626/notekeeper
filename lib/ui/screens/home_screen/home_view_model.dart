// @dart=2.9

import 'package:flutter/material.dart';
import 'package:notekeeper/core/helper/notes_db_helper.dart';
import 'package:notekeeper/core/models/note_model.dart';
import 'package:notekeeper/core/service_locator.dart';
import 'package:notekeeper/main.dart';

class HomeViewModel extends ChangeNotifier {
  DBHelper dbHelper = serviceLocator.get<DBHelper>();
  List<NoteModel> notesList = [];

  bool isGrid = true;

  List<String> listOfSorting = [
    'Title ASC',
    'Title DESC',
    'LastUpdateTime ASC',
    'LastUpdateTime DESC'
  ];

  Map<String, String> sortingMap = {
    'Title ASC': "noteTitle ASC",
    'Title DESC': "noteTitle DESC",
    'LastUpdateTime ASC': "updateTime ASC",
    'LastUpdateTime DESC': "updateTime DESC"
  };

  var selectedSorting = "noteTitle ASC";

  Future<void> fetchInitialList() async {
    var noteList = await dbHelper.getListOfNotes(selectedSorting);
    notesList = noteList.map((data) => NoteModel.fromJson(data)).toList();
    notifyListeners();
  }

  void toggleGrid() async {
    isGrid = !isGrid;
    notifyListeners();
  }

  Future<void> chooseSortingType(String choice) async {
    selectedSorting = sortingMap[choice];
    notifyListeners();
  }

  Future<void> refreshNoteList() async {
    print("refresh list called");
    await fetchInitialList();
    notifyListeners();
  }
}
