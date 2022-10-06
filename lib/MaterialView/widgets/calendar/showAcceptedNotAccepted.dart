 
import 'package:firebasetest/utils/Models/memberDecision.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowAcceptedNotAccepted extends StatefulWidget {
  const ShowAcceptedNotAccepted({Key? key, required this.liste})
      : super(key: key);

  final List<MemberDecision> liste;
  @override
  State<ShowAcceptedNotAccepted> createState() =>
      _ShowAcceptedNotAcceptedState();
}

class _ShowAcceptedNotAcceptedState extends State<ShowAcceptedNotAccepted> {
  Map<String, int> map = {};
  double value = 0.0;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final kommen = widget.liste
        .where((element) => element.entscheidung == 1)
        .toList()
        .length;

    final kommenNicht = widget.liste
        .where(
            (element) => element.entscheidung == 2 || element.entscheidung == 0)
        .toList()
        .length;

    final lengthAll = widget.liste.length;

    return Padding(
      padding: EdgeInsets.all(5),
      child: Row(
        children: [
          Text(
            kommen.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: LinearProgressIndicator(
              value: kommen / lengthAll,
              backgroundColor: Colors.red,
              color: Colors.green,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            kommenNicht.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
