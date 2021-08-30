


import 'package:get_it/get_it.dart';
import 'package:notekeeper/core/helper/notes_db_helper.dart';
import 'package:notekeeper/ui/screens/add_edit_screen/add_edit_view_model.dart';
import 'package:notekeeper/ui/screens/home_screen/home_view_model.dart';
import 'package:notekeeper/ui/screens/note_search_screen/note_search_view_model.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  serviceLocator.registerSingleton<DBHelper>(DBHelper(notesTableName: "notesTable"));
  serviceLocator.registerFactory<HomeViewModel>(() => HomeViewModel());
  serviceLocator.registerFactory<AddNoteViewModel>(() => AddNoteViewModel());
  serviceLocator.registerFactory<NoteSearchViewModel>(() => NoteSearchViewModel());
}
