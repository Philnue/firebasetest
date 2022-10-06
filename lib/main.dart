import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebasetest/MaterialView/MaterialAppView.dart';
import 'package:firebasetest/firebase_options.dart';
import 'package:firebasetest/utils/Api/mitglied.api.dart';
import 'package:firebasetest/utils/Models/license.dart';
import 'package:firebasetest/utils/calendarHelper.dart';
import 'package:firebasetest/utils/firebaseUtils/database.dart';
import 'package:firebasetest/utils/shared/constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CalendarHelper();

  var allLicense = await FirebaseFirestore.instance.collection("license").get();
  var t = License.userDataListFromSnapshot(allLicense.docs);

  Constants.allLicenses = t;

  print("loadedAllLicenses");
  //FirebaseAuth.instance.signOut();
  if (FirebaseAuth.instance.currentUser != null) {
    var ml = DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid);

    Constants.currentUser = await ml.getCustomUserDataFromFireBase();
    print("forallaemter");
    var allAemter = await FirebaseFirestore.instance
        .collection("aemter")
        .where("licenseShortPrefix",
            isEqualTo: Constants.currentUser.license.shortPrefix)
        .orderBy("reihenfolge")
        .get();

    print(allAemter);

    List<Map> aemtMap = [];

    for (var item in allAemter.docs) {
      var amt = item["amt"];
      var name = item["name"];

      aemtMap.add({"Amt": amt, "Name": name});
    }
    //CalendarHelper();

    Constants.aemterMap = aemtMap;
    print("setAemterMap");
  }

  try {
    runApp(const ProviderScope(child: MainPage()));
    //runApp(const MainPage());
    //runApp(test.MyApp());
  } catch (_) {
    throw _.toString();
  }
}
