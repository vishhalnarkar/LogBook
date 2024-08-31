import "package:flutter/material.dart";
import "package:logbook/components/my_button.dart";
import "package:logbook/components/my_textField.dart";
import "package:logbook/pages/LoginPage.dart";
import "package:logbook/pages/registerPage.dart";

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF252525),
          title: const Center(
              child: Text(
            "Logbook",
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 24, color: Colors.white),
          )),
        ),
        backgroundColor: Color(0xFF010101),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Welcome",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFD9D9D9)),
                ),
                SizedBox(height: 50),
                MyButton(
                  controller: "Sign in",
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LoginPage()));
                  },
                ),
                SizedBox(height: 25),
                MyButton(
                  controller: "Register",
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const RegisterPage()));
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
