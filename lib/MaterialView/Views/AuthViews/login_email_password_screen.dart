import 'package:firebasetest/MaterialView/widgetUtils/custom_textfield.dart';
import 'package:firebasetest/utils/firebaseUtils/firebase_auth_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:provider/provider.dart';

class EmailPasswordLogin extends ConsumerWidget {
  static String routeName = '/login-email-password';
  EmailPasswordLogin({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRef = ref.watch(authProvider);
    void loginUser() {
      // ref.read<FirebaseAuthMethods>(authRef).loginWithEmail(
      //       email: emailController.text,
      //       password: passwordController.text,
      //       context: context,
      //     );

      FirebaseAuthMethods(authRef).loginWithEmail(
          email: emailController.text,
          password: passwordController.text,
          context: context);
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Einloggen",
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.08),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              controller: emailController,
              hintText: 'E-Mail eingeben',
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              controller: passwordController,
              hintText: 'Passwort eingeben',
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: loginUser,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              textStyle: MaterialStateProperty.all(
                const TextStyle(color: Colors.white),
              ),
              minimumSize: MaterialStateProperty.all(
                Size(MediaQuery.of(context).size.width / 2.5, 50),
              ),
            ),
            child: const Text(
              "Einloggen",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
