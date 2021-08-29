// @dart=2.9

import 'package:notekeeper/core/helper/notes_db_helper.dart';
import 'package:notekeeper/main.dart';
import 'package:notekeeper/core/utils/colors_list.dart' as color_list;
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:notekeeper/core/utils/textstyle_list.dart' as text_style;

class AddNoteScreen extends StatefulWidget {
  AddNoteScreen({Key key});

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {

  TextEditingController _noteTitleEditingController=TextEditingController();
  TextEditingController _noteDataEditingController=TextEditingController();


  DBHelper dbHelper=getItInstance.get<DBHelper>();


  int titleMaxLines=10;
  int dataMaxLines=1000;

  int isPinnedValue=0;
  int isArchiveValue=0;

  Color noteColor=color_list.appbackgroundColorDark;
  String noteColorName="default";

  RegExp regExp=RegExp(r'^#');

  var uuid;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    uuid=Uuid();
    _noteDataEditingController.addListener(() async{
      //print(_noteDataEditingController.text);
      if(regExp.hasMatch(_noteDataEditingController.text)){
        print("match found");
        await Future.delayed(Duration(seconds: 2));
        setState(() {
          _noteDataEditingController.text=_noteDataEditingController.text.replaceAll("#", "");
        });
      }
    });
  }


  @override
  void dispose() {
    // TODO: implement dispose
    _noteDataEditingController.dispose();
    _noteTitleEditingController.dispose();
    super.dispose();
  }

  void func(){
    _noteDataEditingController.addListener(() {
      print(_noteDataEditingController.text);
      if(regExp.hasMatch(_noteDataEditingController.text)){
        print("match found");
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: noteColor,
        appBar: AppBar(
          backgroundColor: noteColor,
          title: Text(""),
          leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.grey,),
            onPressed: (){
              funcSaveNote();
            },
          ),
          actions: [
            IconButton(
              icon: Icon(isPinnedValue==1?Icons.push_pin:Icons.push_pin_outlined,color: Colors.grey,),
              onPressed: (){
                if(isPinnedValue==1){
                  setState(() {
                    isPinnedValue=0;
                  });
                }
                else{
                  setState(() {
                    isPinnedValue=1;
                  });
                }
              },
            ),
            IconButton(
              icon: Icon(isArchiveValue==1?Icons.archive:Icons.archive_outlined,color: Colors.grey,),
              onPressed: (){
                if(isArchiveValue==1){
                  setState(() {
                    isArchiveValue=0;
                  });
                }
                else{
                  setState(() {
                    isArchiveValue=1;
                  });
                }
              },
            ),
            InkWell(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 10),
                child: Text("Save",style: text_style.greyContentStyle,),
              ),
              onTap: (){
                funcSaveNote();
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
                        fillColor: noteColor
                    ),
                  ),
                ),
                Container(
                  height: 30,
                  alignment: Alignment.centerLeft,
                  color: noteColor,
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
                      focusColor: noteColor,
                      hoverColor: noteColor,
                      border: InputBorder.none,
                      filled: true,
                      fillColor: noteColor,
                      hintText: 'Take a note...',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                Container(
                  color: Colors.red,
                  height: 100,
                )
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


  void funcSaveNote()async{
    int untitledCount=await dbHelper.getUntitledCount();
    if((_noteDataEditingController.text.length>=1) && (_noteTitleEditingController.text.length==0)){
      dbHelper.add(uuid.v1(),"Untitled ${untitledCount+1}",_noteDataEditingController.text,DateTime.now().millisecondsSinceEpoch,DateTime.now().millisecondsSinceEpoch,noteColorName,isPinnedValue,isArchiveValue,"none");
    }
    if((_noteDataEditingController.text.length>=1) && (_noteTitleEditingController.text.length!=0)){
      dbHelper.add(uuid.v1(),_noteTitleEditingController.text, _noteDataEditingController.text,DateTime.now().millisecondsSinceEpoch,DateTime.now().millisecondsSinceEpoch,noteColorName,isPinnedValue,isArchiveValue,"none");
    }
    Navigator.pop(context);
  }






  Future<bool> _willPopCallback() async {
    // await showDialog or Show add banners or whatever
    // then
    dbHelper.add(uuid.v1(),_noteTitleEditingController.text,_noteDataEditingController.text, DateTime.now().millisecondsSinceEpoch,DateTime.now().millisecondsSinceEpoch,noteColor.value.toString(),isPinnedValue, isArchiveValue,"none");
    return true; // return true if the route to be popped
  }
}







