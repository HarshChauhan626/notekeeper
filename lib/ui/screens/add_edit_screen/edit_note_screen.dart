// @dart=2.9

import 'package:notekeeper/core/helper/notes_db_helper.dart';
import 'package:notekeeper/core/service_locator.dart';
import 'package:notekeeper/main.dart';
import 'package:notekeeper/core/utils/colors_list.dart' as color_list;
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';



class EditNoteScreen extends StatefulWidget {
  Map<String,dynamic> note;
  EditNoteScreen({this.note});

  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {

  DBHelper dbHelper;


  TextEditingController _noteTitleEditingController=TextEditingController();
  TextEditingController _noteDataEditingController=TextEditingController();

  int titleMaxLines=10;
  int dataMaxLines=1000;

  int isPinned;
  int isArchive;
  String noteColorName;
  Color noteColor;
  int result;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper=serviceLocator<DBHelper>();
    //uuid=widget.note['notesId'];
    isPinned=widget.note['isPinned'];
    isArchive=widget.note['isArchive'];
    _noteTitleEditingController.text=widget.note['noteTitle'];
    _noteDataEditingController.text=widget.note['noteData'];
    noteColorName=widget.note['noteColor'];
    print(noteColorName);
    noteColor=widget.note['noteColor']=="default"?color_list.appbackgroundColorDark:color_list.kNoteColorsMap[widget.note['noteColor']];
  }


  @override
  Widget build(BuildContext context) {
    print(widget.note['noteColor']);
    return SafeArea(
      child: Scaffold(
        //backgroundColor: color_list.appbackgroundColorDark,
        backgroundColor: noteColor,
        appBar: AppBar(
          //backgroundColor: color_list.appbackgroundColorDark,
          backgroundColor: noteColor,
          title: Text(""),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: ()async{
              dbHelper.updateNote(widget.note['notesId'],_noteTitleEditingController.text, _noteDataEditingController.text,DateTime.now().millisecondsSinceEpoch,noteColorName,isPinned,isArchive,"none").whenComplete(() => Navigator.pop(context));
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
                result=await dbHelper.updateNote(widget.note['notesId'],_noteTitleEditingController.text, _noteDataEditingController.text,DateTime.now().millisecondsSinceEpoch,noteColorName,isPinned,isArchive,"none");
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
                        fillColor: color_list.kNoteColorsMap[widget.note['noteColor']]
                    ),
                  ),
                ),
                Container(
                  height: 30,
                  alignment: Alignment.centerLeft,
                  color: color_list.kNoteColorsMap[widget.note['noteColor']],
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
                      fillColor: color_list.kNoteColorsMap[widget.note['noteColor']],
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
          color: noteColor,
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
                  showModalBottomSheet(
                      context: context,
                      backgroundColor: color_list.appbackgroundColorDark,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30),
                        ),
                      ),
                      builder: (context){
                        return Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                  height: 40,
                                  color: color_list.appbackgroundColorDark,
                                  child:colorContainerList()
                              ),
                              ListTile(
                                leading: new Icon(Icons.photo,color: Colors.white,),
                                title: new Text(
                                  'Photo',
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                leading: new Icon(Icons.music_note,color: Colors.white,),
                                title: new Text(
                                  'Music',
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      })
                },
              ),
            ],
          ),
        ),
      ),
    );
  }



  Widget colorContainerList(){
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: color_list.kNoteColors.length,
        itemBuilder: (context,index){
          return GestureDetector(
            onTap: (){
              setState(() {
                noteColor=color_list.kNoteColorsMap[color_list.kNoteColors[index]];
                noteColorName=color_list.kNoteColors[index];
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 4),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(34),
                child: Container(
                  height: 34,
                  width: 34,
                  color: color_list.kNoteColorsMap[color_list.kNoteColors[index]],
                ),
              ),
            ),
          );
        });
  }


}







