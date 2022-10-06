import 'package:firebasetest/utils/Api/terminAbstimmung.api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AppendixDialog extends StatefulWidget {
  const AppendixDialog({super.key, required this.appointmentId});
  final String appointmentId;
  @override
  State<AppendixDialog> createState() => _AppendixDialogState();
}

class _AppendixDialogState extends State<AppendixDialog> {
  var allValues = [
    "Alleine",
    "+1",
    "+2",
    "+3",
  ];
  var selectedValue = "";
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      buttonPadding: EdgeInsets.zero,
      title: const Text("Anhang ?"),
      actions: [
        TextButton(
          onPressed: () {
            //handle api

            if (selectedValue != "") {
              TerminAbstimmungApi.handleAppendicValue(
                  allValues.indexOf(selectedValue), widget.appointmentId);
            }
            Navigator.pop(context, "next");
          },
          child: Text("Weiter"),
        )
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: allValues.map(
          (e) {
            return RadioListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              title: Text(e),
              value: e,
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
