// @dart=2.9

import 'package:notekeeper/core/helper/notes_db_helper.dart';
import 'package:notekeeper/core/service_locator.dart';
import 'package:notekeeper/main.dart';
import 'package:notekeeper/core/utils/colors_list.dart';
import 'package:flutter/material.dart';
import 'package:notekeeper/ui/screens/add_edit_screen/add_edit_view_model.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:notekeeper/core/utils/textstyle_list.dart';

class AddNoteScreen extends StatefulWidget {
  AddNoteScreen({Key key});

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen>
    with SingleTickerProviderStateMixin {
  AddNoteViewModel addViewModel = serviceLocator.get<AddNoteViewModel>();
  TabController tabController;

  List<bool> isSelected = [false, false, false];

  var uuid;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    uuid = Uuid();
    addViewModel.setUpEditingController();
    tabController = TabController(initialIndex: 0, length: 5, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    //addViewModel.dispose();
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ChangeNotifierProvider(
        create: (context) => addViewModel,
        child: Consumer<AddNoteViewModel>(
          builder: (context, model, child) => Scaffold(
            backgroundColor: model.noteColor,
            appBar: AppBar(
              backgroundColor: model.noteColor,
              //title: Text("${model.dataMaxLines}"),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.grey,
                ),
                onPressed: () {
                  model.funcSaveNote(uuid);
                  //this.widget.voidCallBack();
                  Navigator.pop(context);
                },
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    model.isPinnedValue == 1
                        ? Icons.push_pin
                        : Icons.push_pin_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    model.changePinnedValue();
                  },
                ),
                IconButton(
                  icon: Icon(
                    model.isArchiveValue == 1
                        ? Icons.archive
                        : Icons.archive_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    model.changeArchiveValue();
                  },
                ),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 10),
                    child: Text(
                      "Save",
                      style: CustomTextStyle.greyContentStyle,
                    ),
                  ),
                  onTap: () {
                    model.funcSaveNote(uuid);
                    //this.widget.voidCallBack();
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
                      constraints: BoxConstraints(maxHeight: 60),
                      child: TextField(
                        controller: model.noteTitleEditingController,
                        maxLines: 2,
                        style: TextStyle(fontSize: 30, color: Colors.white),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Title",
                            hintStyle: TextStyle(color: Colors.grey),
                            fillColor: model.noteColor),
                      ),
                    ),
                    Container(
                      height: 30,
                      alignment: Alignment.centerLeft,
                      color: model.noteColor,
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
                        style: TextStyle(
                            color: Colors.white,
                          fontWeight: isSelected[0]==true?FontWeight.bold:FontWeight.normal,
                          fontStyle: isSelected[1]==true?FontStyle.italic:FontStyle.normal,
                          
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          focusColor: model.noteColor,
                          hoverColor: model.noteColor,
                          border: InputBorder.none,
                          filled: true,
                          fillColor: model.noteColor,
                          hintText: 'Take a note...',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    Container(
                      //color: Colors.red,
                      height: 100,
                    )
                  ],
                ),
              ),
            ),
            /*bottomNavigationBar: Container(
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
            ),*/
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                    color: ColorList.containerColor,
                    //color: Colors.white,
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.width / 20)),
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              backgroundColor:
                                  ColorList.appbackgroundColorDark,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(30),
                                ),
                              ),
                              builder: (context) {
                                return StatefulBuilder(
                                  builder: (BuildContext context,StateSetter setState){
                                    return Container(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              ToggleButtons(
                                                children: <Widget>[
                                                  Icon(Icons.format_bold,color: Colors.white,),
                                                  Icon(Icons.format_italic,color: Colors.white,),
                                                  Icon(Icons.link,color: Colors.white,),
                                                ],
                                                isSelected: isSelected,
                                                onPressed: (int index) {
                                                  setState(() {
                                                    isSelected[index] =
                                                    !isSelected[index];
                                                  });
                                                },
                                                selectedColor: Colors.blue,
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                );
                              });
                        },
                        icon: Icon(
                          Icons.font_download_outlined,
                          color: Colors.white,
                        )),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.wallpaper,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        {
                          showModalBottomSheet(
                              context: context,
                              backgroundColor:
                                  ColorList.appbackgroundColorDark,
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
                                        height: 50,
                                        color: Colors.black,
                                        child: TabBar(
                                          isScrollable: true,
                                          controller: tabController,
                                          tabs: [
                                            Text(
                                              "Simple",
                                              style: CustomTextStyle
                                                  .whiteContentStyle,
                                            ),
                                            Text(
                                              "Simple",
                                              style: CustomTextStyle
                                                  .whiteContentStyle,
                                            ),
                                            Text(
                                              "Simple",
                                              style: CustomTextStyle
                                                  .whiteContentStyle,
                                            ),
                                            Text(
                                              "Simple",
                                              style: CustomTextStyle
                                                  .whiteContentStyle,
                                            ),
                                            Text(
                                              "Simple",
                                              style: CustomTextStyle
                                                  .whiteContentStyle,
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 300,
                                        child: TabBarView(
                                            controller: tabController,
                                            children: [
                                              Container(
                                                  height: 300,
                                                  color: ColorList
                                                      .appbackgroundColorDark,
                                                  child: colorContainerList(
                                                      model)),
                                              Container(
                                                  height: 300,
                                                  color: ColorList
                                                      .appbackgroundColorDark,
                                                  child: colorContainerList(
                                                      model)),
                                              Container(
                                                  height: 300,
                                                  color: ColorList
                                                      .appbackgroundColorDark,
                                                  child: colorContainerList(
                                                      model)),
                                              Container(
                                                  height: 300,
                                                  color: ColorList
                                                      .appbackgroundColorDark,
                                                  child: colorContainerList(
                                                      model)),
                                              Container(
                                                  height: 300,
                                                  color: ColorList
                                                      .appbackgroundColorDark,
                                                  child: colorContainerList(
                                                      model)),
                                            ]),
                                      )
                                    ],
                                  ),
                                );
                              });
                        }
                      },
                      icon: Icon(
                        Icons.wallpaper,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.wallpaper,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.wallpaper,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget colorContainerList(AddNoteViewModel model) {
    return GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        scrollDirection: Axis.vertical,
        itemCount: ColorList.kNoteColors.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              model.changeNoteColor(index);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 20,
                  width: 20,
                  color:
                      ColorList.kNoteColorsMap[ColorList.kNoteColors[index]],
                ),
              ),
            ),
          );
        });
  }
}
