import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasetest/MaterialView/widgets/cupertinoAlertDialogCustom.dart';
import 'package:firebasetest/utils/Api/mitglied.api.dart';
import 'package:firebasetest/utils/Models/member.dart';
import 'package:firebasetest/utils/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PermissionsWidgetActivePassive extends StatefulWidget {
  const PermissionsWidgetActivePassive({super.key, required this.user});

  final Member user;

  @override
  State<PermissionsWidgetActivePassive> createState() =>
      _PermissionsWidgetActivePassiveState();
}

class _PermissionsWidgetActivePassiveState
    extends State<PermissionsWidgetActivePassive> {
  int? _valueIsPassive = 0;

  @override
  void initState() {
    // TODO: implement initState
    _valueIsPassive = widget.user.isPassive == true ? 0 : 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Wrap(
        children: List<Widget>.generate(
          Constants.choiceChipsTextsPassiv.length,
          (int index) {
            return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: ChoiceChip(
                selectedColor: Colors.lightBlue,
                selectedShadowColor: Colors.amberAccent,
                label: Text(Constants.choiceChipsTextsPassiv[index]),
                selected: _valueIsPassive == index,
                onSelected: (bool selected) {
                  var old = _valueIsPassive;

                  CupertinoAlertDialogCustom.showAlertDialog(
                    context,
                    "Ändern der Berechtigungen ? Neu",
                    "Die Berechtigungen werden von ${widget.user.isPassive} zu ${Constants.choiceChipsTextsPassiv[index]} gewechseln für ${widget.user.firstname}",
                    [
                      CupertinoDialogAction(
                        child: const Text("Ja"),
                        isDestructiveAction: true,
                        onPressed: () async {
                          Navigator.of(context, rootNavigator: true).pop();

                          bool newVal =
                              Constants.choiceChipsTextsPassiv[index] == "Aktiv"
                                  ? false
                                  : true;
                          MitgliedApi.updateCustomUserData(
                              {"isPassive": newVal}, widget.user.uid);
                          setState(() {
                            _valueIsPassive = index;
                            print(
                                "ändern von ${Constants.choiceChipsTextsPassiv[old!]} zu ${Constants.choiceChipsTextsPassiv[index]}");
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
