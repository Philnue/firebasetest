import 'package:firebasetest/MaterialView/widgetUtils/customAppBar.dart';
import 'package:firebasetest/MaterialView/widgets/addOrEditCalendarEntry/calendarEntryEdit.dart';
import 'package:firebasetest/utils/Api/termin.api.dart';
import 'package:firebasetest/utils/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddCalendarEntryView extends StatefulWidget {
  const AddCalendarEntryView({super.key});
  static const routeName = '/calendarEntry';

  @override
  State<AddCalendarEntryView> createState() => _AddCalendarEntryViewState();
}

class _AddCalendarEntryViewState extends State<AddCalendarEntryView> {
  final TextEditingController nameController = TextEditingController(text: "");
  final TextEditingController zeitpunktController =
      TextEditingController(text: "");
  final TextEditingController adresseController =
      TextEditingController(text: "");
  final TextEditingController notizenController =
      TextEditingController(text: "");
  final TextEditingController treffPunktController =
      TextEditingController(text: "");
  final TextEditingController kleidungController =
      TextEditingController(text: "");

  late DateTime currentTime;
  late DateTime currentDate;
  late DateTime testVal;
  late DateTime initVal;

  bool firstStart = false;

  bool withAppendix = false;
  late DateTime deadline;
  DateTime getTP(DateTime val) {
    return val.add(Duration(minutes: 15 - val.minute % 15));
  }

  void addTermin() {
    var calcTime = DateTime(currentDate.year, currentDate.month,
        currentDate.day, currentTime.hour, currentTime.minute);

    TerminApi.addTermin({
      "adresse": adresseController.text,
      "kleidung": kleidungController.text,
      "name": nameController.text,
      "notizen": notizenController.text,
      "treffpunkt": treffPunktController.text,
      "zeitpunkt": calcTime,
      "ersteller": Constants.currentUser.fullname,
      "deadline": deadline,
      "withAppendix": withAppendix,
      "licenseShortPrefix": Constants.currentUser.license.shortPrefix,
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    currentTime = DateTime.now();
    currentDate = DateTime.now();

    initVal = getTP(DateTime.now());
    deadline = getTP(DateTime.now());

    firstStart = true;
    super.initState();
  }

  final minDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: "Termin hinzufügen",
        withBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CalendarEntryEdit(
              nameController: nameController,
              adresseController: adresseController,
              kleidungController: kleidungController,
              notizenController: notizenController,
              treffPunktController: treffPunktController,
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Anhang erwünscht"),
                Switch(
                  value: withAppendix,
                  onChanged: (value) {
                    print("Appendi $value");
                    setState(() {
                      withAppendix = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    height: 100,
                    child: CupertinoDatePicker(
                      use24hFormat: true,
                      minimumDate: minDate,
                      minuteInterval: 15,
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: initVal,
                      onDateTimeChanged: (value) {
                        print("DatePicker ${value.toString()}");
                        currentDate = value;
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 100,
                    child: CupertinoDatePicker(
                      use24hFormat: true,
                      minuteInterval: 15,
                      mode: CupertinoDatePickerMode.time,
                      initialDateTime: initVal,
                      onDateTimeChanged: (value) {
                        print("TimePicker ${value.toString()}");
                        currentTime = value;
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text("Anmeldeschluss"),
            const SizedBox(height: 20),
            Container(
              color: Colors.black.withOpacity(0.2),
              child: SizedBox(
                height: 100,
                child: CupertinoDatePicker(
                  use24hFormat: true,
                  minimumDate: minDate,
                  minuteInterval: 15,
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: initVal,
                  onDateTimeChanged: (value) {
                    print(value);
                    deadline = value;
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                textStyle: MaterialStateProperty.all(
                  const TextStyle(color: Colors.white),
                ),
                minimumSize: MaterialStateProperty.all(
                  Size(MediaQuery.of(context).size.width / 2.5, 50),
                ),
              ),
              onPressed: () {
                if (nameController.text != "" &&
                    adresseController.text != "" &&
                    kleidungController.text != "" &&
                    treffPunktController.text != "") {
                  addTermin();
                }

                Navigator.of(context).pop();
                //! schließen
              },
              child: Text(
                "Kalendereintrag Hinzufügen",
                style: TextStyle(color: CupertinoColors.white, fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}
