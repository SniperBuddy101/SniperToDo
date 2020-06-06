import 'package:flutter/material.dart';
import 'constants.dart';

class CustomTabBar extends StatelessWidget {

  final List<String> theTabs;

  CustomTabBar({@required this.listTabController, @required this.theTabs});

  List<Tab> tabBarSetter(){
    List<Tab> tabList = [];
    for (String eachTab in theTabs){
      tabList.add(Tab(
        child: Container(
          child: Align(
              alignment: Alignment.center,
              child: Text(eachTab)),
          decoration: BoxDecoration(
              borderRadius:
              BorderRadius.circular(kTabBorderRadius),
              border: Border.all(color: kPrimaryColor)),
        ),
      ));
    }
    return tabList;
  }

  final TabController listTabController;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      labelPadding: EdgeInsets.only(left: 5.0, right: 5.0),
        indicator: BoxDecoration(
            color: kPrimaryColor,
            borderRadius:
            BorderRadius.circular(kTabBorderRadius)),
        indicatorSize: TabBarIndicatorSize.label,
        unselectedLabelColor: kPrimaryColor,
        controller: listTabController,
        labelColor: kSecondaryColor,
        tabs: tabBarSetter());
  }
}