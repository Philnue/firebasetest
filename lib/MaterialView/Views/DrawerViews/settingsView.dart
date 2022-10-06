import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebasetest/MaterialView/widgetUtils/customAppBar.dart';
import 'package:firebasetest/MaterialView/widgets/permissionsWidgets/PermissionsWidgetBirthdayState.dart';

import 'package:firebasetest/MaterialView/widgets/settings/newShortNameWidget.dart';
import 'package:firebasetest/utils/Api/mitglied.api.dart';
import 'package:firebasetest/utils/Api/termin.api.dart';
import 'package:firebasetest/utils/Models/appointment.dart';
import 'package:firebasetest/utils/shared/allCollections.dart';
import 'package:firebasetest/utils/shared/constants.dart';
import "package:flutter/cupertino.dart";
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);
  static final String routeName = "settingsPage";

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsView> {
  int daysPicker = 0;

  DateTime timePicker = DateTime.now().add(
    Duration(minutes: 5 - DateTime.now().minute % 5),
  );

//! 17 nach und 9 nach geht net 11
  //17 nach geht de
  loadUserData() async {
    Constants.currentUser =
        await MitgliedApi.getCurrentCustomUserDataFromFireBase();
  }

  @override
  void initState() {
    // TODO: implement initState
    // TODO:
    //! ERROR
    loadUserData();
    super.initState();
  }

  final TextEditingController _spitzname = TextEditingController(
      text: Constants.currentUser.shortname == ""
          ? ""
          : Constants.currentUser.shortname);
  void refresh() {
    setState(() {});
  }

  final Uri _url =
      Uri.parse('mailto:smith@example.org?subject=News&body=New%20plugin');
  @override
  Widget build(BuildContext context) {
    print("sett calendar");
    Future<void> _launchUrlt() async {
      print("start");
      if (await launchUrl(_url)) {
        throw 'Could not launch $_url';
      }
    }

    return Scaffold(
      appBar: CustomAppBar(text: "Einstellungen", withBackButton: true),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: Icon(Icons.add),
      // ),
      //drawer: NewDrawer(),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const NewShortNameWidget(),

          PermissionsWidgetBirthdayState(user: Constants.currentUser),
          const Divider(
            color: CupertinoColors.systemGrey,
            thickness: 2,
          ),

          // const Text(
          //   "Uhrzeit für die Mitteilung",
          //   style: TextStyle(fontWeight: FontWeight.bold),
          // ),
          // Flexible(
          //   flex: 3,
          //   child: CupertinoDatePicker(
          //     use24hFormat: true,

          //     initialDateTime: DateTime(now.year, now.month, now.day, now.hour,
          //         (now.minute % 5 * 5).toInt()),
          //     // initialDateTime: DateTime.now().add(
          //     //   Duration(minutes: 5 - DateTime.now().minute % 5),
          //     // ),
          //     minuteInterval: 5,
          //     mode: CupertinoDatePickerMode.time,
          //     onDateTimeChanged: (value) {
          //       setState(() {
          //         timePicker = value;
          //         print(timePicker);
          //       });
          //       var selectedTime = value;
          //     },
          //   ),
          // ),
          // const Text(
          //   "Wie viele Tage vorher",
          //   style: TextStyle(fontWeight: FontWeight.bold),
          // ),
          // Expanded(
          //   flex: 4,
          //   child: CupertinoPicker(
          //     onSelectedItemChanged: (value) {
          //       setState(() {
          //         daysPicker = value;
          //       });
          //     },
          //     itemExtent: 25,
          //     useMagnifier: true,
          //     magnification: 1.3,
          //     children: const [
          //       Text("Selber Tag"), //ehute
          //       Text("1 Tag"), //morgen
          //       Text("2 Tage"), //in
          //       Text("3 Tage"),
          //       Text("4 Tage"),
          //       Text("5 Tage"),
          //     ],
          //   ),
          // ),
          // Flexible(
          //   flex: 4,
          //   child: CupertinoButton(
          //     color: CupertinoColors.systemBlue,
          //     disabledColor: CupertinoColors.systemGrey,
          //     child: Text(
          //       "Speichern",
          //       style: TextStyle(color: CupertinoColors.white),
          //     ),
          //     onPressed: Format.isAcceptTime
          //         ? () {
          //             // HiveHelper.writeNotificationToDevice(
          //             //     daysPicker, timePicker);
          //           }
          //         : null,
          //   ),
          // ),

          const Text(
            "Accountdetails",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          CupertinoButton(
            child: Text("Ausloggen"),
            color: Colors.blue,
            onPressed: () {
              _logOut();
            },
          ),
          SizedBox(
            height: 20,
          ),
          CupertinoButton(
            child: Text("Account Löschen"),
            color: Colors.red,
            onPressed: () async {
              _deleteAccount();
            },
          ),
          SizedBox(
            height: 20,
          ),
          Divider(
            color: CupertinoColors.systemGrey,
            thickness: 2,
          ),
          // ElevatedButton(
          //   onPressed: () {},
          //   child: Text("elevated"),
          // ),
          // TextButton(
          //   onPressed: () {},
          //   child: Text("text"),
          // ),
          // OutlinedButton(
          //   onPressed: () {},
          //   child: Text("outlined"),
          // ),
          // IconButton(
          //   onPressed: () {},
          //   icon: Icon(Icons.abc),
          // ),

          // Card(
          //   child: Text("test"),
          // ),
        ],
      )),
    );
  }

  void _logOut() async {
    await FirebaseAuth.instance.signOut();
    setState(() {});
  }

  void _deleteAccount() async {
    try {
      print("not implemented");
      var currentId = FirebaseAuth.instance.currentUser!.uid;

      var ttt = await FirebaseFirestore.instance
          .collection(AllCollections.termine)
          .where("licenseShortPrefix",
              isEqualTo: Constants.currentUser.license.shortPrefix)
          .get()
          .then(
        (value) {
          var allTermine = value.docs;

          for (var termin in allTermine) {
            var old = termin["terminAbstimmungen"] as Map;

            old.remove(currentId);

            TerminApi.updateTermin(termin.id, {"terminAbstimmungen": old});
          }
        },
      );
      var Strr = "users/$currentId";

      var deleteStaet = await FirebaseFirestore.instance.doc(Strr).delete();

      // //!alles durchgehn und die uid löschen

      var currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        currentUser.delete();
      }

      print("test");
    } catch (e) {
      print(e.toString());
    }
  }
}
