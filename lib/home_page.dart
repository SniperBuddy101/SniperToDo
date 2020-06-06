import 'package:flutter/material.dart';
import 'constants.dart';
import 'data_model.dart';
import 'bottom_sheet.dart';
import 'list.dart';
import 'package:provider/provider.dart';
import 'custom_tab_bar.dart';
import 'listWidget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  List<ToDoItem> toDoItemList;
  ToDoItems toDoItemsObj = ToDoItems();
  String textFieldText;
  bool sharedPrefInitialized = false;
  TabController listTabController;

  @override
  void initState() {
    super.initState();
    sharedPrefInitializer();
    tabControllerInitializer();
  }

  void tabControllerInitializer() {
    listTabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  void sharedPrefInitializer() async {
    await Provider.of<ToDoItems>(context, listen: false)
        .sharedPreferencesGetter();

    setState(() {
      sharedPrefInitialized = true;
    });
  }

  Widget consumerOrIndicator(bool isToday) {
    if (sharedPrefInitialized = false) {
      return CircularProgressIndicator();
    } else {
      return CustomerToDoListWidget(isToday: isToday,);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
              backgroundColor: kPrimaryColor,
              child: Icon(
                Icons.add,
                size: 30,
                color: kSecondaryColor,
              ),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) =>
                        SingleChildScrollView(
                            child: Container(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery
                                        .of(context)
                                        .viewInsets
                                        .bottom),
                                child: BottomSheetContent())));
              }),
          backgroundColor: kPrimaryColor,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25.0, vertical: 35.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 30.0,
                      child: Icon(
                        Icons.list,
                        color: kPrimaryColor,
                        size: 35.0,
                      ),
                      backgroundColor: kSecondaryColor,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'SniperToDo',
                      style: TextStyle(
                          color: kSecondaryColor,
                          fontSize: 40.0,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Total ${context
                          .watch<ToDoItems>()
                          .toDoItemList
                          .length} tasks',
                      style: TextStyle(color: kSecondaryColor, fontSize: 16.0),
                    ),
                    Text(
                      'Today ${context.watch<ToDoItems>().toDoTodayList.length} tasks',
                      style: TextStyle(color: kSecondaryColor, fontSize: 16.0),
                    ),

                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    top: 0.0,
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: 40.0, horizontal: 25.0),
                  decoration: BoxDecoration(
                      color: kSecondaryColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12.0),
                          topRight: Radius.circular(12.0))),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: CustomTabBar(listTabController: listTabController,
                        theTabs: ["Today", "All tasks"],),
                      ),
                      Expanded(
                          child:
                          TabBarView(controller: listTabController, children: [
                            consumerOrIndicator(true),
                            consumerOrIndicator(false),
                          ]))
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}





//DefaultTabController(
//length: 2,
//child: Scaffold(
//appBar: AppBar(
//bottom: TabBar(tabs: [
//Tab(
//text: "Today",
//icon: Icon(Icons.list),
//),
//Tab(
//icon: Icon(Icons.all_inclusive),
//text: "All tasks",
//)
//]),
//),
//backgroundColor: kSecondaryColor,
//body: TabBarView(children: [
//consumerOrIndicator(),
//Text("All tasks will be displayed here."),
//]),
//),
//)
