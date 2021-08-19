import 'package:flutter/material.dart';
import 'package:notekeeper/utils/colors_list.dart' as color_list;
import 'package:notekeeper/utils/textstyle_list.dart' as textstyle_list;

class NotesSearchScreen extends StatefulWidget {
  const NotesSearchScreen({Key? key}) : super(key: key);

  @override
  _NotesSearchScreenState createState() => _NotesSearchScreenState();
}

class _NotesSearchScreenState extends State<NotesSearchScreen> {

  String noteColorName="all";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color_list.appbackgroundColorDark,
      appBar: AppBar(

      ),
      body: filtersView(),
    );
  }



  Widget filtersView(){
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
                            setState(() {
                              //noteColor=color_list.kNoteColorsMap[color_list.kNoteColors[index]];
                              noteColorName=color_list.kNoteColors[index];
                            });
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


