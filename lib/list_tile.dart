import 'package:flutter/material.dart';
import 'constants.dart';


class ListItem extends StatelessWidget {
  final String labelText;
  final bool isChecked;
  final Function toggleFunctionCallBack;
  final Function longPressFunctionCallback;

  ListItem({this.labelText, this.isChecked, this.toggleFunctionCallBack, this.longPressFunctionCallback});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: longPressFunctionCallback,
        title: Text(
          labelText,
          style: isChecked
              ? TextStyle(decoration: TextDecoration.lineThrough)
              : null,
        ),
        trailing: Checkbox(
          checkColor: kSecondaryColor,
          activeColor: kPrimaryColor,
          value: isChecked,
          onChanged: toggleFunctionCallBack,
        ));
  }
}
