import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasetest/utils/Models/member.dart';
import 'package:firebasetest/utils/shared/allCollections.dart';
import 'package:firebasetest/utils/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MitgliedApi {
  static final _collection =
      FirebaseFirestore.instance.collection(AllCollections.users);
  static final _uid = FirebaseAuth.instance.currentUser!.uid;

  static Stream<Member> getCurrentMemberAsStream(String id) {
    return _collection
        .doc(id)
        .snapshots()
        .asyncMap((event) => Member.fromJson(event.data()!));
  }

  static Future<List<Member>> loadAllCustomUserData() async {
    print("alluserdata");
    print(Constants.currentUser.license.shortPrefix);
    try {
      var querySnapshotCustomUserData = await _collection
          .where("licenseShortPrefix",
              isEqualTo: Constants.currentUser.license.shortPrefix)
          .get();

      return Member.userDataListFromSnapshot(querySnapshotCustomUserData.docs);
    } catch (_) {
      throw "LoadAllCustomerUserData Error: ${_.toString()}";
    }
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>>
      loadAllCustomUserDataAsSnapshot() {
    var _data = _collection
        .where("licenseShortPrefix",
            isEqualTo: Constants.currentUser.license.shortPrefix)
        .snapshots();

    return _data;
  }

  static Future<Member> getCustomUserDataFromFireBaseById(String docId) async {
    try {
      var jsonDoc = await _collection.doc(docId).get();

      return Member.fromJson(jsonDoc.data()!);
    } catch (_) {
      throw "getCustomUserDataFromFireBaseById error ${_.toString()}";
    }
  }

  static Future<Member> getCurrentCustomUserDataFromFireBase() async {
    try {
      var jsonDoc = await _collection.doc(_uid).get();

      return Member.fromJson(jsonDoc.data()!);
    } catch (_) {
      throw "getCurrentCustomUserDataFromFireBase error${_.toString()}";
    }
  }

  static Future<void> updateCustomUserData(
      Map<String, dynamic> data, String memberId) async {
    try {
      await _collection.doc(memberId).update(data);
      Constants.currentUser = await getCurrentCustomUserDataFromFireBase();
    } catch (_) {
      throw "updateCustomUserData error ${_.toString()}";
    }
  }

  static void addNewUser(Map<String, dynamic> data) async {
    try {
      var packageInfo = await PackageInfo.fromPlatform();

      var buildNumber = int.parse(packageInfo.buildNumber);
      print("connection = $_collection");
      await _collection.doc(_uid).set(data);
    } catch (_) {
      throw "addNewUser error ${_.toString()}";
    }
  }
}
