import 'dart:io';


import 'package:firebasetest/MaterialView/widgetUtils/newDrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QRView extends StatefulWidget {
  const QRView({Key? key}) : super(key: key);
  static const routeName = '/qrPage';
  @override
  State<QRView> createState() => _QrPageState();
}

class _QrPageState extends State<QRView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NewDrawer(),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              //alignment: Alignment.center,
              children: [
                Image.asset("images/insta.PNG"),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "hirschboeoeg1987@web.de",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
