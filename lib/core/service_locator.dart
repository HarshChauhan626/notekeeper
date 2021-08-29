


import 'package:get_it/get_it.dart';
import 'package:notekeeper/core/helper/notes_db_helper.dart';
import 'package:notekeeper/ui/screens/home_screen/home_view_model.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  // services
/*
  serviceLocator.registerLazySingleton<WebApi>(() => WebApiImpl());
  serviceLocator.registerLazySingleton<StorageService>(() => StorageServiceImpl());
  serviceLocator.registerLazySingleton<CurrencyService>(() => CurrencyServiceImpl());
*/

  // You can replace the actual services above with fake implementations during development.
  //
  // serviceLocator.registerLazySingleton<WebApi>(() => FakeWebApi());
  // serviceLocator.registerLazySingleton<StorageService>(() => FakeStorageService());
  // serviceLocator.registerLazySingleton<CurrencyService>(() => CurrencyServiceFake());

  // view models
  serviceLocator.registerSingleton<DBHelper>(DBHelper(notesTableName: "notesTable"));
  serviceLocator.registerFactory<HomeViewModel>(() => HomeViewModel());
}
