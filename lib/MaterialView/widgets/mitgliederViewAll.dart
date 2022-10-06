 
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:firebasetest/MaterialView/widgets/mitgliedItem.dart';
import 'package:firebasetest/utils/Api/mitglied.api.dart';
import 'package:firebasetest/utils/Models/member.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';

class MitgliederViewAll extends StatelessWidget {
  MitgliederViewAll(
      {Key? key, this.id = "0", this.fontsize = 20, this.padding = 8})
      : super(key: key);
  String id;
  double fontsize, padding;

  Stream<QuerySnapshot<Map<String, dynamic>>> _mystream() {
    if (id == "0") {
      return MitgliedApi.loadAllCustomUserDataAsSnapshot();
    } else {
      return MitgliedApi.loadAllCustomUserDataAsSnapshot();
    }
  }

  @override
  Widget build(BuildContext context) {
    var t = Platform.isAndroid;

    return StreamBuilder<QuerySnapshot>(
      //Stream ändern
      stream: _mystream(),
      builder: (context, AsyncSnapshot<QuerySnapshot> projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none) {
          return const Text("connection none");
        }
        if (projectSnap.connectionState == ConnectionState.waiting) {
          return t
              ? const CircularProgressIndicator(
                  color: Colors.blue,
                )
              : const CupertinoActivityIndicator();
        }

        var list =
            Member.userDataListFromSnapshot(projectSnap.data!.docs);

        

        return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3,
            ),
            itemCount: list.length,
            itemBuilder: (context, index) {
              return MitgliedItem(
                fontsize: 22,
                padding: 2,
                mitglied: list[index],
              );
            });
      },
    );
  }
}
