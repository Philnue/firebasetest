import 'dart:io';

import 'package:firebasetest/MaterialView/widgets/cupertinoAlertDialogCustom.dart';
import 'package:firebasetest/utils/Models/memberDecision.dart';
import 'package:firebasetest/utils/format.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

class FileHelper {
  static String getSummary(List<MemberDecision> initList, String name) {
    String header = "Name: $name";

    var kommen =
        initList.where((element) => element.entscheidung == 1).toList();
    var kommenNicht =
        initList.where((element) => element.entscheidung == 2).toList();
    var kommenKeineA =
        initList.where((element) => element.entscheidung == 0).toList();

    String kommenString = "Kommen: ${kommen.length}";
    String kommenNichtString = "Kommen nicht: ${kommenNicht.length}";
    String keineAntwortString = "Keine Antwort: ${kommenKeineA.length}";

    kommen.forEach((element) {
      kommenString +=
          "\n    ${element.mitglied.fullname} ${Format.passiveText(element.mitglied.isPassiveAsString)}";
    });
    kommenNicht.forEach((element) {
      kommenNichtString +=
          "\n    ${element.mitglied.fullname} ${Format.passiveText(element.mitglied.isPassiveAsString)}";
    });
    kommenKeineA.forEach((element) {
      keineAntwortString +=
          "\n    ${element.mitglied.fullname} ${Format.passiveText(element.mitglied.isPassiveAsString)}";
    });

    return "$header\n\n$kommenString\n\n$kommenNichtString\n\n$keineAntwortString";
  }

  static Future<void> writeSummaryFile(
    BuildContext context,
    String name,
    List<MemberDecision> initList
  ) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    print(directory.path);
    final File file = File('${directory.path}/$name');
    await file
        .writeAsString(getSummary(initList, name))
        .then((value) => CupertinoAlertDialogCustom.showAlertDialog(
              context,
              "Exportieren der Daten erfolgreich",
              "Pfad ${file.path}",
              [
                CupertinoDialogAction(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));

    //var ml = await _localPath;
  }
}
