// @dart=2.9

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notekeeper/helper/notes_db_helper.dart';
import 'package:notekeeper/screens/add_note_screen.dart';
import 'package:notekeeper/screens/edit_note_screen.dart';
import 'package:notekeeper/screens/filter_screen.dart';
import 'package:notekeeper/utils/colors_list.dart' as color_list;
import 'package:notekeeper/widgets/custom_fab_widget.dart';
import 'package:notekeeper/widgets/note_grid_card.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notekeeper/utils/textstyle_list.dart' as text_style;
import 'package:animations/animations.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final transitionType = ContainerTransitionType.fade;

  DBHelper dbHelper;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _searchEditingController=TextEditingController();
  bool isGrid=true;
  
  
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper=DBHelper(notesTableName: 'notesTable');
  }

  void onPopping(){
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Container(
        width: 240,
        child: Drawer(
          child: Container(
            color: color_list.containerColor,
            child: ListView(
              children: [
                DrawerHeader(
                  child: Container(
                    color: Colors.redAccent,
                  ),
                ),
                ListTile(
                  title: Text("Notes",style: text_style.whiteContentStyle,),
                ),
                ListTile(
                    title:Text("Todos",style:text_style.whiteContentStyle)
                ),
                ListTile(
                  title: Text("Reminders",style: text_style.whiteContentStyle,),
                )
              ],
            ),
          ),
        ),
      ),
      backgroundColor: color_list.appbackgroundColorDark,
      appBar: AppBar(
        title: Text("Notekeeper"),
        leading: Text(""),
        centerTitle: true,
        backgroundColor: color_list.appbackgroundColorDark,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 10,
              width: double.infinity,
              color: color_list.appbackgroundColorDark,
            ),
            Container(
              height: MediaQuery.of(context).size.height/14,
              width: MediaQuery.of(context).size.width-30,
              decoration: BoxDecoration(
                color: color_list.containerColor,
                //color: Colors.white,
                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width/12)
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:18.0),
                    child: InkWell(
                        child: SvgPicture.asset('assets/custom_drawer_icon.svg',color: Colors.white,),
                      onTap: (){
                          scaffoldKey.currentState.openDrawer();
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 2,vertical: 2),
                    width: 180,
                    child: TextField(
                      controller: _searchEditingController,
                      onChanged: (text){
                        setState(() {

                        });
                      },
                      style: text_style.whiteContentStyle,
                      cursorColor: Colors.blueGrey,
                      decoration: InputDecoration(
                        hintStyle:text_style.greyContentStyle,
                        hintText: 'Search',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right:8.0),
                    child: InkWell(
                      child: isGrid?SvgPicture.asset('assets/grid_list_icon.svg',color: Colors.white,):SvgPicture.asset('assets/list_view_icon.svg',color: Colors.white,),
                      onTap: (){
                        setState(() {
                          isGrid=!isGrid;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:10.0),
                    child: InkWell(
                      child: Icon(Icons.filter_list,color: Colors.white,),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>FilterScreen()));
                      },
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(10),
              child: FutureBuilder<List<Map<String,dynamic>>>(
                future: _searchEditingController.text.length==0?dbHelper.getListOfNotes():dbHelper.getSearchList(
                    searchText: "'%${_searchEditingController.text}%'",
                    sortArgument: "noteTitle"
                ),
                builder: (BuildContext context,AsyncSnapshot snapshot){
                  if(snapshot.connectionState==ConnectionState.done){
                    if(snapshot.hasData){
                      return isGrid?_buildGrid(snapshot.data):_buildList(snapshot.data);
                    }
                    else{
                      return Center(child: Text("Save something"),);
                    }
                  }
                  return Center(child: CircularProgressIndicator());
                }
              )
            )
          ],
        ),
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context)=>AddNoteScreen(
                dbHelper: dbHelper,
                callback: (){
                  setState(() {

                  });
                },
          )
          ));
          setState(() {

          });
        },
        child: Icon(Icons.add,size: 40,),
      ),*/
      floatingActionButton: CustomFABWidget(
        dbHelper: dbHelper,
        transitionType: transitionType,
        callback:(){
          setState(() {
          });
        },
      ),
    );
  }



  Widget _buildGrid(List<Map<String,dynamic>> data){
    return StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: data.length,
        itemBuilder:(context,index){
          print(data[0]);
          /*return GestureDetector(
            onTap: ()async{
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EditNoteScreen(
                  dbHelper: dbHelper,
                  note: data[index],
                ),
              ));

              setState(() {
              });

            },
            child: NoteGridCard(
              index:index,
              note:data[index]
            ),
          );*/
          return OpenContainer(
            transitionType: transitionType,
            transitionDuration: Duration(milliseconds:400),
            openBuilder: (context, _) {
              return EditNoteScreen(note: data[index],dbHelper: dbHelper);
            },
            closedColor: color_list.appbackgroundColorDark,
            closedBuilder: (context, VoidCallback openContainer) => NoteGridCard(
              index: index,
              onClicked: openContainer,
              note: data[index],
            ),
          );
        },
        staggeredTileBuilder: (index)=>StaggeredTile.fit(2)
    );
  }


  Widget _buildList(List<Map<String,dynamic>> data){
    return ListView.builder(itemCount: data.length,itemBuilder: (context,index){
      return Card(
        child: Container(
          color: color_list.containerColor,
          child: Column(
            children: [
              Text(data[index]['noteTitle'],style: text_style.whiteContentStyle,),
              Text(data[index]['noteData'],style: text_style.whiteContentStyle,)
            ],
          ),
        ),
      );
    });
  }


}








