
import 'package:firebasetest/MaterialView/widgetUtils/customAppBar.dart';
import 'package:firebasetest/utils/showSnackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutView extends StatelessWidget {
  const AboutView({Key? key}) : super(key: key);
  static const routeName = "/AboutView";
  @override
  Widget build(BuildContext context) {
    final Uri _url =
        Uri.parse('mailto:smith@example.org?subject=News&body=New%20plugin');

    Future<void> _launchUrlt() async {
      print("start");
      if (await launchUrl(_url)) {
        throw 'Could not launch $_url';
      }
    }

    return Scaffold(
      appBar: CustomAppBar(text: "About", withBackButton: true),
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          const Text(
            "Infos zum Entwicker:",
            style: TextStyle(fontSize: 20),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: const Text(
              "Fragen, Verbesserungsvorschläge, Probleme bitte an diese Mail schicken",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          MaterialButton(
            child: Text("philipp@nutline-dev.de"),
            color: Colors.blue,
            onPressed: () {
              _launchUrlt();
            },
          ),
          SizedBox(
            height: 20,
          ),
          MaterialButton(
            child: Text("E-Mail kopieren"),
            color: Colors.blue,
            onPressed: () {
              Clipboard.setData(
                ClipboardData(text: "philipp@nutline-dev.de"),
              );

              showSnackBar(
                  context, "E-Mail wurde in die Zwischenablage kopiert!");
            },
          ),
          SizedBox(
            height: 20,
          ),
          Divider(
            color: Colors.grey,
            thickness: 2,
          ),
          const Text("Entwickelt von Philipp Nüßlein"),
        ],
      )),
    );
  }
}
