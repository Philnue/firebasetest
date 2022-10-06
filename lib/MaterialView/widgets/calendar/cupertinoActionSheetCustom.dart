import 'package:flutter/cupertino.dart';

class CupertinoActionSheetCustom extends StatefulWidget {
  const CupertinoActionSheetCustom({Key? key}) : super(key: key);

  @override
  State<CupertinoActionSheetCustom> createState() =>
      _CupertinoActionSheetCustomState();
}

class _CupertinoActionSheetCustomState
    extends State<CupertinoActionSheetCustom> {
  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: const Text("Zusage"),
      message: const Text("Kommst du zum Termin "),
      actions: [
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context, "add");
          },
          child: const Text("Ich komme"),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context, "delete");
          },
          child: const Text("Ich komme nicht"),
          isDestructiveAction: true,
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: () {
          Navigator.pop(context, "cancel");
        },
        child: const Text("Abbrechen"),
        isDefaultAction: true,
      ),
    );
  }
}
