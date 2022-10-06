import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasetest/utils/Api/mitglied.api.dart';
import 'package:firebasetest/utils/Models/member.dart';
import 'package:firebasetest/utils/Models/memberDecision.dart';
import 'package:firebasetest/utils/Models/appointment.dart';
import 'package:firebasetest/utils/Models/terminAbstimmung.dart';
import 'package:firebasetest/utils/shared/allCollections.dart';
import 'package:firebasetest/utils/shared/constants.dart';
import 'package:flutter/material.dart';

class TerminApi {
  static final _collection =
      FirebaseFirestore.instance.collection(AllCollections.termine);

  // static Future<List<Termin>> loadAllTermine() async {
  //   try {
  //     var _data = await _collection.orderBy("zeitpunkt").get();

  //     return Termin.terminAsListFromSnapshot(_data.docs);
  //   } catch (_) {
  //     throw ("Termine API ${_.toString()}");
  //   }
  // }

  // static Future<List<TerminTerminAbstimmung>> getNewList() async {
  //   try {
  //     var _data = await _collection.orderBy("zeitpunkt").get();

  //     return TerminTerminAbstimmung.terminTerminAbstimmungFromSnapshot(
  //         _data.docs);
  //   } catch (_) {
  //     throw ("Termine API ${_.toString()}");
  //   }
  // }

  static void addTermin(Map<String, dynamic> data) async {
    try {
      var allUser = await MitgliedApi.loadAllCustomUserData();

      Map<String, dynamic> mapList = {};

      for (var element in allUser) {
        mapList[element.uid] = {"count": 0, "decision": 0};
      }

      data["terminAbstimmungen"] = mapList;

      var _test = await _collection.add(data);
      await _collection.doc(_test.id).update({"terminId": _test.id});
    } catch (_) {
      throw ("Termine API add Termin ${_.toString()}");
    }
  }

  static void addTerminAbstimmung(String uid) {
    print("addTa");

    //for(var i in _collection.doc().set("":""));
  }

  // static Future<Termin> loadTerminById(String id) async {
  //   try {
  //     var _test = await _collection.doc(id).get();

  //     return Termin.fromJson(_test);
  //   } catch (_) {
  //     throw ("Termine API add Termin ${_.toString()}");
  //   }
  // }

  static void deleteTermin(String _id) async {
    try {
      await _collection.doc(_id).delete();
    } catch (_) {
      throw ("Termine API delete Termin ${_.toString()}");
    }
  }

  static void updateTermin(String _id, Map<String, dynamic> _values) async {
    try {
      await _collection.doc(_id).update(_values);
    } catch (_) {
      throw ("Termine API delete Termin ${_.toString()}");
    }
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> loadTermineAsSnapshot() {
    try {
      var _data = _collection
          .orderBy("zeitpunkt")
          .where("licenseShortPrefix",
              isEqualTo: Constants.currentUser.license.shortPrefix)
          .snapshots();

      return _data;
    } catch (_) {
      throw ("Termine API ${_.toString()}");
    }
  }

  static Stream<List<Appointment>> loadTermineNew() async* {
    try {
      yield* _collection
          .where("licenseShortPrefix",
              isEqualTo: Constants.currentUser.license.shortPrefix)
          //.orderBy("zeitpunkt", descending: false)
          .snapshots()
          .asyncMap(
        (snap) async {
          List<Future<Appointment>> list = snap.docs.map((doc) async {
            var _allUsers = await MitgliedApi.loadAllCustomUserData();

            Map<String, dynamic> array = doc.data()["terminAbstimmungen"];

            List<MemberDecision> returnListe = [];

            for (var key in array.keys) {
              var crrtMitglied =
                  _allUsers.where((element) => element.uid == key).toList();

              var count = array[key]["count"];
              var decision = array[key]["decision"];

              if (crrtMitglied.isNotEmpty) {
                var ment = MemberDecision(
                    mitglied: crrtMitglied[0],
                    entscheidung: decision,
                    count: count);

                returnListe.add(ment);
              }
            }

            var app = Appointment.fromJsonNew(doc, returnListe);

            return app;
          }).toList();

          var retList = await Future.wait(list);
          retList.forEach((element) {
            print(element.name);
          });
          return retList;
        },
      );
    } catch (_) {
      throw ("Termine API ${_.toString()}");
    }
  }
}

//LoadAllTermineWithAbstimmung
//loadAllTerminAbstimmungAfterTerminId
//loadTerminById