import 'package:firebasetest/MaterialView/widgetUtils/customMaterialTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CalendarEntryEdit extends StatefulWidget {
  const CalendarEntryEdit({
    super.key,
    required this.nameController,
    required this.adresseController,
    required this.kleidungController,
    required this.notizenController,
    required this.treffPunktController,
  });

  final TextEditingController nameController;
  final TextEditingController adresseController;
  final TextEditingController kleidungController;
  final TextEditingController notizenController;
  final TextEditingController treffPunktController;

  @override
  State<CalendarEntryEdit> createState() => _CalendarEntryEditState();
}

class _CalendarEntryEditState extends State<CalendarEntryEdit> {
  final minDate = DateTime.now();

  late DateTime currentTime = currentTime;
  late DateTime currentDate = currentTime;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomMaterialTextField(
              controller: widget.nameController,
              hintText: 'Termin Name',
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomMaterialTextField(
              controller: widget.adresseController,
              hintText: 'Adresse',
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomMaterialTextField(
              controller: widget.kleidungController,
              hintText: 'Kleidung',
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomMaterialTextField(
              controller: widget.notizenController,
              hintText: 'Notizen',
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomMaterialTextField(
              controller: widget.treffPunktController,
              hintText: 'Treffpunkt',
            ),
          ),

          // Row(
          //   children: [
          //     Expanded(
          //       flex: 3,
          //       child: SizedBox(
          //         height: 100,
          //         child: CupertinoDatePicker(
          //           use24hFormat: true,
          //           minimumDate: minDate,
          //           minuteInterval: 15,
          //           mode: CupertinoDatePickerMode.date,
          //           initialDateTime: widget.initVal,
          //           onDateTimeChanged: (value) {
          //             print("DatePicker ${value.toString()}");
          //             widget.currentDate = value;
          //           },
          //         ),
          //       ),
          //     ),
          //     Expanded(
          //       flex: 2,
          //       child: SizedBox(
          //         height: 100,
          //         child: CupertinoDatePicker(
          //           use24hFormat: true,
          //           minuteInterval: 15,
          //           mode: CupertinoDatePickerMode.time,
          //           initialDateTime: widget.initVal,
          //           onDateTimeChanged: (value) {
          //             print("TimePicker ${value.toString()}");
          //             widget.currentTime = value;
          //           },
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          // Container(
          //   color: Colors.black.withOpacity(0.2),
          //   child: SizedBox(
          //     height: 100,
          //     child: CupertinoDatePicker(
          //       use24hFormat: true,
          //       minimumDate: minDate,
          //       minuteInterval: 15,
          //       mode: CupertinoDatePickerMode.dateAndTime,
          //       initialDateTime: widget.initVal,
          //       onDateTimeChanged: (value) {
          //         widget.currentTime = value;
          //       },
          //     ),
          //   ),
          // ),
          // Text("Ablaufdatum"),
          // Container(
          //   color: Colors.black.withOpacity(0.2),
          //   child: SizedBox(
          //     height: 100,
          //     child: CupertinoDatePicker(
          //       use24hFormat: true,
          //       minimumDate: minDate,
          //       minuteInterval: 15,
          //       mode: CupertinoDatePickerMode.date,
          //       initialDateTime: widget.initVal,
          //       onDateTimeChanged: (value) {
          //         print(value);
          //         widget.deadline = value;
          //       },
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
