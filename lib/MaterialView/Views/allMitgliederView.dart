import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasetest/MaterialView/widgetUtils/customAppBar.dart';
import 'package:firebasetest/MaterialView/widgetUtils/newDrawer.dart';

import 'package:firebasetest/MaterialView/widgets/mitglieder/newMitgliedItem.dart';
import 'package:firebasetest/utils/Api/mitglied.api.dart';
import 'package:firebasetest/utils/Models/member.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AllMitgliederView extends StatelessWidget {
  const AllMitgliederView({Key? key}) : super(key: key);

  static final routeName = "/allmitgliederview";

  Stream<QuerySnapshot<Map<String, dynamic>>> _mystream() {
    return MitgliedApi.loadAllCustomUserDataAsSnapshot();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: "Mitglieder",
      ),
      drawer: NewDrawer(),
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Column(children: [
            //Text(DateTime.now().toString()),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                //Stream ändern
                stream: _mystream(),
                builder: (context, AsyncSnapshot<QuerySnapshot> projectSnap) {
                  if (projectSnap.connectionState == ConnectionState.none) {
                    return const Text("connection none");
                  }
                  if (projectSnap.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  var list =
                      Member.userDataListFromSnapshot(projectSnap.data!.docs);

                  return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3,
                      ),
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return NewMitgliedItem(
                          fontsize: 22,
                          padding: 4,
                          mitglied: list[index],
                        );
                      });
                },
              ),
            )
          ]),
        ),
      ),
    );
  }
}
