import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasetest/MaterialView/widgets/cupertinoAlertDialogCustom.dart';
import 'package:firebasetest/utils/Api/mitglied.api.dart';
import 'package:firebasetest/utils/Models/member.dart';
import 'package:firebasetest/utils/shared/allCollections.dart';
import 'package:firebasetest/utils/shared/constants.dart';
import 'package:firebasetest/utils/shared/roleHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

const double _kItemExtent = 32.0;

class PermissionsWidgetMultiLine extends StatefulWidget {
  const PermissionsWidgetMultiLine({Key? key, required this.user})
      : super(key: key);

  final Member user;

  @override
  State<PermissionsWidgetMultiLine> createState() => _PermissionsWidgetState();
}

class _PermissionsWidgetState extends State<PermissionsWidgetMultiLine> {
  int? _valueRole = 0;
  int? _valueIsPassive = 0;

  @override
  void initState() {
    // TODO: implement initState
    _valueRole = Constants.choiceChipsTextsRole.indexOf(widget.user.role.name);
    _valueIsPassive = widget.user.isPassive == true ? 0 : 1;
    super.initState();
  }

  Widget _showSaveButton() {
    //var initVal = Constants.roles.indexOf(widget.user.role);

    if (newRole >= 0 && initUserRole != RoleHelper.roles[newRole]) {
      return CupertinoButton(
          child: Icon(CupertinoIcons.share_up),
          onPressed: () {
            setState(() {
              newRole == -1;
              initUserRole = RoleHelper.roles[newRole];

              CupertinoAlertDialogCustom.showAlertDialog(
                context,
                "Ändern der Berechtigungen ?",
                "Die Berechtigungen werden von ${widget.user.role} zu ${initUserRole} gewechseln für ${widget.user.firstname}",
                [
                  CupertinoDialogAction(
                    child: const Text("Ja"),
                    isDestructiveAction: true,
                    onPressed: () async {
                      Navigator.of(context, rootNavigator: true).pop();

                      MitgliedApi.updateCustomUserData(
                          {"role": RoleHelper.roles[newRole]}, widget.user.uid);

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
            });
          });
    } else {
      return Container();
    }
    //return Text("");
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
              height: 216,
              padding: const EdgeInsets.only(top: 6.0),
              // The Bottom margin is provided to align the popup above the system navigation bar.
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              // Provide a background color for the popup.
              color: CupertinoColors.systemBackground.resolveFrom(context),
              // Use a SafeArea widget to avoid system overlaps.
              child: SafeArea(
                top: false,
                child: child,
              ),
            ));
  }

  var newRole = -1;
  late String initUserRole = widget.user.role.name;

  @override
  Widget build(BuildContext context) {
    var currentIndex = RoleHelper.roles.indexOf(initUserRole);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SingleChildScrollView(
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
                                Navigator.of(context, rootNavigator: true)
                                    .pop();

                                FirebaseFirestore.instance
                                    .collection(AllCollections.users)
                                    .doc(widget.user.uid)
                                    .update({
                                  "role": Constants.choiceChipsTextsRole[index]
                                });
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
                                Navigator.of(context, rootNavigator: true)
                                    .pop();

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
          ),

          //Aktiv Passiv

          SingleChildScrollView(
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
                                Navigator.of(context, rootNavigator: true)
                                    .pop();

                                bool newVal =
                                    Constants.choiceChipsTextsPassiv[index] ==
                                            "Aktiv"
                                        ? false
                                        : true;

                                FirebaseFirestore.instance
                                    .collection(AllCollections.users)
                                    .doc(widget.user.uid)
                                    .update({"isPassive": newVal});
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
                                Navigator.of(context, rootNavigator: true)
                                    .pop();

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
          ),

          // Text(
          //   "Rollen: & aktiv passiv am besten mit cuperitno switch ",
          //   style: TextStyle(
          //     fontSize: 24,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Text("Aktuelle Rolle"),
          //     SizedBox(
          //       width: 10,
          //     ),
          //     Text(
          //       initUserRole.toString(),
          //     ),
          //   ],
          // ),
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Text("Neue Rolle"),
          //     CupertinoButton(
          //       child: Text(
          //           newRole >= 0 ? RoleHelper.roles[newRole] : "Auswählen"),
          //       onPressed: () {
          //         _showDialog(
          //           CupertinoPicker(
          //             itemExtent: _kItemExtent,
          //             magnification: 1.22,
          //             squeeze: 1.2,
          //             useMagnifier: true,
          //             onSelectedItemChanged: (int selectedItem) {
          //               setState(() {
          //                 //selectedRole = selectedItem;

          //                 newRole = selectedItem;
          //               });
          //             },
          //             children: List<Widget>.generate(
          //               RoleHelper.roles.length,
          //               (index) {
          //                 return Center(
          //                   child: Text(
          //                     RoleHelper.roles[index],
          //                   ),
          //                 );
          //               },
          //             ),
          //           ),
          //         );
          //       },
          //     ),
          //     _showSaveButton(),
          //   ],
          // )
        ],
      ),
    );
  }
}
