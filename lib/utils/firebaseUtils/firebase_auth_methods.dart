import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebasetest/utils/Api/mitglied.api.dart';
import 'package:firebasetest/utils/Models/license.dart';
import 'package:firebasetest/utils/Models/member.dart';
import 'package:firebasetest/utils/shared/allCollections.dart';
import 'package:firebasetest/utils/shared/constants.dart';
import 'package:firebasetest/utils/showSnackbar.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

final userProvider = StreamProvider<User?>(
  (ref) => FirebaseAuth.instance.authStateChanges(),
);

final userTest = Provider<User?>(
  (ref) => FirebaseAuth.instance.currentUser!,
);

final authProvider = Provider<FirebaseAuth>(
  (ref) => FirebaseAuth.instance,
);

class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);

  User get user => _auth.currentUser!;

  // Strea<Member> get customMember async =>
  //     await MitgliedApi.getCurrentMemberAsStream();

  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();

  // EMAIL SIGN UP
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required BuildContext context,
    required String license,
    required String firstname,
    required String lastname,
    required DateTime birthdDay,
    required BirthdayShowState birthdayShowState,
  }) async {
    try {
      var list = Constants.allLicenses
          .where((element) => element.shortPrefix == license)
          .toList();

      if (list.isNotEmpty) {
        var cLicense = list[0];

        Timestamp ts = Timestamp.fromDate(birthdDay);

        await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        var info = await PackageInfo.fromPlatform();

        await sendEmailVerification(context);

        //person in users erstellen

        print(user.uid);

        MitgliedApi.addNewUser(
          {
            "uid": user.uid,
            "firstname": firstname,
            "lastname": lastname,
            "shortname": "",
            "isPassive": false,
            "birthday": ts,
            "last_login": user.metadata.lastSignInTime!,
            "created_at": user.metadata.creationTime!,
            "role": "user",
            "build_number": info.buildNumber,
            "birthDayShowState": birthdayShowState.name,
            "licenseShortPrefix": license
          },
        );

        var test = await FirebaseFirestore.instance
            .collection(AllCollections.termine)
            .where("licenseShortPrefix", isEqualTo: license)
            .get()
            .then(
          (value) {
            if (value.docs.isNotEmpty) {
              value.docs.forEach(
                (element) async {
                  await FirebaseFirestore.instance
                      .collection(AllCollections.termine)
                      .doc(element.id)
                      .update({
                    "terminAbstimmungen.${user.uid}": {
                      "count": 0,
                      "decision": 0
                    }
                  });
                  print("after");
                },
              );
            }
          },
        );

        var newMap = {
          "available": cLicense.available - 1,
          "registered": cLicense.registered + 1
        };

        await FirebaseFirestore.instance
            .collection("license")
            .doc(cLicense.name)
            .update(newMap);

        //Alle Termien TA erstellen

        Constants.currentUser =
            await MitgliedApi.getCurrentCustomUserDataFromFireBase();

        Navigator.pop(context);
      } else {
        showSnackBar(context,
            "Leider ist die Lizens falsch probieren sie es erneut, oder alle Lizensen aufgebraucht");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      showSnackBar(context, e.message!);
    }
  }

  // EMAIL LOGIN
  Future<void> loginWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (!user.emailVerified) {
        await sendEmailVerification(context);
        // restrict access to certain things using provider
        // transition to another page instead of home screen

      }

      Constants.currentUser =
          await MitgliedApi.getCustomUserDataFromFireBaseById(user.uid);

      Navigator.pop(context);
      print("after Login");
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Displaying the error message
    }
  }

  // EMAIL VERIFICATION
  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      _auth.currentUser!.sendEmailVerification();
      showSnackBar(context, 'Email verification sent!');
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Display error message
    }
  }

  // ANONYMOUS SIGN IN
  // Future<void> signInAnonymously(BuildContext context) async {
  //   try {
  //     await _auth.signInAnonymously();
  //   } on FirebaseAuthException catch (e) {
  //     showSnackBar(context, e.message!); // Displaying the error message
  //   }
  // }

  // SIGN OUT
  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Displaying the error message
    }
  }

  // DELETE ACCOUNT
  Future<void> deleteAccount(BuildContext context) async {
    try {
      await _auth.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Displaying the error message
      // if an error of requires-recent-login is thrown, make sure to log
      // in user again and then delete account.
    }
  }
}
