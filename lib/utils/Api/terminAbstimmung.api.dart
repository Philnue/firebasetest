import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebasetest/utils/Api/mitglied.api.dart';
import 'package:firebasetest/utils/Api/termin.api.dart';
import 'package:firebasetest/utils/Models/member.dart';
import 'package:firebasetest/utils/Models/appointment.dart';
import 'package:firebasetest/utils/Models/memberDecision.dart';
import 'package:firebasetest/utils/Models/terminAbstimmung.dart';
import 'package:firebasetest/utils/shared/allCollections.dart';
import 'package:firebasetest/utils/shared/constants.dart';

class TerminAbstimmungApi {
  static final _terminCollection =
      FirebaseFirestore.instance.collection(AllCollections.termine);

  // static Stream<List<TerminTerminAbstimmung>> getNewList() async* {
  //   try {
  //     yield* _terminCollection
  //         .orderBy("zeitpunkt")
  //         .snapshots(includeMetadataChanges: true)
  //         .asyncMap((snap) async {
  //       List<Future<TerminTerminAbstimmung>> list = snap.docs.map((doc) async {
  //         return TerminTerminAbstimmung.fromJsonNew(doc);
  //       }).toList();
  //       return await Future.wait(list);
  //     });
  //   } catch (_) {
  //     throw ("Termine API ${_.toString()}");
  //   }
  // }

  static Future<void> handleAppendicValue(
      int value, String appointmentId) async {
    try {
      var userId = Constants.currentUser.uid;
      var userString = "terminAbstimmungen.$userId.count";

      await _terminCollection.doc(appointmentId).update({userString: value});
    } catch (_) {
      throw _;
    }
  }

  static Stream<List<MemberDecision>> getAllTaByTerminIdAsSnapshot(
      String terminId) async* {
    final allUsers = await MitgliedApi.loadAllCustomUserData();
    yield* _terminCollection
        .where("terminId", isEqualTo: terminId)
        .where("licenseShortPrefix",
            isEqualTo: Constants.currentUser.license.shortPrefix)
        .snapshots()
        .asyncMap((event) async {
      var doc = event.docs[0];

      List<MemberDecision> listeNew = [];

      var array = doc["terminAbstimmungen"];

      try {
        for (var key in array.keys) {
          var count = array[key]["count"];
          var decision = array[key]["decision"];

          var newt = allUsers
              .where((element) => element.uid == key && decision == 1)
              .toList();

          if (newt.isNotEmpty) {
            listeNew.add(MemberDecision(
                mitglied: newt[0], entscheidung: decision, count: count));
          }
        }
      } catch (_) {
        throw _;
      }

      return listeNew;
    });
  }

  // static Future<List<TerminAbstimmung>> getAllTerminAbstimmungenById(
  //     {required String terminId}) async {
  //   final _termin = await TerminApi.loadTerminById(terminId);
  //   var allUsers = await MitgliedApi.loadAllCustomUserData();

  //   List<TerminAbstimmung> _new = [];

  //   for (var item in _termin.taList.keys) {
  //     var user = allUsers.where((element) => element.uid == item).toList()[0];
  //     // var mml = await MitgliedApi.getCustomUserDataFromFireBaseById(
  //     //     item["mitgliedId"]);
  //     _new.add(
  //       TerminAbstimmung(
  //         termin: _termin,
  //         mitglied: user,
  //         entscheidung: _termin.taList[item],
  //       ),
  //     );
  //   }
  //   return _new;
  // }

  static Future<void> addOrUpdateTerminAbstimmung(
      String value, String appointmentId) async {
    try {
      //var ml = await _terminCollection.doc(termin.id).get();

      var userId = Constants.currentUser.uid;
      var userString = "terminAbstimmungen.$userId.decision";

      //var newString = "taMitRef["${termin.currentIndex}"].entscheidung";

      // var newv = await _terminCollection.doc(termin.id).update({userString: 1});

      //var data = t.docs[0];

      int entscheidungnew = 0;

      if (value == "add") {
        entscheidungnew = 1;
      } else {
        entscheidungnew = 2;
      }

      await _terminCollection
          .doc(appointmentId)
          .update({userString: entscheidungnew});

      // await _taCollection
      //     .doc(data.id)
      //     .update({"entscheidung": entscheidungnew});
    } catch (_) {
      throw _.toString();
    }
  }
}
