import 'dart:ui';

import 'package:firebasetest/MaterialView/widgetUtils/customAppBar.dart';
import 'package:firebasetest/MaterialView/widgetUtils/customDrawer.darzzt';
import 'package:firebasetest/utils/shared/roleHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class PollView extends StatelessWidget {
  const PollView({Key? key}) : super(key: key);

  static final routeName = "/pollView";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: "Abstimmung",
      ),
      drawer: CustomDrawer(),
      extendBodyBehindAppBar: true,
      extendBody: true,
      floatingActionButton: RoleHelper.hasRights(AllRoles.admin)
          ? FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.add),
            )
          : null,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Column(children: [
              // SizedBox(
              //   height: 120,
              // ),

              Text(DateTime.now().toString()),
            ]),
          ),
        ),
      ),
    );
  }
}
