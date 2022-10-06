import 'package:firebasetest/MaterialView/widgetUtils/customAppBar.dart';
import 'package:firebasetest/MaterialView/widgets/addOrEditCalendarEntry/calendarEntryEdit.dart';
import 'package:firebasetest/utils/Api/termin.api.dart';
import 'package:firebasetest/utils/Models/appointment.dart';
import 'package:firebasetest/utils/shared/roleHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class EditCalendarEntryViewNew extends StatefulWidget {
  const EditCalendarEntryViewNew({super.key});
  static const routeName = '/calendarEntryNew';

  @override
  State<EditCalendarEntryViewNew> createState() =>
      _EditCalendarEntryViewNewState();
}

class _EditCalendarEntryViewNewState extends State<EditCalendarEntryViewNew> {
  TextEditingController nameController = TextEditingController();
  TextEditingController adresseController = TextEditingController();
  TextEditingController notizenController = TextEditingController();
  TextEditingController treffPunktController = TextEditingController();
  TextEditingController kleidungController = TextEditingController();
  DateTime getTP(DateTime val) {
    return val.add(Duration(minutes: 15 - val.minute % 15));
  }

  bool madefirst = false;
  bool withAppendix = false;

  DateTime minDate = DateTime.now();
  DateTime deadline = DateTime.now();
  DateTime currentTime = DateTime.now();
  DateTime currentDate = DateTime.now();
  DateTime initVal = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Appointment;

    if (madefirst == false) {
      withAppendix = args.withAppendix;

      nameController.text = args.name;
      adresseController.text = args.place;
      notizenController.text = args.notes;
      treffPunktController.text = args.meetingPoint;
      kleidungController.text = args.clothing;

      minDate = getTP(DateTime.now());
      deadline = args.deadline;
      currentTime = args.time;
      currentDate = args.time;
      initVal = args.time;

      madefirst = true;
    }

    return Scaffold(
      appBar: CustomAppBar(
        text: "Termin bearbeiten",
        withBackButton: true,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
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
                  minimumDate: DateTime.now().subtract(Duration(days: 30 * 12)),
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: deadline,
                  onDateTimeChanged: (value) {
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
                var calcTime = DateTime(currentDate.year, currentDate.month,
                    currentDate.day, currentTime.hour, currentTime.minute);
                print("deadline");
                Map<String, dynamic> newMap = {
                  "adresse": adresseController.text,
                  "kleidung": kleidungController.text,
                  "name": nameController.text,
                  "notizen": notizenController.text,
                  "treffpunkt": treffPunktController.text,
                  "zeitpunkt": calcTime,
                  "withAppendix": withAppendix,
                  "deadline": deadline,
                };
                var updatedMap = args.compareMap(newMap);

                if (updatedMap.isEmpty == true) {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) => CupertinoAlertDialog(
                      title: Text("Es wurden keine Änderungen durchgeführt"),
                      content: Text(
                          "Bitte ändern sie erst Daten bevor sie Änderungen speichern wollen"),
                      actions: [
                        CupertinoDialogAction(
                          /// This parameter indicates this action is the default,
                          /// and turns the action's text to bold text.
                          isDefaultAction: true,
                          onPressed: () {
                            Navigator.pop(context, "no");
                          },
                          child: const Text('Nein'),
                        ),
                      ],
                    ),
                  );
                } else {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) => CupertinoAlertDialog(
                      title: Text("Update durchführen"),
                      content: Text(updatedMap.toString()),
                      actions: [
                        CupertinoDialogAction(
                          isDefaultAction: true,
                          onPressed: () {
                            Navigator.pop(context, "no");
                          },
                          child: const Text('Nein'),
                        ),
                        CupertinoDialogAction(
                          isDestructiveAction: true,
                          onPressed: () {
                            TerminApi.updateTermin(args.id, updatedMap);
                            Navigator.pop(context, "yes");
                          },
                          child: const Text('Ja'),
                        )
                      ],
                    ),
                  ).then((value) {
                    if (value == "yes" || value == "no") {
                      Navigator.of(context).pop();
                    }
                  });
                }
              },
              child: Text(
                "Kalendereintrag ändern",
                style: TextStyle(color: CupertinoColors.white, fontSize: 16),
              ),
            ),
            RoleHelper.hasRights(AllRoles.coAdmin)
                ? ElevatedButton(
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
                      showCupertinoModalPopup(
                        context: context,
                        builder: (BuildContext context) => CupertinoAlertDialog(
                          title: Text("Termin löschen"),
                          content: Text(
                              "Wollen sie den Termin ${args.name} wirklich löschen"),
                          actions: [
                            CupertinoDialogAction(
                              isDefaultAction: true,
                              onPressed: () {
                                Navigator.pop(context, "Nein");
                              },
                              child: const Text('Nein'),
                            ),
                            CupertinoDialogAction(
                              isDestructiveAction: true,
                              onPressed: () {
                                Navigator.pop(context, "Ja");
                              },
                              child: const Text('Ja'),
                            )
                          ],
                        ),
                      ).then(
                        (value) {
                          if (value == "yes") {
                            TerminApi.deleteTermin(args.id);
                            Navigator.of(context).pop();
                          }
                        },
                      );
                    },
                    child: Text(
                      "Kalendereintrag löschen",
                      style:
                          TextStyle(color: CupertinoColors.white, fontSize: 16),
                    ),
                  )
                : Container(),
          ],
        ),
      )),
    );
  }
}
