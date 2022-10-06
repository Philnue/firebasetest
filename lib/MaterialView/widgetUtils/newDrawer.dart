import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetest/MaterialView/Views/DrawerViews/aboutView.dart';
import 'package:firebasetest/MaterialView/Views/DrawerViews/qRView.dart';
import 'package:firebasetest/MaterialView/Views/DrawerViews/settingsView.dart';
import 'package:firebasetest/utils/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class NewDrawer extends StatefulWidget {
  const NewDrawer({Key? key}) : super(key: key);

  @override
  State<NewDrawer> createState() => _NewDrawerState();
}

class _NewDrawerState extends State<NewDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      //child: ListView.separated(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              children: [
                Text(
                  '${Constants.currentUser.fullname}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                Text("N: ${Constants.currentUser.license.name}"),
                Text(
                  Constants.currentUser.role.name.toUpperCase(),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('EINSTELLUNGEN'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(SettingsView.routeName);
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.qr_code),
          //   title: Text('QR-Code'),
          //   onTap: () {
          //     // Navigator.of(context).pop();
          //     // Navigator.of(context).pushNamed(NewQRView.routeName);
          //   },
          // ),
          // ListTile(
          //   leading: Icon(Icons.data_array),
          //   title: Text('CliquenDaten'),
          // ),
          // ListTile(
          //   leading: Icon(Icons.info),
          //   title: Text('INFO'),
          // ),
          ListTile(
            leading: Icon(Icons.message),
            title: Text('ABOUT'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(AboutView.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('LOGOUT'),
            onTap: () {
              setState(() {
                FirebaseAuth.instance.signOut();
              });
            },
          ),
        ],
      ),
    );
  }
}
