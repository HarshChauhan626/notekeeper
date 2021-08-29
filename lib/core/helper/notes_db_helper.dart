// @dart=2.9

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' show join;
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart' show getApplicationDocumentsDirectory;



class DBHelper {

  String notesTableName;

  DBHelper({this.notesTableName});



  static Database _db;

  String notesIdField='notesId';
  String noteTitleField='noteTitle';
  String noteDataField='noteData';
  String updateTimeField='updateTime';
  String createTimeField='createTime';
  String colorField='noteColor';
  String isPinnedField='isPinned';
  String isArchiveField='isArchive';
  String tagField='tag';




  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'notekeeperDb.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
  create table $notesTableName ( 
  $notesIdField text,
  $noteTitleField text,
  $noteDataField text,
  $updateTimeField integer,
  $createTimeField integer,
  $colorField text,
  $isPinnedField integer,
  $isArchiveField integer,
  $tagField text
  )
''');
    print('Notes table created');
  }

  void add(
      String notesId,
      String noteTitle,
      String noteData,
      int updateTime,
      int createTime,
      String color,
      int isPinned,
      int isArchive,
      String tag
      ) async {
    var dbClient = await db;
    await dbClient.rawInsert(
        'INSERT INTO $notesTableName($notesIdField,$noteTitleField,$noteDataField,$updateTimeField,$createTimeField,$colorField,$isPinnedField,$isArchiveField,$tagField) VALUES(?,?,?,?,?,?,?,?,?)', [
      notesId,noteTitle,noteData,updateTime,createTime,color,isPinned,isArchive,tag
    ]
    );
    print('Note added');
  }


  Future<int> updateNote(
      String notesId,
      String noteTitle,
      String noteData,
      int updateTime,
      String color,
      int isPinned,
      int isArchive,
      String tag
      ) async {
    print("This is running");
    var dbClient = await db;
    var result=await dbClient.rawUpdate(
        '''
      UPDATE $notesTableName
      SET $noteTitleField=?,$noteDataField=?,$updateTimeField=?,$colorField=?,$isPinnedField=?,$isArchiveField=?,$tagField=?
      WHERE $notesIdField=?
      ''',[
      noteTitle,noteData,updateTime,color,isPinned,isArchive,tag,notesId
    ]
    );
    print('Note Updated');
    return result;
  }

  void updateNoteTitle(
      String noteTitle,String updateTime,String notesId
      )async{
    var dbClient=await db;
    await dbClient.rawUpdate(
      '''
      UPDATE $notesTableName
      SET $noteTitleField=?,$updateTimeField=?
      WHERE $notesIdField=?
      ''',[
        noteTitle,updateTime,notesId
    ]
    );
    print('note title updated');
  }



  void updateNoteData(
      String noteData,String updateTime,String notesId
      )async{
    var dbClient=await db;
    await dbClient.rawUpdate(
        '''
      UPDATE $notesTableName
      SET $noteDataField=?,$updateTimeField=?
      WHERE $notesIdField=?
      ''',[
      noteData,updateTime,notesId
    ]
    );
    print('updated');
  }


  void updateIsPinned(
      int isPinned,String updateTime,String notesId
      )async{
    var dbClient=await db;
    await dbClient.rawUpdate(
        '''
      UPDATE $notesTableName
      SET $isPinnedField=?,$updateTimeField=?
      WHERE $notesIdField=?
      ''',[
      isPinned,updateTime,notesId
    ]
    );
  }

  void updateIsArchive(
      int isArchive,String updateTime,String notesId
      )async{
    var dbClient=await db;
    await dbClient.rawUpdate(
        '''
      UPDATE $notesTableName
      SET $isArchiveField=?,$updateTimeField=?
      WHERE $notesIdField=?
      ''',[
      isArchive,updateTime,notesId
    ]
    );
  }


  Future<List<Map<String,dynamic>>> getListOfNotes()async{
    var dbClient=await db;
    var listOfNotes=await dbClient.rawQuery('''
    SELECT * FROM $notesTableName
    ''');
    print("Retrieving list");
    return listOfNotes;
  }


  Future<List<Map<String,dynamic>>> getSearchList({String searchText,String sortArgument}) async{
    var dbClient=await db;
    var listOfNotes=await dbClient.rawQuery('''
    SELECT * FROM $notesTableName
    WHERE $noteTitleField LIKE $searchText OR $noteDataField LIKE $searchText
    ORDER BY $sortArgument
    ''');
    return listOfNotes;
  }



  Future<int> getUntitledCount() async{
    var dbClient=await db;
    var untitledCount=await dbClient.rawQuery('''
    SELECT COUNT($noteTitleField) as UNTITLEDCOUNT
    FROM $notesTableName
    WHERE $noteTitleField LIKE "untitled%"
    ''');
    return untitledCount[0]["UNTITLEDCOUNT"];
  }




  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}



// For unique id DateTime.now().millisecondsSinceEpoch.remainder(100000).toString();
