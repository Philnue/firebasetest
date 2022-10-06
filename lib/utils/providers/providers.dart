import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasetest/utils/Api/mitglied.api.dart';
import 'package:firebasetest/utils/Models/member.dart';
import 'package:firebasetest/utils/Models/memberDecision.dart';
import 'package:firebasetest/utils/Models/appointment.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final allTermTineStream = StreamProvider<List<Appointment>>(
//   (ref) async* {
//     //final _allUsers = await MitgliedApi.loadAllCustomUserData();

//     yield* FirebaseFirestore.instance
//         .collection("termine")
//         .orderBy("zeitpunkt")
//         .snapshots(includeMetadataChanges: true)
//         .asyncMap((snap) async {
//       final _allUsers = await MitgliedApi.loadAllCustomUserData();
//       List<Future<Appointment>> list = snap.docs.map((doc) async {
//         Map<String, dynamic> __data = doc.data()["terminAbstimmungen"];

//         List<MemberDecision> returnListe = [];

//         for (var key in __data.keys) {
//           var crrtMitglied =
//               _allUsers.firstWhere((element) => element.uid == key);

//           var ment = MemberDecision(
//               mitglied: crrtMitglied, entscheidung: __data[key]);

//           returnListe.add(ment);
//         }

//         return Appointment.fromJsonNew(doc, returnListe);
//       }).toList();

//       var retList = await Future.wait(list);
//       print(retList.length);
//       return retList;
//     });
//   },
// );
