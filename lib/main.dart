import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logbook/pages/datapage.dart';
import 'package:logbook/pages/welcome.dart';
import 'package:logbook/pages/loginpage.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  
 WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDnkXajGO_vw2uv8yz3r3XuouArR3J6kgY",
      appId: "1:246520953983:android:559698b58e491f06ad934a",
      messagingSenderId: "246520953983",
      projectId: "logbook-66c98",
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const DataDisp();
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            return const WelcomePage();
          },
        ),
    );
  }
}
