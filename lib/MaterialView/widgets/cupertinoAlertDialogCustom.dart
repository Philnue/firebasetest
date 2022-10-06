 
import 'package:flutter/cupertino.dart';

class CupertinoAlertDialogCustom {
  static showAlertDialog(
      BuildContext context, String title, String text, List<Widget> list) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: Text(title),
              content: Text(text),
              actions: list,
            ));
  }

  
}
