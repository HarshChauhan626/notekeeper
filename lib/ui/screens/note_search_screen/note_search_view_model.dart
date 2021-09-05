// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:notekeeper/core/helper/notes_db_helper.dart';
import 'package:notekeeper/core/models/note_model.dart';
import 'package:notekeeper/core/service_locator.dart';

class NoteSearchViewModel extends ChangeNotifier {
  String noteColorName = "all";
  //TextEditingController searchEditingController=TextEditingController();
  bool showResult = false;

  DBHelper dbHelper = serviceLocator.get<DBHelper>();

  List<NoteModel> notesList = [];

  Future<void> searchList(String searchText, {String color = "default"}) async {
    if (searchText.length == 0) {
      showResult = false;
    } else {
      var noteList =
          await dbHelper.getSearchList(searchText: "'%$searchText%'");
      notesList = noteList.map((data) => NoteModel.fromJson(data)).toList();
      showResult = true;
    }
    notifyListeners();
  }
}
