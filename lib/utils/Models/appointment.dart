import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasetest/utils/Models/license.dart';
import 'package:firebasetest/utils/format.dart';
import 'package:firebasetest/utils/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';

import 'memberDecision.dart';

class Appointment {
  Appointment({
    required this.id,
    required this.name,
    required this.time,
    required this.place,
    required this.notes,
    required this.meetingPoint,
    required this.clothing,
    required this.rawData,
    required this.taList,
    required this.creator,
    required this.deadline,
    required this.mitgliedEntscheidung,
    required this.withAppendix,
    required this.license,
  });

  factory Appointment.fromJsonNew(dynamic json, List<MemberDecision> liste) {
    var jsonData = json.data();

    Timestamp timestamp = jsonData["zeitpunkt"];
    Timestamp anmeldeschluss = jsonData["deadline"] ?? timestamp;

    //! wenn timestamp == anmeldechluss dann wurde keine Deadline gestzt

    License l = Constants.allLicenses.firstWhere(
      (element) {
        return element.shortPrefix == json["licenseShortPrefix"];
      },
    );

    return Appointment(
        id: json.id,
        name: jsonData["name"] ?? "Kein Name",
        time: timestamp.toDate(),
        place: jsonData["adresse"] ?? "Keine Adresse",
        notes: jsonData["notizen"] ?? "Keine Notizen",
        meetingPoint: jsonData["treffpunkt"] ?? "Kein Treffpunkt",
        clothing: jsonData["kleidung"] ?? "Keine Kleidung",
        rawData: jsonData,
        taList: jsonData["terminAbstimmungen"] ?? [],
        creator: jsonData["ersteller"] ?? "Kein Ersteller",
        deadline: anmeldeschluss.toDate(),
        mitgliedEntscheidung: liste,
        withAppendix: jsonData["withAppendix"] ?? false,
        license: l);
  }

  final String place;
  final String id;
  final String creator;
  final String clothing;
  List liste = [];
  final String name;
  final String notes;
  final Map<String, dynamic> rawData;
  final Map<dynamic, dynamic> taList;
  final String meetingPoint;
  final DateTime time;
  final DateTime deadline;
  final List<MemberDecision> mitgliedEntscheidung;
  final bool withAppendix;
  final License license;

  //List<MitgliedEntscheidung> getMitgliedEntscheidungAfter

  String get dateEnglish {
    String year = time.year.toString().padLeft(2, '0');
    String month = time.month.toString().padLeft(2, '0');
    String day = time.day.toString().padLeft(2, '0');

    return "$year-$month-$day";
  }

  String get getDateCorrectly {
    final today =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
            .toString()
            .substring(0, 10);
    final tomorrow = DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day + 1)
        .toString()
        .substring(0, 10);

    if (today == dateEnglish) {
      return "Heute ";
    }
    if (tomorrow == dateEnglish) {
      return "Morgen";
    }
    return datumConvertedInGerman;
  }

  DateTime get terminAsDateTimeWithoutTime {
    //"2022-06-27"
    return DateTime(time.year, time.month, time.day);
  }

  List<Set<dynamic>> get selectedCalendarItemList {
    var returnListe = [
      {timeAsString, CupertinoIcons.clock, "Uhrzeit:"},
      {datumConvertedInGerman, CupertinoIcons.calendar, "Datum:      "},
      {place, CupertinoIcons.placemark_fill, "Adresse:    "},
      {meetingPoint, CupertinoIcons.pin, "Treffpunkt:"},
      {clothing, CupertinoIcons.briefcase, "Kleidung:   "},
      {deadLineAsString, CupertinoIcons.doc_append, "Anmeldeschluss:"},
    ];

    if (withAppendix == true) {
      String appendixString = withAppendix == true ? "Ja" : "Nein";
      returnListe.add(
        {appendixString, CupertinoIcons.person_2, "Anhang erwünscht:"},
      );
    }
    return returnListe;
  }

  // static List<Termin> terminAsListFromSnapshot(List snapshot) {
  //   return snapshot.map((data) {
  //     return Termin.fromJson(data);
  //   }).toList();
  // }

  String get datumConvertedInGerman {
    return Format.convertDateToGerman(time);
  }

  Map<String, dynamic> compareMap(Map<String, dynamic> newMap) {
    Map<String, dynamic> updatedMap = {};
    Map<String, dynamic> currentDataMap = dataMap;
    for (var key in newMap.keys) {
      if (newMap[key] != currentDataMap[key]) {
        updatedMap[key] = newMap[key];
      }
    }

    return updatedMap;
  }

  int get ownEntscheidung {
    var item = mitgliedEntscheidung
        .where((element) => element.mitglied.uid == Constants.currentUser.uid)
        .toList();

    if (item.isNotEmpty) {
      return item[0].entscheidung;
    } else {
      return 0;
    }
  }

  MemberDecision get ownMitgliedEntscheidung {
    var item = mitgliedEntscheidung
        .where((element) => element.mitglied.uid == Constants.currentUser.uid)
        .toList();

    if (item.isNotEmpty) {
      return item[0];
    } else {
      return MemberDecision(
          mitglied: Constants.currentUser, entscheidung: 0, count: 0);
    }
  }

  int get currentIndex => mitgliedEntscheidung.indexWhere(
      (element) => element.mitglied.uid == Constants.currentUser.uid);

  Map<String, dynamic> get dataMap {
    return {
      "uid": id,
      "adresse": place,
      "kleidung": clothing,
      "name": name,
      "notizen": notes,
      "treffpunkt": meetingPoint,
      "zeitpunkt": time,
    };
  }

  String get deadLineAsString {
    return Format.convertDateToGerman(deadline);
  }

  String get timeAsString {
    var t = "";

    String hour = time.hour.toString().padLeft(2, '0');
    String minute = time.minute.toString().padLeft(2, '0');

    return "$hour:$minute";
  }
}
