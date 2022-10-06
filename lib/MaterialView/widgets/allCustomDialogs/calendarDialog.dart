import 'package:device_calendar/device_calendar.dart';
import 'package:firebasetest/utils/Models/appointment.dart';
import 'package:firebasetest/utils/calendarHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CalendarDialog extends StatefulWidget {
  const CalendarDialog(
      {super.key, required this.finalList, required this.appointment});

  final List<Calendar> finalList;
  final Appointment appointment;

  @override
  State<CalendarDialog> createState() => _CalendarDialogState();
}

class _CalendarDialogState extends State<CalendarDialog> {
  var selectedValue = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Auswahl des Kalenders"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: widget.finalList.map(
            (e) {
              return RadioListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                title: Text(e.name!),
                value: e.id!,
                groupValue: selectedValue,
                onChanged: (value) {
                  setState(() {
                    selectedValue = value.toString();
                  });
                },
              );
            },
          ).toList(),
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        TextButton(
          onPressed: () {
            //handle Calendar Choice
            Navigator.pop(context, "no");
          },
          child: Text("Abbruch"),
        ),
        TextButton(
          onPressed: () {
            //handle Calendar Choice

            if (selectedValue != "") {
              Navigator.pop(context, "next");
              CalendarHelper().addEvent(widget.appointment, selectedValue);
            } else {
              Navigator.pop(context);
            }
          },
          child: Text("Weiter"),
        ),
      ],
    );
  }
}
