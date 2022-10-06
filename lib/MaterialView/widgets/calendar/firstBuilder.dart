// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebasetest/utils/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:firebasetest/MaterialView/widgets/calendar/newCalendarWidget.dart';
import 'package:firebasetest/utils/Models/customAppointment.dart';
import 'package:firebasetest/utils/Models/appointment.dart';

class FirstBuilder extends StatefulWidget {
  const FirstBuilder({
    Key? key,
    required this.mapStringCustomTermin,
    required this.allmonthsListString,
    required this.filteredTerminList,
    required this.showList,
  }) : super(key: key);

  final Map<String, CustomAppointment> mapStringCustomTermin;
  final List<String> allmonthsListString;
  final List<Appointment> filteredTerminList;
  final bool showList;

  @override
  State<FirstBuilder> createState() => _FirstBuilderState();
}

class _FirstBuilderState extends State<FirstBuilder> {
  String getAllMonthValue(int index) {
    return widget.allmonthsListString[index];
  }

  @override
  Widget build(BuildContext context) {
    return widget.allmonthsListString.isNotEmpty
        ? ListView.builder(
            itemCount: widget.allmonthsListString.length,
            itemBuilder: (context, index) {
              var splitted = widget.allmonthsListString[index].split(',');

              String dateVal =
                  "${Constants.months[int.parse(splitted[0]) - 1]},${splitted[1]}";

              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Text(widget.allmonthsListString[index]),
                      Text(dateVal),
                      IconButton(
                        onPressed: () => setState(() => widget
                            .mapStringCustomTermin[getAllMonthValue(index)]!
                            .toggleBool()),
                        icon: Icon(widget
                                    .mapStringCustomTermin[
                                        widget.allmonthsListString[index]]!
                                    .isVisible ==
                                true
                            ? Icons.arrow_downward
                            : Icons.arrow_back),
                      ),
                    ],
                  ),
                  NewCalendarWidget(
                    initTerminList: widget.filteredTerminList,
                    termineNew: widget.mapStringCustomTermin,
                    currentString: widget.allmonthsListString[index],
                    showList: widget.showList,
                  ),
                ],
              );
            },
          )
        : Center(
            child: Text("Keine Termine vorhanden"),
          );
  }
}
