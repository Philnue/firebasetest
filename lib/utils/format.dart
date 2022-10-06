import 'dart:core';

import 'package:flutter/cupertino.dart';

import 'package:intl/intl.dart';

class Format {
  static String get currentDate {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd.MM.yyyy');
    final String formatted = formatter.format(now);
    return formatted;
  }

  static String convertDateToGerman(DateTime date) {
    String year = date.year.toString().padLeft(2, '0');
    String month = date.month.toString().padLeft(2, '0');
    String day = date.day.toString().padLeft(2, '0');

    return "$day.$month.$year";
  }

  static bool get isAcceptTime {
    var m = DateTime.now();

    if (m.hour < 22 && m.hour > 6) {
      return true;
    } else {
      return true; // muss auf false wieder gesetzt werden
    }
  }

  static DateTime getDateTimeObject(String date, String time) {
    var year = date.substring(0, 4);
    var month = date.substring(5, 7);
    var day = date.substring(8, 10);

    var hour = "";
    var min = "";

    //! wen uhrzeit n.A. ist

    hour = time.substring(0, 2);

    min = time.substring(3, 5);

    DateTime dt = DateTime(int.parse(year), int.parse(month), int.parse(day),
        int.parse(hour), int.parse(min));

    return dt;
  }

  static DateTime getDateTimeObejectWithMinusDuration(
      String date, String time, Duration duration) {
    return getDateTimeObject(date, time).subtract(duration);
  }

  static DateTime getDateTimeObejectWithoutDuration(String date, String time) {
    return getDateTimeObject(date, time);
  }

  static String passiveText(String passive) {
    if (passive == "Nein") {
      return "";
    } else {
      return "Passivmitglied";
    }
  }

  static String bodyGenerator(int days) {
    String body = "";
    switch (days) {
      case 0:
        body = "heute";
        break;
      case 1:
        body = "morgen";
        break;
      case 2:
        body = "übermorgen";
        break;
      case 3:
        body = "in 3 Tagen";
        break;
      case 4:
        body = "in 4 Tagen";
        break;
      case 5:
        body = "in 5 Tagen";
        break;
    }
    return body;
  }

  static Color getCupertinoColorsForEntscheidung(int entscheidung) {
    switch (entscheidung) {
      case 0:
        return CupertinoColors.lightBackgroundGray;

      case 1:
        return CupertinoColors.activeGreen.withOpacity(0.7);

      case 2:
        return CupertinoColors.systemRed.withOpacity(0.7);
    }

    return CupertinoColors.lightBackgroundGray;
  }

  static Color getAndroidColorsForEntscheidung(int entscheidung) {
    switch (entscheidung) {
      case 0:
        return CupertinoColors.lightBackgroundGray;

      case 1:
        return CupertinoColors.activeGreen.withOpacity(0.7);

      case 2:
        return CupertinoColors.systemRed.withOpacity(0.7);
    }

    return CupertinoColors.lightBackgroundGray;
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
