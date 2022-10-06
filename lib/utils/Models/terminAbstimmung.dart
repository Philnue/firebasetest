import 'package:firebasetest/utils/Models/member.dart';
import 'package:firebasetest/utils/Models/appointment.dart';

class TerminAbstimmung {
  TerminAbstimmung({
    required this.termin,
    required this.mitglied,
    required this.entscheidung,
  });

  factory TerminAbstimmung.fromJson(dynamic json) {
    var mitglied = null;

    var termin = null;

    return TerminAbstimmung(
      entscheidung: json["entscheidung"],
      termin: termin,
      mitglied: mitglied,
    );
  }

  final int entscheidung;
  final Member mitglied;
  final Appointment termin;

  
}
