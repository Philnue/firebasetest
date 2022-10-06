import 'dart:io';

import 'package:firebasetest/utils/Models/memberDecision.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';

//! Auch mal mit Stateless probieren

class AdminInfoWidget extends StatefulWidget {
  const AdminInfoWidget(
      {Key? key,
      required this.list,
      required this.withPassive,
      required this.withAppendix})
      : super(key: key);
  final List<MemberDecision> list;
  final bool withPassive;
  final bool withAppendix;
  @override
  State<AdminInfoWidget> createState() => _AdminInfoWidgetState();
}

class _AdminInfoWidgetState extends State<AdminInfoWidget> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  int calculateWithCount(List<MemberDecision> liste) {
    int returnInt = 0;

    if (widget.withAppendix == true) {
      liste.forEach((element) {
        returnInt += element.intValueCount;
      });
    } else {
      returnInt = liste.length;
    }
    return returnInt;
  }

  Text generateText(MemberDecision memberDecision) {
    return Text(widget.withAppendix == true
        ? memberDecision.getValueWithCount
        : memberDecision.mitglied.getName);
  }

  List<MemberDecision> filteredAfterEntscheidung(int entscheidung) {
    return widget.list
        .where((element) => element.entscheidung == entscheidung)
        .where((element) {
      if (widget.withPassive == true) {
        return true;
      } else {
        if (element.mitglied.isPassive == false) {
          return true;
        } else {
          return false;
        }
      }
    }).toList();
  }

  
  @override
  Widget build(BuildContext context) {
    List<MemberDecision> kommen = filteredAfterEntscheidung(1);
    List<MemberDecision> kommenNicht = filteredAfterEntscheidung(2);
    List<MemberDecision> keineAntwort = filteredAfterEntscheidung(0);
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Divider(color: CupertinoColors.systemGrey, thickness: 1),
        widget.withPassive == true
            ? const Text(
                "Mit Passivmitgliedern",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
            : const Text(
                "Nur Aktivmitglieder",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
        Divider(color: CupertinoColors.systemGrey, thickness: 1),
        // SizedBox(
        //   height: 20,
        // ),
        Text(
          "Kommen: ${calculateWithCount(kommen)}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 5,
            ),
            itemCount: kommen.length,
            itemBuilder: (context, index) {
              return generateText(kommen[index]);
            },
          ),
        ),
        Divider(color: CupertinoColors.systemGrey, thickness: 1),
        // SizedBox(
        //   height: 20,
        // ),

        kommenNicht.isNotEmpty
            ? Expanded(
                child: Column(
                  children: [
                    Text(
                      "Kommen nicht: ${calculateWithCount(kommenNicht)}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 5,
                        ),
                        itemCount: kommenNicht.length,
                        itemBuilder: (context, index) {
                          return generateText(
                              kommenNicht[index]);
                        },
                      ),
                    ),
                  ],
                ),
              )
            : const Text(
                "Es hat sich keiner abgemeldet",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
        // SizedBox(
        //   height: 20,
        // ),
        Divider(color: CupertinoColors.systemGrey, thickness: 1),
        Text(
          "Keine Aktion: ${calculateWithCount(keineAntwort)}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            //decoration: TextDecoration.underline
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 5,
            ),
            itemCount: keineAntwort.length,
            itemBuilder: (context, index) {
              return generateText(keineAntwort[index]);
            },
          ),
        ),
      ],
    );
  }
}
