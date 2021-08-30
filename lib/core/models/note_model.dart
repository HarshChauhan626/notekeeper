// @dart=2.9


import 'package:flutter/material.dart';
import 'package:notekeeper/core/utils/colors_list.dart' as color_list;

class NoteModel{
  String notesId;
  String noteTitle;
  String noteData;
  String updateTime;
  String createTime;
  String noteColorName;
  Color noteColor;
  String isPinned;
  String isArchive;
  String tag;
  
  NoteModel({
    this.notesId,
    this.noteTitle,
    this.noteData,
    this.updateTime,
    this.createTime,
    this.noteColor,
    this.isPinned,
    this.isArchive,
    this.tag
  });
  
  NoteModel.fromJson(Map<String,dynamic> noteMap){
    notesId=noteMap['notesId'];
    noteTitle=noteMap['noteTitle'];
    noteData=noteMap['noteData'];
    updateTime=noteMap['updateTime'];
    createTime=noteMap['createTime'];
    noteColorName=noteMap['noteColor'];
    noteColor=getColor(noteMap['noteColor']);
    isPinned=noteMap['isPinned'];
    isArchive=noteMap['isArchive'];
    tag=noteMap['tag'];
  }
  
  
  Color getColor(String color){
    Color noteColor=color=="default"?color_list.appbackgroundColorDark:color_list.kNoteColorsMap[color];
    return noteColor;
  }

}



