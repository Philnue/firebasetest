import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetest/MaterialView/Views/aemterView.dart';
import 'package:firebasetest/MaterialView/Views/calendarView.dart';
import 'package:firebasetest/MaterialView/Views/allMitgliederView.dart';
import 'package:firebasetest/MaterialView/Views/pollView.dart';
import 'package:firebasetest/MaterialView/widgetUtils/customNavBar.dart';
import 'package:firebasetest/utils/Api/mitglied.api.dart';
import 'package:firebasetest/utils/firebaseUtils/firebase_auth_methods.dart';
import 'package:firebasetest/utils/providers/crrtUserNotifier.dart';
import 'package:firebasetest/utils/shared/constants.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  int selectedIndex = 0;

  List screens = [
    const CalendarView(),
    //const PollView(),
    const AllMitgliederView(),
    const AemterView(),
  ];
  void onClicked(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //final user = context.read<FirebaseAuthMethods>().user;

    return Scaffold(
      bottomNavigationBar:
          CustomNavBar(onClicked: onClicked, selectedIndex: selectedIndex),
      body: Center(
        child: screens.elementAt(selectedIndex),
      ),
    );
  }
}
