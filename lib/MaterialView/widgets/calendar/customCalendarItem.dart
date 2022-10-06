import 'package:firebasetest/MaterialView/widgets/calendar/selectedCalendarItem.dart';
import 'package:firebasetest/utils/Models/appointment.dart';
import 'package:firebasetest/utils/format.dart';
import 'package:firebasetest/utils/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalendarItem extends StatelessWidget {
  const CalendarItem({Key? key, required this.terminTerminAbstimmung})
      : super(key: key);

  final Appointment terminTerminAbstimmung;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          tileColor: Colors.white,
          leading: CircleAvatar(
            backgroundColor: Format.getCupertinoColorsForEntscheidung(
                terminTerminAbstimmung.ownEntscheidung),
            radius: 30,
            child: Padding(
                //Links Datumsanzeige
                padding: const EdgeInsets.all(2),
                child: terminTerminAbstimmung.getDateCorrectly.length == 10
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            Constants.months[int.parse(terminTerminAbstimmung
                                    .getDateCorrectly
                                    .substring(3, 5)) -
                                1],
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: CupertinoColors.darkBackgroundGray),
                          ),
                          Text(
                            terminTerminAbstimmung.getDateCorrectly
                                .substring(0, 2),
                            //actTermin.getDateCorrectly,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: CupertinoColors.darkBackgroundGray),
                          ),
                        ],
                      )
                    : Text(
                        terminTerminAbstimmung.getDateCorrectly,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: CupertinoColors.darkBackgroundGray),
                        textAlign: TextAlign.center,
                      )),
          ),
          title: Text(
            //Mittler Text Name
            terminTerminAbstimmung.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 21,
              color: CupertinoColors.darkBackgroundGray,
            ),
          ),
          subtitle: SizedBox(
            //Texte unterhalb des Names
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  terminTerminAbstimmung.meetingPoint,
                  style: (TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => SelectedCalendarItem(
                        terminA: terminTerminAbstimmung,
                      )),
            );
          },
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //year

              const Icon(
                CupertinoIcons.time,

                color: CupertinoColors.darkBackgroundGray,
                size: 30, //30
              ),
              Text(
                terminTerminAbstimmung.timeAsString,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: CupertinoColors.darkBackgroundGray,
                ),
              ),
            ],
          ),
        ),
      ),
      //),
    );
  }
}
