import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasetest/MaterialView/widgets/cupertinoAlertDialogCustom.dart';
import 'package:firebasetest/utils/Api/mitglied.api.dart';
import 'package:firebasetest/utils/Models/member.dart';
import 'package:firebasetest/utils/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class PermissionsWidgetRoles extends StatefulWidget {
  const PermissionsWidgetRoles({super.key, required this.user});

  final Member user;

  @override
  State<PermissionsWidgetRoles> createState() => _PermissionsWidgetRolesState();
}

class _PermissionsWidgetRolesState extends State<PermissionsWidgetRoles> {
  int? _valueRole = 0;

  @override
  void initState() {
    // TODO: implement initState
    _valueRole = Constants.choiceChipsTextsRole.indexOf(widget.user.role.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Wrap(
        children: List<Widget>.generate(
          Constants.choiceChipsTextsRole.length,
          (int index) {
            return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: ChoiceChip(
                selectedColor: Colors.lightBlue,
                selectedShadowColor: Colors.amberAccent,
                label: Text(Constants.choiceChipsTextsRole[index]),
                selected: _valueRole == index,
                onSelected: (bool selected) {
                  var old = _valueRole;

                  CupertinoAlertDialogCustom.showAlertDialog(
                    context,
                    "Ändern der Berechtigungen ? Neu",
                    "Die Berechtigungen werden von ${widget.user.role} zu ${Constants.choiceChipsTextsRole[index]} gewechseln für ${widget.user.firstname}",
                    [
                      CupertinoDialogAction(
                        child: const Text("Ja"),
                        isDestructiveAction: true,
                        onPressed: () async {
                          Navigator.of(context, rootNavigator: true).pop();

                          MitgliedApi.updateCustomUserData(
                              {"role": Constants.choiceChipsTextsRole[index]}, widget.user.uid);
                          setState(() {
                            _valueRole = index;
                            print(
                                "ändern von ${Constants.choiceChipsTextsRole[old!]} zu ${Constants.choiceChipsTextsRole[index]}");
                          });

                          print("geändert");
                        },
                      ),
                      CupertinoDialogAction(
                        child: const Text("Nein"),
                        isDefaultAction: true,
                        onPressed: () async {
                          Navigator.of(context, rootNavigator: true).pop();

                          print("abbrich");
                        },
                      )
                    ],
                  );
                },
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
