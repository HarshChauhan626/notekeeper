// @dart=2.9

import 'package:notekeeper/core/helper/notes_db_helper.dart';
import 'package:notekeeper/core/models/note_model.dart';
import 'package:notekeeper/core/service_locator.dart';
import 'package:notekeeper/main.dart';
import 'package:notekeeper/core/utils/colors_list.dart';
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
            backgroundColor: model.noteColor,
            appBar: AppBar(
              //backgroundColor: ColorList.appbackgroundColorDark,
              backgroundColor:model.noteColor,
              title: Text(""),
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () async {
                  model.funcSaveNote(this.widget.note.notesId);
                  Navigator.pop(context);
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
                        style: TextStyle(fontSize: 30, color: ColorList.tertiaryColor),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: model.noteColor,
                          hoverColor: model.noteColor,
                          hintText: "Title",
                          hintStyle: TextStyle(color: Colors.grey),
                          //fillColor: ColorList.kNoteColorsMap[widget.note['noteColor']]
                        ),
                      ),
                    ),
                    Container(
                      height: 30,
                      alignment: Alignment.centerLeft,
                      //color: ColorList.kNoteColorsMap[widget.note['noteColor']],
                      width: double.infinity,
                      color: model.noteColor,
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
                        style: TextStyle(color: ColorList.tertiaryColor),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          focusColor: model.noteColor,
                          hoverColor: model.noteColor,
                          border: InputBorder.none,
                          filled: true,
                          //fillColor: ColorList.kNoteColorsMap[widget.note['noteColor']],
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
                    style: TextStyle(color: ColorList.tertiaryColor),
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    color: Colors.grey,
                    onPressed: () => {
                      showModalBottomSheet(
                          context: context,
                          backgroundColor: ColorList.appbackgroundColorDark,
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
                                      color: ColorList.appbackgroundColorDark,
                                      child: colorContainerList(model)),
                                  ListTile(
                                    leading: new Icon(
                                      Icons.photo,
                                      color: ColorList.tertiaryColor,
                                    ),
                                    title: new Text(
                                      'Photo',
                                      style: TextStyle(color: ColorList.tertiaryColor),
                                    ),
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ListTile(
                                    leading: new Icon(
                                      Icons.music_note,
                                      color: ColorList.tertiaryColor,
                                    ),
                                    title: new Text(
                                      'Music',
                                      style: TextStyle(color: ColorList.tertiaryColor),
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
        itemCount: ColorList.kNoteColors.length,
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
                      ColorList.kNoteColorsMap[ColorList.kNoteColors[index]],
                ),
              ),
            ),
          );
        });
  }
}
