// @dart=2.9

import 'package:notekeeper/core/helper/notes_db_helper.dart';
import 'package:notekeeper/core/models/note_model.dart';
import 'package:notekeeper/core/service_locator.dart';
import 'package:notekeeper/main.dart';
import 'package:notekeeper/core/utils/colors_list.dart' as color_list;
import 'package:flutter/material.dart';
import 'package:notekeeper/ui/screens/add_edit_screen/edit_view_model.dart';
import 'package:notekeeper/ui/screens/home_screen/home_view_model.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class EditNoteScreen extends StatefulWidget {
  NoteModel note;
  VoidCallback voidCallBack;
  EditNoteScreen({@required this.note, @required this.voidCallBack});

  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  EditNoteViewModel editNoteViewModel = serviceLocator.get<EditNoteViewModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    editNoteViewModel.initData(widget.note);
    editNoteViewModel.setUpEditingController();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("this is called");
  }

  @override
  Widget build(BuildContext context) {
    //print(widget.note['noteColor']);
    return SafeArea(
      child: ChangeNotifierProvider(
        create: (context) => editNoteViewModel,
        child: Consumer<EditNoteViewModel>(
          builder: (context, model, child) => Scaffold(
            //backgroundColor: color_list.appbackgroundColorDark,
            appBar: AppBar(
              //backgroundColor: color_list.appbackgroundColorDark,
              backgroundColor:
                  Provider.of<EditNoteViewModel>(context, listen: true)
                      .noteColor,
              title: Text(""),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () async {
                  Provider.of<EditNoteViewModel>(context)
                      .funcSaveNote(widget.note.notesId);
                  //dbHelper.updateNote(widget.note.notesId,_noteTitleEditingController.text, _noteDataEditingController.text,DateTime.now().millisecondsSinceEpoch,noteColorName,isPinned,isArchive,"none").whenComplete(() => Navigator.pop(context));
                },
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.push_pin_outlined),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.archive_outlined),
                  onPressed: () {},
                ),
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 10),
                    child: Text("Save"),
                  ),
                  onTap: () async {
                    print("FUnction on tap save running");
                    await model.funcSaveNote(this.widget.note.notesId);
                    //Provider.of<HomeViewModel>(context,listen: false).refreshNoteList();
                    //this.widget.voidCallBack();
                    Navigator.pop(context);
                    // //print(result
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
                      constraints: BoxConstraints(maxHeight: 60),
                      child: TextField(
                        controller: model.noteTitleEditingController,
                        maxLines: 2,
                        style: TextStyle(fontSize: 30, color: Colors.white),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Title",
                          hintStyle: TextStyle(color: Colors.grey),
                          //fillColor: color_list.kNoteColorsMap[widget.note['noteColor']]
                        ),
                      ),
                    ),
                    Container(
                      height: 30,
                      alignment: Alignment.centerLeft,
                      //color: color_list.kNoteColorsMap[widget.note['noteColor']],
                      width: double.infinity,
                      child: Text(
                        "Sun,10:24 | 4096 characters",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height - 300,
                      ),
                      child: TextField(
                        controller: model.noteDataEditingController,
                        maxLines: null,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          focusColor: color_list.appbackgroundColorDark,
                          hoverColor: color_list.appbackgroundColorDark,
                          border: InputBorder.none,
                          filled: true,
                          //fillColor: color_list.kNoteColorsMap[widget.note['noteColor']],
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
              color: model.noteColor,
              padding: const EdgeInsets.symmetric(horizontal: 9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.add_box),
                    color: Colors.grey,
                    onPressed: () => {},
                  ),
                  Text(
                    'Edited at ',
                    style: TextStyle(color: Colors.white),
                  ),
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
                          builder: (context) {
                            return Container(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                      height: 40,
                                      color: color_list.appbackgroundColorDark,
                                      child: colorContainerList(model)),
                                  ListTile(
                                    leading: new Icon(
                                      Icons.photo,
                                      color: Colors.white,
                                    ),
                                    title: new Text(
                                      'Photo',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ListTile(
                                    leading: new Icon(
                                      Icons.music_note,
                                      color: Colors.white,
                                    ),
                                    title: new Text(
                                      'Music',
                                      style: TextStyle(color: Colors.white),
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
        ),
      ),
    );
  }

  Widget colorContainerList(EditNoteViewModel model) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: color_list.kNoteColors.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              model.changeNoteColor(index);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(34),
                child: Container(
                  height: 34,
                  width: 34,
                  color:
                      color_list.kNoteColorsMap[color_list.kNoteColors[index]],
                ),
              ),
            ),
          );
        });
  }
}
