import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasetest/utils/Api/mitglied.api.dart';
import 'package:firebasetest/utils/Models/member.dart';
import 'package:firebasetest/utils/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PermissionsWidgetBirthdayState extends StatefulWidget {
  const PermissionsWidgetBirthdayState({super.key, required this.user});

  final Member user;

  @override
  State<PermissionsWidgetBirthdayState> createState() =>
      _PermissionsWidgetBirthdayStateState();
}

class _PermissionsWidgetBirthdayStateState
    extends State<PermissionsWidgetBirthdayState> {
  int? _valueBirthdayState = 0;

  @override
  void initState() {
    // TODO: implement initState
    _valueBirthdayState = widget.user.birthdayData.showValue.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Geburtstagsansicht für Andere",
          style: TextStyle(fontSize: 16),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Wrap(
            children: List<Widget>.generate(
              Constants.choiceChipsTextsBirthday.length,
              (int index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: ChoiceChip(
                    selectedColor: Colors.lightBlue,
                    selectedShadowColor: Colors.amberAccent,
                    label: Text(Constants.choiceChipsTextsBirthday[index]),
                    selected: _valueBirthdayState == index,
                    onSelected: (bool selected) {
                      if (index != _valueBirthdayState) {
                        setState(() {
                          _valueBirthdayState = index;
                          print(BirthdayShowState.values[index]);

                          MitgliedApi.updateCustomUserData({
                            "birthDayShowState":
                                BirthdayShowState.values[index].name
                          }, Constants.currentUser.uid);
                        });
                      }
                    },
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }
}
