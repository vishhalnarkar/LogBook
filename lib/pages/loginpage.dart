import "dart:developer";

import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:logbook/auth/authMethods.dart";
import "package:logbook/auth/auth_service.dart";
import "package:logbook/components/my_button.dart";
import "package:logbook/components/my_textField.dart";
import "package:logbook/pages/datapage.dart";
import "package:logbook/pages/registerPage.dart";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _auth = FirebaseAuth.instance;

  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose(){
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  _login() async {

    String res = await AuthMethods().logInUser(mail: emailController.text, password: passwordController.text);
    if (context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const DataDisp()),
        );
      }
    
    log(res);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
          ),
          backgroundColor: Color(0xFF252525),
          title: const Text(
            "Logbook",
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 24, color: Colors.white),
          ),
        ),
        backgroundColor: Color(0xFF010101),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Login",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFD9D9D9)),
                ),
                SizedBox(
                  height: 50,
                ),
                MyTextField(
                  controller: emailController,
                  hintText: "Email",
                  obsecureText: false,
                ),
                SizedBox(
                  height: 25,
                ),
                MyTextField(
                  controller: passwordController,
                  hintText: "Password",
                  obsecureText: true,
                ),
                SizedBox(
                  height: 25,
                ),
                MyButton(
                  controller: "Sign in",
                  onTap: _login,
                ),
              ],
            ),
          ),
        ));
  }
}
