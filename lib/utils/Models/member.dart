import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasetest/utils/Models/license.dart';
import 'package:firebasetest/utils/format.dart';
import 'package:firebasetest/utils/shared/constants.dart';
import 'package:firebasetest/utils/shared/extensions.dart';
import 'package:firebasetest/utils/shared/roleHelper.dart';
import 'package:flutter/material.dart';
import '../firebaseUtils/database.dart';

// class CustomUser {
//   final String uid;

//   CustomUser({required this.uid});
// }

class Member {
  Member({
    required this.uid,
    required this.firstname,
    required this.lastname,
    required this.shortname,
    required this.rawData,
    required this.isPassive,
    required this.lastLogin,
    required this.role,
    required this.buildNumber,
    required this.birthdayData,
    required this.license,
  });

  bool hasPermission(String askedPerm) {
    return askedPerm == role ? true : false;
  }

  factory Member.fromJson(Map<dynamic, dynamic> json) {
    var state = json["birthDayShowState"];

    BirthdayData bData = BirthdayData(
      birthdayAsTimestamp: json["birthday"],
      showValue: BirthdayHelper.toEnum(
        json["birthDayShowState"],
      ),
    );

    License l = Constants.allLicenses.firstWhere(
      (element) {
        return element.shortPrefix == json["licenseShortPrefix"];
      },
    );

    return Member(
      uid: json["uid"],
      firstname: json["firstname"],
      lastname: json["lastname"],
      shortname: json["shortname"],
      rawData: json,
      isPassive: json["isPassive"],
      buildNumber: json["build_number"],
      lastLogin: json["last_login"],
      role: AllRolesHelper.toEnum(json["role"]),
      birthdayData: bData,
      license: l,
    );
  }

  late String firstname;
  late BirthdayData birthdayData;

  late bool isPassive;

  late String lastname;
  late Map<dynamic, dynamic> rawData;
  late String shortname;
  late String uid;
  late Timestamp lastLogin;
  late AllRoles role;
  late AllRoles enumRole;
  late String buildNumber;
  late License license;

  String get isPassiveAsString {
    return isPassive == true ? "Ja" : "Nein";
  }

  String get fullname {
    return "$firstname $lastname";
  }

  String get getName {
    return shortname == "" ? fullname : shortname;
  }

  static List<Member> userDataListFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Member.fromJson(data.data());
    }).toList();
  }

  static Member singleUserDataFromSnapshot(dynamic snapshot) {
    return snapshot.map((data) {
      return Member.fromJson(data.data());
    }).toList();
  }

  Future<Member> get _currentUser {
    var m = DatabaseService(uid: uid);

    return m.getCustomUserDataFromFireBase();
  }
}

class BirthdayData {
  final Timestamp birthdayAsTimestamp;
  final BirthdayShowState showValue;

  BirthdayData({required this.birthdayAsTimestamp, required this.showValue});

  ///Returns birthday as DateTime Object
  DateTime get birthdayAsDateTime {
    return birthdayAsTimestamp.toDate();
  }

  ///Returns "year-months-day"
  String get birthdayEnglish {
    String year = birthdayAsDateTime.year.toString().padLeft(2, '0');
    String month = birthdayAsDateTime.month.toString().padLeft(2, '0');
    String day = birthdayAsDateTime.day.toString().padLeft(2, '0');

    return "$year-$month-$day";
  }

  ///Returns "day.month.year"
  String get datumConvertedInGerman {
    var birthday = birthdayAsTimestamp.toDate();
    return Format.convertDateToGerman(birthday);
  }

  ///returns dd.mm.yyyy, dd.mm, no
  String get birthDayAfterState {
    String returnString = "";

    String month = birthdayAsDateTime.month.toString().padLeft(2, '0');
    String day = birthdayAsDateTime.day.toString().padLeft(2, '0');

    switch (showValue) {
      case BirthdayShowState.full:
        returnString = datumConvertedInGerman;
        break;
      case BirthdayShowState.onlyDayAndMonth:
        returnString = "$day.$month";
        break;
      case BirthdayShowState.no:
        returnString = "ausgeblendet";
        break;
    }
    print(returnString);
    print(datumConvertedInGerman);
    return returnString;
  }

  ///Returns "Heute", "Morgen" oder "day.month.year"
  String get getBirthdayAsString {
    final today =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
            .toString()
            .substring(0, 10);
    final tomorrow = DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day + 1)
        .toString()
        .substring(0, 10);

    if (today == birthdayEnglish) {
      return "Heute";
    }
    if (tomorrow == birthdayEnglish) {
      return "Morgen";
    }
    return datumConvertedInGerman;
  }
}
