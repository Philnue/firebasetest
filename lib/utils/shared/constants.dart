import 'package:firebasetest/utils/Models/license.dart';
import 'package:firebasetest/utils/Models/member.dart';

class Constants {
  static void InitConts() {
    //user
    //license
  }

  static late List<License> allLicenses = [];

  static late Member currentUser;

  static List<Map> aemterMap = [];

  static final List<String> choiceChipsTextsCalendar = [
    "ALLE",
    "ZUGESTIMMT",
    "ABGELEHNT",
    "KEINE ANTWORT",
    "ALTE",
    "LISTE"
  ];

  static final List<String> choiceChipsTextsRole = [
    "coAdmin",
    "planer",
    "user",
  ];

  static final List<String> choiceChipsTextsPassiv = [
    "Passiv",
    "Aktiv",
  ];

  static final List<String> choiceChipsTextsBirthday = [
    "Tag.Monat.Jahr",
    "Tag.Monat",
    "Gar nicht",
  ];

  static final List months = [
    'Jan',
    'Feb',
    'Mrz',
    'Apr',
    'Mai',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Okt',
    'Nov',
    'Dez'
  ];
}

enum BirthdayShowState {
  full,
  onlyDayAndMonth,
  no,
}
