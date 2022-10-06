import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:firebasetest/MaterialView/widgets/mitgliedItem.dart';
import 'package:firebasetest/utils/Api/terminAbstimmung.api.dart';
import 'package:firebasetest/utils/Models/member.dart';
import 'package:firebasetest/utils/Models/memberDecision.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';

class MitgliederViewSpecific extends StatelessWidget {
  MitgliederViewSpecific(
      {Key? key,
      required this.id,
      required this.appendixAllowed,
      this.fontsize = 20,
      this.padding = 8})
      : super(key: key);
  String id;
  bool appendixAllowed;
  double fontsize, padding;

  Stream<List<MemberDecision>> _mystream() {
    return TerminAbstimmungApi.getAllTaByTerminIdAsSnapshot(id);
  }

  @override
  Widget build(BuildContext context) {
    var t = Platform.isAndroid;
    try {
      return StreamBuilder<List<MemberDecision>>(
        //Stream ändern
        stream: _mystream(),
        builder: (context, AsyncSnapshot<List<MemberDecision>> projectSnap) {
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

          // if (projectSnap.connectionState == ConnectionState.active) {}
          var list = projectSnap.data!;

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3,
            ),
            itemCount: list.length,
            itemBuilder: (context, index) {
              return appendixAllowed
                  ? MitgliedItem(
                      fontsize: 22,
                      padding: 2,
                      mitglied: list[index].mitglied,
                      count: list[index].count,
                    )
                  : MitgliedItem(
                      fontsize: 22,
                      padding: 2,
                      mitglied: list[index].mitglied,
                     
                    );
            },
          );
        },
      );
    } catch (_) {
      print(_.toString());
      throw _;
    }
  }
}
