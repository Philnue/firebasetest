import 'package:firebasetest/MaterialView/Views/mitgliedInfoView.dart';
import 'package:firebasetest/utils/Models/member.dart';
import 'package:flutter/material.dart';

class MitgliedItem extends StatelessWidget {
  const MitgliedItem({
    Key? key,
    required this.padding,
    required this.fontsize,
    required this.mitglied,
    this.count = 0,
  }) : super(key: key);

  final double padding;
  final double fontsize;
  final Member mitglied;
  final int count;
  @override
  Widget build(BuildContext context) {
    var nameWithCount =
        count == 0 ? mitglied.getName : mitglied.getName + " +$count";

    try {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            try {
              Navigator.of(context)
                  .pushNamed(MitgliedInfoView.routeName, arguments: mitglied);
            } catch (_) {
              throw _.toString();
            }
          },
          child: Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: SizedBox(
                //width: double.infinity,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    nameWithCount,
                    style: TextStyle(
                        fontSize: fontsize,
                        fontWeight: FontWeight.w600,
                        color: mitglied.isPassive == false
                            ? Colors.black
                            : Colors.grey),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    } catch (_) {
      print(_.toString());
      throw _;
    }
  }
}
