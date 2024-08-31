import "dart:developer";

import "package:flutter/material.dart";
import "package:logbook/auth/authMethods.dart";
import "package:logbook/auth/auth_service.dart";
import "package:logbook/components/my_button.dart";
import "package:logbook/pages/datapage.dart";

import "../components/my_textField.dart";

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _auth = AuthService();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  _registerUser() async {
    String res = await AuthMethods().signUpUser(
        mail: emailController.text,
        password: passwordController.text,
        username: nameController.text);
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
                  "Register",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFD9D9D9)),
                ),
                SizedBox(
                  height: 50,
                ),
                MyTextField(
                  controller: nameController,
                  hintText: "Username",
                  obsecureText: false,
                ),
                SizedBox(
                  height: 25,
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
                  controller: "Register",
                  onTap: _registerUser,
                ),
              ],
            ),
          ),
        ));
  }
}
