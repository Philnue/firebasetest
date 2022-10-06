import 'package:firebasetest/MaterialView/widgetUtils/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_email_password_screen.dart';
import 'signup_email_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  "Herzlich Wilkommen!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  "Sie befinden sich in der Hirschböög-App",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomButton(
                onTap: () {
                  Navigator.pushNamed(context, EmailPasswordSignup.routeName);
                },
                text: 'Mit Email/Passwort registrieren',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomButton(
                onTap: () {
                  Navigator.pushNamed(context, EmailPasswordLogin.routeName);
                },
                text: 'Mit Email/Passwort einloggen',
              ),
            ),
            // CustomButton(
            //   onTap: () {
            //     context.read<FirebaseAuthMethods>().signInAnonymously(context);
            //   },
            //   text: 'Anonymous Sign In',
            // ),
          ],
        ),
      ),
    );
  }
}
