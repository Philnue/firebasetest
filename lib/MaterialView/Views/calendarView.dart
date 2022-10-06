import 'package:firebasetest/MaterialView/Views/addCalendarEntryView.dart';

import 'package:firebasetest/MaterialView/widgetUtils/customAppBar.dart';
import 'package:firebasetest/MaterialView/widgetUtils/newDrawer.dart';

import 'package:firebasetest/MaterialView/widgets/calendar/calendarItem.dart';
import 'package:firebasetest/MaterialView/widgets/calendar/firstBuilder.dart';
import 'package:firebasetest/MaterialView/widgets/calendar/newCalendarWidget.dart';

import 'package:firebasetest/utils/Api/mitglied.api.dart';
import 'package:firebasetest/utils/Api/termin.api.dart';
import 'package:firebasetest/utils/Models/customAppointment.dart';
import 'package:firebasetest/utils/Models/member.dart';

import 'package:firebasetest/utils/Models/appointment.dart';
import 'package:firebasetest/utils/providers/providers.dart';
import 'package:firebasetest/utils/shared/constants.dart';
import 'package:firebasetest/utils/shared/roleHelper.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({Key? key}) : super(key: key);

  static final routeName = "/calendarView";

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  int? _value = 0;

  List<Appointment> filterListAfterValue(
      List<Appointment> unfilteredList, int value) {
    return unfilteredList
        .where(
          (element) =>
              element.ownEntscheidung == value &&
              element.time.isAfter(
                DateTime.now().subtract(
                  Duration(days: 1),
                ),
              ),
        )
        .toList();
  }

  List<Appointment> getFilteredList(List<Appointment> unfilteredList) {
    switch (_value) {
      case 0:
        return unfilteredList
            .where(
              (element) => element.time.isAfter(
                DateTime.now().subtract(
                  Duration(days: 1),
                ),
              ),
            )
            .toList();

      case 1:
        return filterListAfterValue(unfilteredList, 1);
      case 2:
        return filterListAfterValue(unfilteredList, 2);

      case 3:
        return filterListAfterValue(unfilteredList, 0);

      case 4:
        return unfilteredList
            .where(
              (element) => element.time.isBefore(DateTime.now()),
            )
            .toList();

      case 5:
        return unfilteredList;
    }

    return [];
  }

  int currentListValue = 0;

  @override
  Widget build(BuildContext context) {
 
    try {
      return Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: const CustomAppBar(text: "Kalender"),
        floatingActionButton: RoleHelper.hasRights(AllRoles.planer)
            ? FloatingActionButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(AddCalendarEntryView.routeName);
                },
                child: Icon(Icons.add),
                enableFeedback: true,
              )
            : null,
        drawer: const NewDrawer(),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Column(children: [
              // Text(DateTime.now().toString()),
              //Filter(),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Wrap(
                  children: List<Widget>.generate(
                    Constants.choiceChipsTextsCalendar.length,
                    (int index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: ChoiceChip(
                          selectedColor: Colors.lightBlue,
                          selectedShadowColor: Colors.amberAccent,
                          label:
                              Text(Constants.choiceChipsTextsCalendar[index]),
                          selected: _value == index,
                          onSelected: (bool selected) {
                            if (_value != index) {
                              setState(() {
                                _value = selected ? index : null;
                              });
                            }
                          },
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
              Expanded(
                child: StreamBuilder<List<Appointment>>(
                    stream: TerminApi.loadTermineNew(),
                    builder:
                        (context, AsyncSnapshot<List<Appointment>> allTermine) {
                      if (allTermine.hasData && allTermine.data != null) {
                        print("Calendar  View Builder with data");

                        final list = getFilteredList(allTermine.data!);
                        list.sort(
                          (a, b) => a.time.compareTo(b.time),
                        );

                        Set<String> _set = Set();

                        list.forEach(
                          (element) => _set.add(
                              //"${Constants.months[element.zeitpRunkt.month - 1]}, ${element.zeitpunkt.year}"),
                              "${element.time.month}, ${element.time.year}"),
                        );
                        var allMonths = _set.toList();

                        Map<String, bool> test = {};

                        void testActt(String value) {
                          setState(() {
                            test[value] != test[value];
                          });
                        }

                        allMonths.forEach((element) {
                          test[element] = true;
                        });

                        Map<String, CustomAppointment> NewMap = {};

                        allMonths.forEach((allMonth) {
                          var t = list
                              .where((element) =>
                                  "${element.time.month}, ${element.time.year}" ==
                                  allMonth)
                              .toList();

                          NewMap[allMonth] = CustomAppointment(
                              appointmentList: t, isVisible: true);
                        });

                        return FirstBuilder(
                          mapStringCustomTermin: NewMap,
                          allmonthsListString: allMonths,
                          filteredTerminList: list,
                          showList: _value == 5 ? true : false,
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
            ]),
          ),
        ),
      );
    } catch (_) {
      return Center(
        child: Text(_.toString()),
      );
    }
  }
}
