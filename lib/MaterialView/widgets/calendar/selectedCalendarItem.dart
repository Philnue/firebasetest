import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetest/MaterialView/widgets/allCustomDialogs/appendixDialog.dart';
import 'package:firebasetest/MaterialView/widgets/allCustomDialogs/calendarDialog.dart';
import 'package:firebasetest/MaterialView/widgets/allCustomDialogs/decisionDialog.dart';
import 'package:firebasetest/MaterialView/widgets/calendar/cupertinoActionSheetCustom.dart';
import 'package:firebasetest/MaterialView/widgets/calendar/cupertinoListTile.dart';
import 'package:firebasetest/MaterialView/widgets/calendar/notizwidget.dart';
import 'package:firebasetest/MaterialView/widgets/calendar/popUpMenuItem.dart';
import 'package:firebasetest/MaterialView/widgets/mitgliederViewSpecific.dart';
import 'package:firebasetest/utils/Api/terminAbstimmung.api.dart';
import 'package:firebasetest/utils/Models/member.dart';
import 'package:firebasetest/utils/Models/memberDecision.dart';
import 'package:firebasetest/utils/Models/appointment.dart';
import 'package:firebasetest/utils/calendarHelper.dart';
import 'package:firebasetest/utils/shared/allCollections.dart';
import 'package:firebasetest/utils/shared/colors.dart';
import 'package:firebasetest/utils/shared/constants.dart';
import 'package:firebasetest/utils/shared/roleHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'showAcceptedNotAccepted.dart';

class SelectedCalendarItem extends StatefulWidget {
  //const SelectedCalendarItem({Key? key}) : super(key: key);
  const SelectedCalendarItem({Key? key, required this.terminA})
      : super(key: key);
  static const routeName = '/selectedCalendarItem';
  //final Termin termin;
  final Appointment terminA;

  @override
  State<SelectedCalendarItem> createState() => _SelectedCalendarItemState();
}

class _SelectedCalendarItemState extends State<SelectedCalendarItem> {
  late Member crr;
  refresh() {
    setState(() {});
  }

  Color? currentColor = CupertinoColors.systemGrey;

  static const anhang = ["alleine", "+1", "+2"];
  String selectedValue = anhang.first;

  String buttonText = "";

  void setValue(int ent) {
    if (ent == 0) {
      buttonText = "Noch nicht entschieden";
      currentColor = OwnColors.customGrey;
    }
    if (ent == 1) {
      buttonText = "Zugesagt";
      currentColor = OwnColors.customGreen;
    }
    if (ent == 2) {
      buttonText = "Abgelehnt";
      currentColor = OwnColors.customRed;
    }

    if (widget.terminA.deadline.isBefore(DateTime.now())) {
      buttonText = "Anmeldeschluss vorbei";
      currentColor = OwnColors.customRed;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    var _uid = FirebaseAuth.instance.currentUser!.uid;
    var nm = FirebaseFirestore.instance
        .collection(AllCollections.users)
        .doc(_uid)
        .get();

    setValue(widget.terminA.ownEntscheidung);

    super.initState();
  }

  late List<MemberDecision> initList = widget.terminA.mitgliedEntscheidung;

  void deleteFunction() async {
    setState(() {
      setValue(2);

      initList.remove(widget.terminA.ownMitgliedEntscheidung);

      initList.add(MemberDecision(
        mitglied: Constants.currentUser,
        entscheidung: 2,
      ));

      var lm = initList;
    });

    //delete Termin

    var allCalendars = await CalendarHelper()
        .lookAllCalendarsForTheEntrieAndDelete(widget.terminA);
  }

  void addFunction() {
    setState(() {
      setValue(1);

      initList.remove(widget.terminA.ownMitgliedEntscheidung);

      initList.add(
          MemberDecision(mitglied: Constants.currentUser, entscheidung: 1));
    });
  }

  @override
  Widget build(BuildContext context) {
    print("refresh");
    //var mediaQuerySize = MediaQuery.of(context).size;
    //var platform = Theme.of(context).platform;

    try {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.terminA.name),
          actions: RoleHelper.hasRights(AllRoles.planer) == true
              ? PopUpMenuItemSelectedCalendar.popUpMenuItemsSelectedCal(
                  context, widget.terminA, initList)
              : [],
        ),
        body: SafeArea(
            child: Center(
          child: Column(
            children: [
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.terminA.selectedCalendarItemList.length,
                  itemBuilder: ((context, index) {
                    return CupertinoListTile(
                      leading: widget.terminA.selectedCalendarItemList[index]
                          .elementAt(1) as IconData,
                      title: widget.terminA.selectedCalendarItemList[index]
                          .elementAt(2) as String,
                      trailing: widget.terminA.selectedCalendarItemList[index]
                          .elementAt(0) as String,
                    );
                  })),
              widget.terminA.notes.length > 1
                  ? NotizWidget(text: widget.terminA.notes)
                  : Container(),
              widget.terminA.time.isBefore(
                DateTime.now().subtract(
                  Duration(days: 1),
                ),
              )
                  ? Container()
                  : MaterialButton(
                      padding: const EdgeInsets.all(10),
                      disabledColor: OwnColors.buttonRed,
                      color: currentColor,
                      child: Container(
                          child: Text(
                        buttonText,
                        style: const TextStyle(
                          color: CupertinoColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                      onPressed: widget.terminA.deadline.isAfter(DateTime.now())
                          ? () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return DecisionDialog(
                                    appointmentId: widget.terminA.id,
                                    addFunctions: addFunction,
                                    deleteFunctions: deleteFunction,
                                  );
                                },
                              ).then((value) async {
                                print("decision $value");
                                if (value == "next") {
                                  if (widget.terminA.withAppendix == true) {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AppendixDialog(
                                            appointmentId: widget.terminA.id);
                                      },
                                    ).then((value) async {
                                      if (value == "next") {
                                        var liste = await CalendarHelper()
                                            .loadAllCalendars();
                                        print(
                                            "Nach calendarhelper ${liste.length}");
                                        if (liste.isNotEmpty) {
                                          print(
                                              "Nach is not empty${liste.length}");
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return CalendarDialog(
                                                finalList: liste,
                                                appointment: widget.terminA,
                                              );
                                            }, 
                                          );
                                        }
                                      }
                                    });
                                  } else {
                                    var liste = await CalendarHelper()
                                        .loadAllCalendars();

                                    if (liste.isNotEmpty) {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return CalendarDialog(
                                            finalList: liste,
                                            appointment: widget.terminA,
                                          );
                                        },
                                      );
                                    }
                                  }
                                }
                              });
                            }
                          : null,
                    ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Center(
                    child: ShowAcceptedNotAccepted(liste: initList)), //!machen
              ),
              Expanded(
                child: MitgliederViewSpecific(
                  id: widget.terminA.id,
                  appendixAllowed: widget.terminA.withAppendix,
                ),
              ),
            ],
          ),
        )),
      );
    } catch (_) {
      rethrow;
    }
  }
}
