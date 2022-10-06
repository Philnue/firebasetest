import 'dart:ui';


import 'package:firebasetest/MaterialView/widgetUtils/customAppBar.dart';
import 'package:firebasetest/MaterialView/widgetUtils/newDrawer.dart';
import 'package:firebasetest/MaterialView/widgets/aemter/newAemterItem.dart';
import 'package:firebasetest/utils/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AemterView extends StatelessWidget {
  const AemterView({Key? key}) : super(key: key);

  static final routeName = "/aemterview";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: "ÄmterAnsicht",
      ),
      drawer: NewDrawer(),
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Column(children: [
            Expanded(
              child: ListView.builder(
                  itemCount: Constants.aemterMap.length,
                  itemBuilder: (context, index) {
                    return NewAemterItem(
                        left: Constants.aemterMap[index]["Amt"],
                        right: Constants.aemterMap[index]["Name"]);
                  }),
            ),
          ]),
        ),
      ),
    );
  }
}
