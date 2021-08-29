// @dart=2.9

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notekeeper/core/service_locator.dart';

import 'package:notekeeper/core/widgets/custom_fab_widget.dart';
import 'package:notekeeper/core/widgets/list_view/grid_list.dart';

import 'package:notekeeper/main.dart';
import 'package:notekeeper/ui/screens/home_screen/home_view_model.dart';
import 'package:notekeeper/core/utils/colors_list.dart' as color_list;

import 'package:flutter_svg/flutter_svg.dart';
import 'package:notekeeper/core/utils/textstyle_list.dart' as text_style;
import 'package:animations/animations.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final transitionType = ContainerTransitionType.fade;

  var scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _searchEditingController=TextEditingController();
  bool isGrid=true;

  HomeViewModel homeViewModel=serviceLocator.get<HomeViewModel>();
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeViewModel.fetchInitialList();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    //homeViewModel.fetchInitialList();
  }

  void onPopping(){
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    print(homeViewModel.notesList.length);
    return ChangeNotifierProvider(
      create:(context)=>homeViewModel,
      child: Consumer<HomeViewModel>(
        builder: (context,model,child)=>Scaffold(
          key: scaffoldKey,
          drawer:getDrawer(),
          backgroundColor: color_list.appbackgroundColorDark,
          appBar: getAppBar(),
          body: getBody(homeViewModel: model),
          floatingActionButton: CustomFABWidget(
            callback: ()async{
              await model.refreshNoteList();
            },
          ),
        ),
      ),
    );
  }


  Widget getDrawer(){
    return Container(
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
    );
  }

  Widget getAppBar(){
    return AppBar(
      title: Text("Notekeeper"),
      leading: Text(""),
      centerTitle: true,
      backgroundColor: color_list.appbackgroundColorDark,
    );
  }

  Widget getBody({HomeViewModel homeViewModel}){
    return SingleChildScrollView(
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
                    onChanged: (text)async{
                      await homeViewModel.fetchInitialList();
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
                    child: homeViewModel.isGrid?SvgPicture.asset('assets/grid_list_icon.svg',color: Colors.white,):SvgPicture.asset('assets/list_view_icon.svg',color: Colors.white,),
                    onTap: ()async{
                      homeViewModel.toggleGrid();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:10.0),
                  child: InkWell(
                    child: Icon(Icons.filter_list,color: Colors.white,),
                    /*onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>NotesSearchScreen()));
                      },*/
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
            child: NotesGridList(
              noteList:homeViewModel.notesList
            ),
          )
        ],
      ),
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








