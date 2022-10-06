import 'package:firebasetest/MaterialView/widgetUtils/customAppBar.dart';
import 'package:firebasetest/MaterialView/widgets/admin/adminInfoWidget.dart';
import 'package:firebasetest/utils/Models/AdminViewArguments.dart';
import 'package:firebasetest/utils/Models/memberDecision.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class AdminView extends StatefulWidget {
  const AdminView({Key? key}) : super(key: key);

  static const routeName = '/adminView';

  @override
  State<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  bool isLoading = true;
  bool madeFirst = false;

  bool initValue = false;

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as AdminViewArguments;

    final list = args.memberDecisionList;

    // load(args);
    return Scaffold(
      appBar: CustomAppBar(text: "Mitgliederansicht", withBackButton: true),
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Passivmitglieder mitzählen",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              CupertinoSwitch(
                  value: initValue,
                  onChanged: (value) {
                    setState(() {
                      initValue = value;
                    });
                  }),
            ],
          ),
          Expanded(
            child: AdminInfoWidget(
              list: list,
              withPassive: initValue,
              withAppendix: args.withAppendix,
            ),
          ),
        ],
      )),
    );
  }
}
