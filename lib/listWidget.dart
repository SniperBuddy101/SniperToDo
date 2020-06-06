import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'list.dart';
import 'list_tile.dart';
import 'data_model.dart';



class CustomerToDoListWidget extends StatelessWidget {

  final bool isToday;


  CustomerToDoListWidget({@required this.isToday});

  final List<ListItem> theList = [];


  @override
  Widget build(BuildContext context) {
    return Consumer<ToDoItems>(builder: (context, toDoObj, child) {
      theList.clear();
      if (isToday) {
        for (ToDoItem toDoItem in toDoObj.toDoTodayList) {
          ListItem lI = ListItem(
            labelText: toDoItem.dataText,
            isChecked: toDoItem.isDone,
            toggleFunctionCallBack: (value)async{
              await toDoObj.toggleToDoItem(toDoItem);
            },
            longPressFunctionCallback: ()async{
              await toDoObj.deleteToDo(toDoItem);
            },
          );
          theList.add(lI);
        }
      } else {
        for (ToDoItem toDoItem in toDoObj.toDoItemList) {
          ListItem lI = ListItem(
            labelText: toDoItem.dataText,
            isChecked: toDoItem.isDone,
            toggleFunctionCallBack: (value)async{
              await toDoObj.toggleToDoItem(toDoItem);
            },
            longPressFunctionCallback: ()async{
              await toDoObj.deleteToDo(toDoItem);
            },
          );
          theList.add(lI);
        }
      }

      return ListView.builder(
        itemBuilder: (context, index) {

          return theList[index];
        },
        itemCount: theList.length,
      );
    });
  }



}



//@override
//_CustomerToDoListWidgetState createState() => _CustomerToDoListWidgetState();
//}
//
//class _CustomerToDoListWidgetState extends State<CustomerToDoListWidget> {


//@override
//void initState() {
//  super.initState();
//  isToday = widget.isToday;
//}


