// @dart=2.9


import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:notekeeper/core/helper/notes_db_helper.dart';
import 'package:notekeeper/core/service_locator.dart';
import 'package:notekeeper/ui/screens/home_screen/home_screen.dart';
import 'package:notekeeper/ui/screens/splash_screen.dart';
import 'package:notekeeper/ui/screens/home_screen/home_view_model.dart';




void main() {
  setupServiceLocator();
  runApp(
      MyApp()
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

