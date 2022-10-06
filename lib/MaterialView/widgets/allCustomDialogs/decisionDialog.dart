import 'package:firebasetest/utils/Api/terminAbstimmung.api.dart';
import 'package:firebasetest/utils/Models/appointment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DecisionDialog extends StatefulWidget {
  const DecisionDialog(
      {super.key,
      required this.appointmentId,
      required this.addFunctions,
      required this.deleteFunctions});

  final appointmentId;
  final deleteFunctions;
  final addFunctions;
  @override
  State<DecisionDialog> createState() => _DecisionDialogState();
}

class _DecisionDialogState extends State<DecisionDialog> {
  var allDecisions = ["Ich komme", "Ich komme nicht"];

  var selectedValue = "";
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Zusage"),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        TextButton(
          onPressed: () {
            //handle
          },
          child: Text("Abbruch"),
        ),
        TextButton(
          onPressed: () {
            //handle
            if (selectedValue == "Ich komme") {
              widget.addFunctions();
              TerminAbstimmungApi.addOrUpdateTerminAbstimmung(
                  "add", widget.appointmentId);
            }

            if (selectedValue == "Ich komme nicht") {
              widget.deleteFunctions();
              TerminAbstimmungApi.addOrUpdateTerminAbstimmung(
                  "delete", widget.appointmentId);
            }

            Navigator.pop(context, "next");
          },
          child: Text("Weiter"),
        ),
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: allDecisions.map(
          (e) {
            return RadioListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              value: e,
              title: Text(e),
              groupValue: selectedValue,
              onChanged: (value) {
                setState(() {
                  selectedValue = e;
                });
              },
            );
          },
        ).toList(),
      ),
    );
  }
}
