 
import 'package:firebasetest/MaterialView/widgets/calendar/selectedCalendarItem.dart';
import 'package:firebasetest/utils/Models/appointment.dart';
import 'package:firebasetest/utils/format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalendarItem extends StatelessWidget {
  const CalendarItem({Key? key, required this.termin}) : super(key: key);

  final Appointment termin;

  Widget get nameWidget {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Text(
        termin.name,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget get timeanddatewiget {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(Icons.schedule),
          SizedBox(width: 5),
          Text(
            termin.timeAsString,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          SizedBox(width: 10),
          Icon(Icons.calendar_month),
          SizedBox(width: 5),
          Text(
            termin.getDateCorrectly,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget get placeWidget {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(Icons.place),
          SizedBox(width: 5),
          Text(
            termin.place,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      child: Card(
          color:
              Format.getCupertinoColorsForEntscheidung(termin.ownEntscheidung)
                  .withOpacity(0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => SelectedCalendarItem(
                          terminA: termin,
                        )),
              );
            },
            child: Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                  top: 10,
                  bottom: 10,
                  right: 5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    nameWidget,
                    SizedBox(
                      height: 5,
                    ),
                    timeanddatewiget,
                    SizedBox(
                      height: 5,
                    ),
                    placeWidget,
                  ],
                ),
              ),
            ),
          )),
      //),
    );
  }
}
