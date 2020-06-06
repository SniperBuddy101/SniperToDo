import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:provider/provider.dart';
import 'list.dart';
import 'data_model.dart';

class BottomSheetContent extends StatefulWidget {
  @override
  _BottomSheetContentState createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  String textFieldText;
  TextEditingController inputFieldController = TextEditingController();
  bool isFieldEmpty = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF757575),
      child: Container(
        decoration: BoxDecoration(
            color: kSecondaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0))),
        padding: EdgeInsets.all(35.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "Add Task",
              style: TextStyle(color: kPrimaryColor, fontSize: 25.0),
              textAlign: TextAlign.center,
            ),
            TextField(
              cursorColor: kPrimaryColor,
              onChanged: (textValue) {
                textFieldText = textValue;
              },
              decoration: InputDecoration(
                errorText: isFieldEmpty ? "The text can't be empty. Please enter some data." : null,
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor, width: 4.0)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: kPrimaryColor, width: 2.0))),
            ),
            Container(
              height: 50,
              margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
              child: FlatButton(
                  color: kPrimaryColor,
                  onPressed: () {
                    if (textFieldText == null){
                      setState(() {
                        isFieldEmpty = true;
                      });
                    }else{
                      Provider.of<ToDoItems>(context, listen: false)
                          .addToDo(toDoItem: ToDoItem(dataText: textFieldText));
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    'Add',
                    style: TextStyle(color: kSecondaryColor, fontSize: 16),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
