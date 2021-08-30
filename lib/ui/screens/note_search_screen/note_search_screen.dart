// @dart=2.9

import 'package:flutter/material.dart';


import 'package:notekeeper/core/helper/notes_db_helper.dart';
import 'package:notekeeper/core/utils/colors_list.dart' as color_list;
import 'package:notekeeper/core/utils/textstyle_list.dart' as textstyle_list;
import 'package:notekeeper/core/service_locator.dart';
import 'package:notekeeper/core/widgets/list_view/grid_list.dart';
import 'package:notekeeper/ui/screens/note_search_screen/note_search_view_model.dart';
import 'package:provider/provider.dart';




class NoteSearchScreen extends StatelessWidget {

  NoteSearchViewModel noteSearchViewModel=serviceLocator.get<NoteSearchViewModel>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ChangeNotifierProvider(
        create: (context)=>noteSearchViewModel,
        child: Scaffold(
          backgroundColor: color_list.appbackgroundColorDark,
          appBar: AppBar(
            backgroundColor: color_list.containerColor,
            title: Container(
              child: Consumer<NoteSearchViewModel>(
                builder: (context,model,child)=>TextField(
                  autofocus: true,
                  onChanged: (text){
                    model.searchList(text);
                  },
                  style: textstyle_list.whiteContentStyle,
                  cursorColor: Colors.blueGrey,
                  decoration: InputDecoration(
                    hintStyle:textstyle_list.greyContentStyle,
                    hintText: 'Search',
                    border: InputBorder.none,
                  ),
                )
              )
            ),
          ),
          body: Consumer<NoteSearchViewModel>(
            builder: (context,model,child){
              return model.showResult?NotesGridList(noteList:model.notesList):filtersView(context);
            },
          ),
        ),
      )
    );
  }



  Widget filtersView(BuildContext context){
    return ListView(
      children: [
        Container(
            child: Wrap(
              children: [
                for(int index=0;index<5;index++)
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 90,
                        width: MediaQuery.of(context).size.width/3-16,
                        color: Colors.lightBlue,
                        child: Column(
                          children: [
                            Text(""),
                            Icon(Icons.list_alt_outlined),
                            Text("Lists")
                          ],
                        ),
                      ),
                    ),
                  )
              ],
            )
        ),
        AnimatedContainer(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Labels",style: textstyle_list.whiteContentStyle,),
                    Text("See more",style: textstyle_list.whiteContentStyle,)
                  ],
                ),
              ),
              Wrap(
                direction: Axis.horizontal,
                runAlignment: WrapAlignment.start,
                spacing: 20,
                children: [
                  for(int index=0;index<5;index++)
                    Container(
                      color: Colors.red,
                      child: Column(
                        children: [
                          Icon(Icons.label,color: Colors.white,),
                          Text("LabelName",style: textstyle_list.whiteContentStyle,)
                        ],
                      ),
                    )
                ],
              )
            ],
          ),
          duration: Duration(milliseconds: 700),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: MediaQuery.of(context).size.height/3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Colors",style: textstyle_list.whiteContentStyle,),
                Wrap(
                  children: [
                    for(int index=0;index<color_list.kNoteColorsMap.length;index++)
                      GestureDetector(
                        child: GestureDetector(
                          onTap: (){
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 4),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: Container(
                                height: 40,
                                width: 40,
                                color: color_list.kNoteColorsMap[color_list.kNoteColors[index]],
                              ),
                            ),
                          ),
                        ),
                      )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}


