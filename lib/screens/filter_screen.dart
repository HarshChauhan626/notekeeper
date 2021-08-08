import 'package:flutter/material.dart';
import 'package:notekeeper/utils/colors_list.dart' as color_list;

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {

  String noteColorName="all";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color_list.appbackgroundColorDark,
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height/3,
            child: Column(
              children: [
                Container(
                  height: 20,
                  color: Colors.white,
                ),
                Container(
                  child:Row(
                    children: [
                      for(int index=0;index<3;index++)
                        GestureDetector(
                          child: Container(
                            width: MediaQuery.of(context).size.width/3,
                            color: Colors.lightBlue,
                            child: Column(
                              children: [
                                Text(""),
                                Icon(Icons.list_alt_outlined),
                                Text("Lists")
                              ],
                            ),
                          ),
                        )
                    ],
                  ),
                )
              ],
            ),
          ),
          AnimatedContainer(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Labels"),
                    Text("See more")
                  ],
                ),
                Wrap(
                  children: [
                    for(int index=0;index<3;index++)
                      Container(
                        child: Column(
                          children: [
                            Icon(Icons.label),
                            Text("LabelName")
                          ],
                        ),
                      )
                  ],
                )
              ],
            ),
            duration: Duration(milliseconds: 700),
          ),
          Container(
            height: MediaQuery.of(context).size.height/3,
          ),
          Container(
            height: MediaQuery.of(context).size.height/3,
            child: Wrap(
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
                          borderRadius: BorderRadius.circular(34),
                          child: Container(
                            height: 34,
                            width: 34,
                            color: color_list.kNoteColorsMap[color_list.kNoteColors[index]],
                          ),
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}


