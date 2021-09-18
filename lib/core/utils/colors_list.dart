import 'package:flutter/material.dart';


class ColorList{

  static Color appbackgroundColorDark=const Color(0xff0e121a);
  static Color containerColor=const Color(0xff171c26);



  static const Map<String,Color> kNoteColorsMap = {
    "white": Colors.white,
    "lightRed":Color(0xFFF28C82),
    "lightOrange":Color(0xFFFABD03),
    "lightYellow":Color(0xFFFFF476),
    "blueOne":Color(0xFFA7FEEB),
    "blueTwo":Color(0xFFCBF0F8),
    "blueThree":Color(0xFFAFCBFA),
    "lightGreen":Color(0xFFCDFF90),
    "lightViolet":Color(0xFFD7AEFC),
    "lightPink":Color(0xFFFDCFE9),
    "lightBrown":Color(0xFFE6C9A9),
    "lightGrey":Color(0xFFE9EAEE),
  };


  static List<String> kNoteColors=kNoteColorsMap.keys.toList();
}