// @dart=2.9

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notekeeper/core/service_locator.dart';

import 'package:notekeeper/core/widgets/custom_fab_widget.dart';
import 'package:notekeeper/core/widgets/list_view/grid_list.dart';

import 'package:notekeeper/main.dart';
import 'package:notekeeper/ui/screens/home_screen/home_view_model.dart';
import 'package:notekeeper/core/utils/colors_list.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:notekeeper/core/utils/textstyle_list.dart';
import 'package:animations/animations.dart';
import 'package:notekeeper/ui/screens/note_search_screen/note_search_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final transitionType = ContainerTransitionType.fade;

  var scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _searchEditingController = TextEditingController();
  bool isGrid = true;

  HomeViewModel homeViewModel = serviceLocator.get<HomeViewModel>();

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
    print("This is called in home");
    homeViewModel.refreshNoteList();
  }

  void onPopping() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print(homeViewModel.notesList.length);
    return ChangeNotifierProvider(
      create: (context) => homeViewModel,
      child: Consumer<HomeViewModel>(
        builder: (context, model, child) => SafeArea(
          child: Scaffold(
            key: scaffoldKey,
            drawer: getDrawer(),
            backgroundColor: ColorList.appbackgroundColorDark,
            //appBar: getAppBar(homeViewModel: homeViewModel),
            body: getBody(homeViewModel: model),
            floatingActionButton: CustomFABWidget(),
          ),
        ),
      ),
    );
  }

  Widget getDrawer() {
    return Container(
      width: 240,
      child: Drawer(
        child: Container(
          color: ColorList.containerColor,
          child: ListView(
            children: [
              DrawerHeader(
                child: Container(
                  color: Colors.redAccent,
                ),
              ),
              ListTile(
                title: Text(
                  "Notes",
                  style: CustomTextStyle.whiteContentStyle,
                ),
              ),
              ListTile(
                  title: Text("Todos", style: CustomTextStyle.whiteContentStyle)),
              ListTile(
                title: Text(
                  "Reminders",
                  style: CustomTextStyle.whiteContentStyle,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getAppBar({HomeViewModel homeViewModel}) {
    return Container(
      height: MediaQuery.of(context).size.height / 14,
      width: MediaQuery.of(context).size.width - 30,
      decoration: BoxDecoration(
          color: ColorList.containerColor,
          //color: Colors.white,
          borderRadius:
              BorderRadius.circular(MediaQuery.of(context).size.width / 12)),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: InkWell(
              child: SvgPicture.asset(
                'assets/custom_drawer_icon.svg',
                color: Colors.white,
              ),
              onTap: () {
                scaffoldKey.currentState.openDrawer();
                print("Drawer called");
              },
            ),
          ),
          OpenContainer(
              openBuilder: (context, _) {
                return NoteSearchScreen();
              },
              closedColor: ColorList.appbackgroundColorDark,
              transitionDuration: Duration(milliseconds: 400),
              transitionType: ContainerTransitionType.fadeThrough,
              closedBuilder: (context, VoidCallback openContainer) => Container(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                    width: 180,
                    color: ColorList.containerColor,
                    child: TextField(
                      onTap: () {
                        openContainer();
                      },
                      controller: _searchEditingController,
                      autofocus: false,
                      style: CustomTextStyle.whiteContentStyle,
                      cursorColor: Colors.blueGrey,
                      decoration: InputDecoration(
                        hintStyle: CustomTextStyle.greyContentStyle,
                        hintText: 'Search',
                        border: InputBorder.none,
                      ),
                    ),
                  )),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: InkWell(
              child: homeViewModel.isGrid
                  ? SvgPicture.asset(
                      'assets/grid_list_icon.svg',
                      color: Colors.white,
                    )
                  : SvgPicture.asset(
                      'assets/list_view_icon.svg',
                      color: Colors.white,
                    ),
              onTap: () {
                homeViewModel.toggleGrid();
              },
            ),
          ),
          Container(
            height: 40,
            width: 40,
            color: Colors.red,
            child: PopupMenuButton<String>(
              icon: Icon(
                Icons.sort,
                color: Colors.white,
              ),
              color: ColorList.containerColor,
              onSelected: (String choice) {
                homeViewModel.chooseSortingType(choice);
              },
              itemBuilder: (BuildContext context) {
                return homeViewModel.listOfSorting.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Container(
                        child: Text(
                      choice,
                      style: CustomTextStyle.whiteContentStyle,
                    )),
                  );
                }).toList();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget getBody({HomeViewModel homeViewModel}) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 10,
            width: double.infinity,
            color: ColorList.appbackgroundColorDark,
          ),
          OpenContainer(
            transitionDuration: Duration(milliseconds: 400),
            openBuilder: (context, _) => NoteSearchScreen(),
            //closedShape: CircleBorder(),
            closedColor: ColorList.containerColor,
            closedBuilder: (context, openContainer) => Container(
              height: MediaQuery.of(context).size.height / 14,
              width: MediaQuery.of(context).size.width - 30,
              decoration: BoxDecoration(
                  color: ColorList.containerColor,
                  //color: Colors.white,
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width / 12)),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: Container(
                      height:40,
                      width:40,
                      padding: const EdgeInsets.all(6.0),
                      //color:Colors.red,
                      child: InkWell(
                        child: SvgPicture.asset(
                          'assets/custom_drawer_icon.svg',
                          color: Colors.white,
                        ),
                        onTap: () {
                          scaffoldKey.currentState.openDrawer();
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                    width: 200,
                  ),
                  Container(
                    height: 40,
                    width: 30,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: InkWell(
                        child: homeViewModel.isGrid
                            ? SvgPicture.asset(
                                'assets/grid_list_icon.svg',
                                color: Colors.white,
                          height: 20,
                              )
                            : SvgPicture.asset(
                                'assets/list_view_icon.svg',
                                height: 20,
                                color: Colors.white,
                              ),
                        onTap: () async {
                          homeViewModel.toggleGrid();
                        },
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    //color: Colors.red,
                    child: PopupMenuButton<String>(
                      icon: Icon(
                        Icons.sort,
                        size: 25,
                        color: Colors.white,
                      ),
                      color: ColorList.containerColor,
                      onSelected: (String choice) {
                        homeViewModel.chooseSortingType(choice);
                        homeViewModel.refreshNoteList();
                      },
                      itemBuilder: (BuildContext context) {
                        return homeViewModel.listOfSorting.map((String choice) {
                          return PopupMenuItem<String>(
                            value: choice,
                            child: Container(
                                child: Text(
                                  choice,
                                  style: CustomTextStyle.whiteContentStyle,
                                )),
                          );
                        }).toList();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: MediaQuery.of(context).size.height - 92,
            padding: EdgeInsets.all(10),
            child: NotesGridList(
              noteList: homeViewModel.notesList,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildList(List<Map<String, dynamic>> data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Card(
            child: Container(
              color: ColorList.containerColor,
              child: Column(
                children: [
                  Text(
                    data[index]['noteTitle'],
                    style: CustomTextStyle.whiteContentStyle,
                  ),
                  Text(
                    data[index]['noteData'],
                    style: CustomTextStyle.whiteContentStyle,
                  )
                ],
              ),
            ),
          );
        });
  }
}
