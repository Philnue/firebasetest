import 'package:firebasetest/MaterialView/Views/adminView.dart';

import 'package:firebasetest/MaterialView/Views/editCalendarEntryViewNew.dart';
import 'package:firebasetest/MaterialView/widgets/calendar/selectedCalendarItem.dart';
import 'package:firebasetest/utils/Models/AdminViewArguments.dart';
import 'package:firebasetest/utils/Models/appointment.dart';
import 'package:firebasetest/utils/Models/memberDecision.dart';
import 'package:firebasetest/utils/fileHelper.dart';
import 'package:flutter/material.dart';

class PopUpMenuItemSelectedCalendar {
  static List<Widget> popUpMenuItemsSelectedCal(BuildContext context,
      Appointment appointment, List<MemberDecision> initList) {
    return [
      PopupMenuButton(
        onSelected: (value) {
          if (value == PopUpMenuButton.editieren) {
            Navigator.of(context).pushNamed(EditCalendarEntryViewNew.routeName,
                arguments: appointment);
          }
          if (value == PopUpMenuButton.teilnehmerAnsicht) {
            Navigator.of(context).pushNamed(
              AdminView.routeName,
              arguments: AdminViewArguments(initList, appointment.withAppendix),
            );
          }
          if (value == PopUpMenuButton.export) {
            //create File
            FileHelper.writeSummaryFile(context, appointment.name, initList);
          }
          if (value == PopUpMenuButton.info) {
            //create File
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Text(appointment.creator),
                        Text("Erstellungszeitpunkt")
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              value: PopUpMenuButton.editieren,
              child: Row(
                children: [
                  Icon(Icons.edit),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Editieren"),
                ],
              ),
            ),
            PopupMenuItem(
              value: PopUpMenuButton.teilnehmerAnsicht,
              child: Row(
                children: [
                  Icon(Icons.view_list),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Teilnehmer"),
                ],
              ),
            ),
            PopupMenuItem(
              value: PopUpMenuButton.export,
              child: Row(
                children: [
                  Icon(Icons.save),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Export as TxT"),
                ],
              ),
            ),
            PopupMenuItem(
              value: PopUpMenuButton.info,
              child: Row(
                children: [
                  Icon(Icons.info),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Termin Info"),
                ],
              ),
            ),
          ];
        },
      )
      // IconButton(
      //   onPressed: () {},
      //   icon: Icon(
      //     Icons.delete,
      //     color: Colors.red,
      //   ),
      // ),
    ];
  }
}

enum PopUpMenuButton {
  teilnehmerAnsicht,
  editieren,
  export,
  info,
}
