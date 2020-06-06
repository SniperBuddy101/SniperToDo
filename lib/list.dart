import 'package:flutter/material.dart';
import 'dart:convert';
import 'data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ToDoItems extends ChangeNotifier {
  SharedPreferences sharedPreferencesObj;
  List todoItemsForShared = [];
  List<ToDoItem> toDoItemList = [];
  List<ToDoItem> toDoTodayList = [];

  Future<void> sharedPreferencesGetter() async {
    sharedPreferencesObj = await SharedPreferences.getInstance();
    todoItemsForShared =
        await jsonDecode(sharedPreferencesObj.get('toDoItems')) ?? [];
    var nowDate = DateTime.now().toLocal();
    DateTime todaysDate =
        DateTime.utc(nowDate.year, nowDate.month, nowDate.day);
    DateTime toDoDate;
    if (todoItemsForShared.isNotEmpty) {
      for (List toDoItem in todoItemsForShared) {
        ToDoItem toBeAdded = ToDoItem(
            dataText: toDoItem[0],
            isDone: toDoItem[1],
            currentTimeStamp: toDoItem[2]);
        toDoItemList.add(toBeAdded);
        toDoDate = DateTime.fromMillisecondsSinceEpoch(toDoItem[2]).toLocal();
        toDoDate = DateTime.utc(toDoDate.year, toDoDate.month, toDoDate.day);
        if (todaysDate.compareTo(toDoDate) == 0) {
          toDoTodayList.add(toBeAdded);
        }
      }
      notifyListeners();
    }
  }

  List<ToDoItem> getToDoList() {
    return toDoItemList;
  }

  Future<void> addToDo({ToDoItem toDoItem}) async {
    toDoItemList.add(toDoItem);
    toDoTodayList.add(toDoItem);
    todoItemsForShared
        .add([toDoItem.dataText, toDoItem.isDone, toDoItem.currentTimeStamp]);
    await sharedPreferencesObj.remove('toDoItems');
    await sharedPreferencesObj.setString(
        'toDoItems', jsonEncode(todoItemsForShared));
    notifyListeners();
  }

  Future<void> deleteToDo(ToDoItem theToDo) async {
    int toDoIndex = toDoItemList.indexOf(theToDo);
    print("Main list $toDoIndex");
    if (toDoTodayList.contains(theToDo)) {
      int toDoIndexInTodayList = toDoTodayList.indexOf(theToDo);
      print("Today list $toDoIndexInTodayList");
      toDoTodayList.removeAt(toDoIndexInTodayList);
    }
    toDoItemList.remove(theToDo);
    todoItemsForShared.removeAt(toDoIndex);
    await sharedPreferencesObj.remove('toDoItems');
    await sharedPreferencesObj.setString(
        'toDoItems', jsonEncode(todoItemsForShared));
    notifyListeners();
  }

  Future<void> toggleToDoItem(ToDoItem theToDo) async {
    theToDo.toggleStatus();
    int toDoIndex = toDoItemList.indexOf(theToDo);
    todoItemsForShared[toDoIndex][1] = theToDo.isDone;
    await sharedPreferencesObj.remove('toDoItems');
    await sharedPreferencesObj.setString(
        'toDoItems', jsonEncode(todoItemsForShared));
    notifyListeners();
  }
}
