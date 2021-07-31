// @dart=2.9

import 'package:notekeeper/helper/notes_db_helper.dart';
import 'package:notekeeper/utils/colors_list.dart' as color_list;
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class EditNoteScreen extends StatefulWidget {
  DBHelper dbHelper;
  Map<String,dynamic> note;
  EditNoteScreen({this.dbHelper,this.note});

  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {

  TextEditingController _noteTitleEditingController=TextEditingController();
  TextEditingController _noteDataEditingController=TextEditingController();

  int titleMaxLines=10;
  int dataMaxLines=1000;

  int isPinned;
  int isArchive;
  String color;
  int result;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //uuid=widget.note['notesId'];
    isPinned=widget.note['isPinned'];
    isArchive=widget.note['isArchive'];
    _noteTitleEditingController.text=widget.note['noteTitle'];
    _noteDataEditingController.text=widget.note['noteData'];
    color=widget.note['color'];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color_list.appbackgroundColorDark,
      appBar: AppBar(
        backgroundColor: color_list.appbackgroundColorDark,
        title: Text(""),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: ()async{
            widget.dbHelper.updateNote(widget.note['notesId'],_noteTitleEditingController.text, _noteDataEditingController.text,DateTime.now().millisecondsSinceEpoch,color,isPinned,isArchive).whenComplete(() => Navigator.pop(context));
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.push_pin_outlined),
            onPressed: (){},
          ),
          IconButton(
            icon: Icon(Icons.archive_outlined),
            onPressed: (){},
          ),
          InkWell(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 10),
              child: Text("Save"),
            ),
            onTap: ()async{
              result=await widget.dbHelper.updateNote(widget.note['notesId'],_noteTitleEditingController.text, _noteDataEditingController.text,DateTime.now().millisecondsSinceEpoch,color,isPinned,isArchive);
              print(result);
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: 60
                ),
                child: TextField(
                  controller: _noteTitleEditingController,
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 30,
                      color:Colors.white
                  ),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Title",
                      hintStyle: TextStyle(color: Colors.grey),
                      fillColor: color_list.appbackgroundColorDark
                  ),
                ),
              ),
              Container(
                height: 30,
                alignment: Alignment.centerLeft,
                color: color_list.appbackgroundColorDark,
                width: double.infinity,
                child: Text("Sun,10:24 | 4096 characters",style: TextStyle(color: Colors.grey),),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height-300,
                ),
                child: TextField(
                  controller: _noteDataEditingController,
                  maxLines: null,
                  style: TextStyle(
                      color: Colors.white
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    focusColor: color_list.appbackgroundColorDark,
                    hoverColor: color_list.appbackgroundColorDark,
                    border: InputBorder.none,
                    filled: true,
                    fillColor: color_list.appbackgroundColorDark,
                    hintText: 'Take a note...',
                    hintStyle: TextStyle(color: Colors.grey),

                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        color: color_list.appbackgroundColorDark,
        padding: const EdgeInsets.symmetric(horizontal: 9),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.add_box),
              color: Colors.grey,
              onPressed: ()=>{},
            ),
            Text('Edited at ',style: TextStyle(color: Colors.white),),
            IconButton(
              icon: const Icon(Icons.more_vert),
              color: Colors.grey,
              onPressed: () => {

              },
            ),
          ],
        ),
      ),
    );
  }
}







