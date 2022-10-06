import 'package:firebasetest/MaterialView/widgetUtils/customAppBar.dart';
import 'package:firebasetest/MaterialView/widgets/permissionsWidgets/PermissionsWidgetActivePassive.dart';
import 'package:firebasetest/MaterialView/widgets/permissionsWidgets/PermissionsWidgetMultiLine.dart';
import 'package:firebasetest/MaterialView/widgets/permissionsWidgets/PermissionsWidgetRoles.dart';
import 'package:firebasetest/MaterialView/widgets/mitgliedInfo/mitgliedPageInfoItem.dart';
import 'package:firebasetest/utils/Models/member.dart';
import 'package:firebasetest/utils/shared/constants.dart';
import 'package:firebasetest/utils/shared/roleHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MitgliedInfoView extends StatelessWidget {
  static final routeName = "/mitgliedInfoView";
  const MitgliedInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Member;

    String getAlter() {
      String returnString = "";

      if (args.birthdayData.showValue == BirthdayShowState.full) {
        DateTime dt = DateTime(
            DateTime.now().year,
            args.birthdayData.birthdayAsDateTime.month,
            args.birthdayData.birthdayAsDateTime.day);

        if (dt.isAfter(DateTime.now())) {
          //

          int old =
              DateTime.now().year - args.birthdayData.birthdayAsDateTime.year;
          returnString = "wird $old";
        } else {
          int old =
              DateTime.now().year - args.birthdayData.birthdayAsDateTime.year;
          returnString = "ist $old";
        }
      }

      return returnString;
    }

    Widget getSizedBoxAndDivider() {
      return Column(
        children: const [
          SizedBox(
            height: 10,
          ),
          Divider(
            color: CupertinoColors.systemGrey,
            thickness: 2,
            endIndent: 40,
            indent: 40,
          ),
          // MitgliedPageInfoItem(
          //     firstValue: "Nachname:", secondValue: args.lastname),
          SizedBox(
            height: 10,
          ),
        ],
      );
    }

    bool hasPermissionsToSee() {
      if (RoleHelper.hasRights(AllRoles.coAdmin) &&
          Constants.currentUser.uid != args.uid) {
        return true;
      } else {
        return false;
      }
    }

    return Scaffold(
      appBar: CustomAppBar(text: args.getName, withBackButton: true),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            hasPermissionsToSee() == true
                ? PermissionsWidgetRoles(user: args)
                : Container(),
            hasPermissionsToSee() == true
                ? PermissionsWidgetActivePassive(user: args)
                : Container(),
            getSizedBoxAndDivider(),
            MitgliedPageInfoItem(
                firstValue: "Name:", secondValue: args.fullname),
            getSizedBoxAndDivider(),
            MitgliedPageInfoItem(
                firstValue: "Geburtstag: ${getAlter()}",
                secondValue: args.birthdayData.birthDayAfterState),
            getSizedBoxAndDivider(),
            MitgliedPageInfoItem(
                firstValue: "Passivmitglied:",
                secondValue: args.isPassiveAsString),
            getSizedBoxAndDivider(),
            args.shortname != ""
                ? Column(
                    children: [
                      MitgliedPageInfoItem(
                          firstValue: "Spitzname:",
                          secondValue: args.shortname),
                      getSizedBoxAndDivider(),
                    ],
                  )
                : Center(),
            args.hasPermission("admin") == true
                ? MitgliedPageInfoItem(
                    firstValue: "Vorstand:", secondValue: "Ja")
                : Center(),
          ],
        ),
      ),
    );
  }
}
