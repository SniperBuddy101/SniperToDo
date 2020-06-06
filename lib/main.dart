import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:provider/provider.dart';
import 'list.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<ToDoItems>(
          create: (context) => ToDoItems(),
        )
      ],
      child: MaterialApp(
        home: HomePage(),
      ),
    ));

class ThisData extends ChangeNotifier {
  int theNumber = 0;

  void addOne() {
    theNumber = theNumber + 1;
    notifyListeners();
  }
}
