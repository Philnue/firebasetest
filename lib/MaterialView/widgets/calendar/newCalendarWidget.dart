import 'package:firebasetest/MaterialView/widgets/calendar/calendarItem.dart';
import 'package:firebasetest/MaterialView/widgets/calendar/selectedCalendarItem.dart';
import 'package:firebasetest/utils/Models/customAppointment.dart';
import 'package:firebasetest/utils/Models/appointment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class NewCalendarWidget extends StatelessWidget {
  const NewCalendarWidget(
      {super.key,
      required this.initTerminList,
      required this.termineNew,
      required this.currentString,
      required this.showList});

  final List<Appointment> initTerminList;

  final Map<String, CustomAppointment> termineNew;
  final String currentString;

  final bool showList;

  @override
  Widget build(BuildContext context) {
    return termineNew[currentString]!.isVisible == false
        ? Container()
        : ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: termineNew[currentString]?.appointmentList.length,
            itemBuilder: (context, index) {
              return showList == true
                  ? Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      elevation: 2,
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SelectedCalendarItem(
                                      terminA: termineNew[currentString]!
                                          .appointmentList[index],
                                    )),
                          );
                        },
                        title: Text(
                            termineNew[currentString]!.appointmentList[index].name),
                        trailing: Text(termineNew[currentString]!
                            .appointmentList[index]
                            .datumConvertedInGerman),
                      ),
                    )
                  : CalendarItem(
                      termin: termineNew[currentString]!.appointmentList[index]);
            },
          );
  }
}
