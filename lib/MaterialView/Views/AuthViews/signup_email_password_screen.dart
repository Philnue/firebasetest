import 'package:firebasetest/MaterialView/widgetUtils/custom_textfield.dart';
import 'package:firebasetest/MaterialView/widgets/calendar/cupertinoActionSheetCustom.dart';
import 'package:firebasetest/MaterialView/widgets/cupertinoAlertDialogCustom.dart';
import 'package:firebasetest/utils/Models/member.dart';
import 'package:firebasetest/utils/firebaseUtils/firebase_auth_methods.dart';
import 'package:firebasetest/utils/shared/constants.dart';
import 'package:firebasetest/utils/shared/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmailPasswordSignup extends StatefulWidget {
  static String routeName = '/signup-email-password';
  const EmailPasswordSignup({Key? key}) : super(key: key);

  @override
  _EmailPasswordSignupState createState() => _EmailPasswordSignupState();
}

class _EmailPasswordSignupState extends State<EmailPasswordSignup> {
  int? _valueBirthdayState = 0;
  final TextEditingController licenseController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController forenameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  void signUpUser() async {
    context.read<FirebaseAuthMethods>().signUpWithEmail(
          email: emailController.text,
          password: passwordController.text,
          context: context,
          license: licenseController.text,
          firstname: forenameController.text,
          lastname: lastnameController.text,
          birthdDay: dateTime,
          birthdayShowState: BirthdayShowState.values[_valueBirthdayState!],
        );
  }

  double _kPickerSheetHeight = 216.0;
  Widget _buildBottomPicker(Widget picker) {
    return Container(
      height: _kPickerSheetHeight,
      padding: const EdgeInsets.only(top: 6.0),
      color: Colors.transparent.withOpacity(1),
      child: DefaultTextStyle(
        style: const TextStyle(
          color: CupertinoColors.black,
          fontSize: 22.0,
        ),
        child: GestureDetector(
          // Blocks taps from propagating to the modal sheet and popping.
          onTap: () {},
          child: SafeArea(
            top: false,
            child: picker,
          ),
        ),
      ),
    );
  }

  DateTime dateTime = DateTime.now();
  DateTime dateTimeInitValue = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Registrieren",
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.08),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              controller: licenseController,
              hintText: 'Aktivierungsschlüssel',
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              controller: emailController,
              hintText: 'E-Mail eingeben',
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: MaterialButton(
              child: Text(
                  " Gebutstag auswählen: ${dateTime.day}.${dateTime.month}.${dateTime.year}"),
              onPressed: () {
                showCupertinoModalPopup<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return _buildBottomPicker(
                      CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        dateOrder: DatePickerDateOrder.dmy,
                        backgroundColor: Colors.transparent,
                        initialDateTime: dateTime,
                        onDateTimeChanged: (DateTime newDateTime) {
                          if (mounted) {
                            setState(() => dateTime = newDateTime);
                          }
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Text(("Wie sollen die anderen ihr Geburtstag sehen ?")),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: SingleChildScrollView(
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
                          setState(() {
                            _valueBirthdayState = index;
                          });
                          print(BirthdayShowState.values[index]);
                        },
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 5),
                  child: CustomTextField(
                    controller: forenameController,
                    hintText: 'Vorname',
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20, left: 5),
                  child: CustomTextField(
                    controller: lastnameController,
                    hintText: 'Nachname',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              controller: passwordController,
              hintText: 'Passwort',
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: signUpUser,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              textStyle: MaterialStateProperty.all(
                const TextStyle(color: Colors.white),
              ),
              minimumSize: MaterialStateProperty.all(
                Size(MediaQuery.of(context).size.width / 2.5, 50),
              ),
            ),
            child: const Text(
              "Registrieren",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
