import 'package:device_calendar/device_calendar.dart';
import 'package:firebasetest/utils/Models/appointment.dart';
import 'package:firebasetest/utils/showSnackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_native_timezone/flutter_native_timezone.dart';

import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class CalendarHelper {
  DeviceCalendarPlugin _deviceCalendarPlugin = DeviceCalendarPlugin();
  CalendarHelper() {
    init();
  }

  Future<void> init() async {
    try {
      await _deviceCalendarPlugin.requestPermissions();
      tz.initializeTimeZones();
      final locationName = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(locationName));

      var m = _deviceCalendarPlugin.hasPermissions();
      print(m);
    } catch (_) {
      rethrow;
    }
  }

  Future<List<Calendar>> loadAllCalendars() async {
    try {
      var allCalendars = await _deviceCalendarPlugin.retrieveCalendars();
      print("allCalendars");
      print(allCalendars.data);

      if (allCalendars.data!.isNotEmpty) {
        print(allCalendars.data!.length);
        allCalendars.data!.forEach((element) {
          print(element.id);
        });
      }

      var calendars = allCalendars.data?.toList();

      if (calendars != null) {
        calendars.forEach((element) {});
        return calendars;
      } else {
        [];
      }
      return [];
    } catch (_) {
      rethrow;
    }
  }

  Event createEventFromTermin(Appointment termin, String calenderId,
      {String? eventId = ""}) {
    try {
      Event _event = Event(
        calenderId,
        availability: Availability.Busy,
        location: termin.place,
        title: termin.name,
        start: tz.TZDateTime.from(termin.time, tz.local),
        allDay: false,
        description:
            generateDesc(termin.notes, termin.clothing, termin.meetingPoint),
        end: tz.TZDateTime.from(termin.time, tz.local).add(Duration(hours: 4)),
      );

      if (eventId != "") {
        _event.eventId = eventId;
      }

      return _event;
    } catch (_) {
      rethrow;
    }
    //! was wenn keine Uhrzeit vorhanden ist testen
    //Wenn keine Uhrzeit vorhanden ist
  }

  Future<List<Calendar>> retrieveAllCalendarsAsList() async {
    try {
      var allCals = await _deviceCalendarPlugin.retrieveCalendars();
      var list = allCals.data?.toList();

      return list ?? [];
    } catch (_) {
      rethrow;
    }
  }

  Future<List<Event>> retrieveEventsFromTerminAndCalIdAsList(
      Appointment t, String? calId) async {
    try {
      var entriesFromTermin = await _deviceCalendarPlugin.retrieveEvents(
          calId,
          RetrieveEventsParams(
            startDate: t.time,
            endDate: t.time.add(const Duration(days: 1)),
          ));
      return entriesFromTermin.data!.toList();
    } catch (_) {
      rethrow;
    }
  }

  Future<void> lookAllCalendarsForTheEntrieAndDelete(Appointment t) async {
    //var allCals = await _deviceCalendarPlugin.retrieveCalendars();
    //var list = allCals.data?.toList();

    try {
      var list = await retrieveAllCalendarsAsList();
      var isAlreadIn = false;
      var isAlreadyInEvent = Event("calendarId");

      for (var item in list) {
        var entriesFromTermin =
            await retrieveEventsFromTerminAndCalIdAsList(t, item.id);

        entriesFromTermin.forEach((element) async {
          if (element.title == t.name) {
            isAlreadIn = true;
            isAlreadyInEvent = element;

            var m = await _deviceCalendarPlugin.deleteEvent(
                item.id, element.eventId);

            print(m);
          }
        });
      }
    } catch (_) {
      rethrow;
    }
  }

  Future<Event> test(Appointment t, String calId) async {
    try {
      String? existingEventId = "";

      Event existingEvent = createEventFromTermin(t, calId);

      var entriesFromTermin =
          await retrieveEventsFromTerminAndCalIdAsList(t, calId);

      entriesFromTermin.forEach((element) {
        if (element.title == t.name) {
          existingEventId = element.eventId;
          existingEvent = element;
        }
      });

      return existingEvent;
    } catch (_) {
      rethrow;
    }
  }

  static Future<void> handleCalendarChoice(
      BuildContext context, Appointment appointment) async {
    try {
      var m = await CalendarHelper().loadAllCalendars();
      if (m.length != 0 > 0) {
        List<Widget> actions = [];
        m.forEach((element) {
          actions.add(
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context, element.id);
              },
              child: Text("${element.name}"),
            ),
          );
        });
        showCupertinoModalPopup(
          context: context,
          builder: (context) => CupertinoActionSheet(
            title: const Text("Welcher Kalender"),
            message: const Text("Kalender auswählen"),
            actions: actions,
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context, "cancel");
              },
              child: const Text("Abbrechen"),
              isDefaultAction: true,
            ),
          ),
        ).then((value) async {
          if (value != "cancel" && value != null) {
            await CalendarHelper().addEvent(appointment, value);
          }
          //! wtesten nur wen even sto
        });
      }
    } catch (_) {
      rethrow;
    }
  }

  Future<bool> addEvent(Appointment t, String calId) async {
    init();

    if (calId != "cancel") {
      var eventWithoutEventId = createEventFromTermin(t, calId);
      var entriesFromTermin =
          await retrieveEventsFromTerminAndCalIdAsList(t, calId);

      bool isAlreadIn = false;
      String? existingEventId = "";

      entriesFromTermin.forEach((element) {
        if (element.title == t.name) {
          isAlreadIn = true;

          existingEventId = element.eventId;
        }
      });

      print("existingEventId " + existingEventId.toString());

      var updatedEvent =
          createEventFromTermin(t, calId, eventId: existingEventId);

      if (isAlreadIn == false) {
        //nicht drinnen

        var added = await _deviceCalendarPlugin
            .createOrUpdateEvent(eventWithoutEventId);
        print("added");
        var mm = await test(t, calId);
        return added!.isSuccess ? true : false;
      }

      //! testen
      if (isAlreadIn == true) {
        //drinnen

        var added =
            await _deviceCalendarPlugin.createOrUpdateEvent(updatedEvent);
        print("update");

        return added!.isSuccess ? true : false;
      }

      var mm = await test(t, calId);
    }
    return false;
  }

  Future<bool> delEvent(String calId, String eventId) async {
    var result = await _deviceCalendarPlugin.deleteEvent(calId, eventId);

    return result.isSuccess;
  }

  static String generateDesc(
      String notizen, String kleidung, String treffpunk) {
    String desc = "";

    desc += "Notizen: $notizen \n\n";
    desc += "Kleidung: $kleidung \n\n";
    desc += "Treffpunkt: $treffpunk \n\n";

    return desc;
  }
}
