import 'dart:io';

import 'package:firebasetest/utils/Api/mitglied.api.dart';
import 'package:firebasetest/utils/format.dart';
import 'package:firebasetest/utils/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../cupertinoAlertDialogCustom.dart';

class NewShortNameWidget extends StatefulWidget {
  const NewShortNameWidget({Key? key}) : super(key: key);

  @override
  _ShortNameWidgetState createState() => _ShortNameWidgetState();
}

class _ShortNameWidgetState extends State<NewShortNameWidget> {
  late TextEditingController _textController;

  late int _id;
  @override
  void initState() {
    super.initState();

    //_box = Hive.box("settings");

    //_textController =        TextEditingController(text: hiveHelper.loadDataString("name"));
    _textController = TextEditingController(
        text: Constants.currentUser.shortname); //shortname
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const Text(
            "Spitzname",
            style: TextStyle(fontSize: 20),
          ),
          //const Text("Vorname Nachname"),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: _textController,
            keyboardType: TextInputType.text,
            autocorrect: false,
            enabled: Format.isAcceptTime,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Spitzname',
            ),
            onSubmitted: (value) {
              setState(() {
                _textController.text = value;

                //! komma kontroller

                MitgliedApi.updateCustomUserData(
                    {"shortname": value}, Constants.currentUser.uid);

                CupertinoAlertDialogCustom.showAlertDialog(
                  context,
                  "Bearbeiten der Person",
                  "Ihr Name ${Constants.currentUser.shortname} wurde zu $value erfolgreich geändert",
                  [
                    CupertinoDialogAction(
                      child: const Text("Ok"),
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                    )
                  ],
                );
              });
            },
          ),
        ],
      ),
    );
  }
}
