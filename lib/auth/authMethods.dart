import 'dart:typed_data';

// import 'package:ableeasefinale/models/user.dart' as model;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logbook/pages/welcome.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Future<model.User> getUserDetails() async{
  //   User currentUser = _auth.currentUser!;

  //   DocumentSnapshot snap=await _firestore.collection('users').doc(currentUser.uid).get();

  //   return model.User.fromSnap(snap);
  // }

  //Sign up user
  Future<String> signUpUser({
  required String mail,
  required String password,
  required String username,
}) async {
  String res = "Some error Occurred";

  try {
    // Check if email, password, and username are not empty
    if (mail.isNotEmpty || password.isNotEmpty || username.isNotEmpty) {
      // Check if username length is less than 8 characters
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: mail, password: password);

        res = 'success';
    } else {
      res = 'Please enter all the fields';
    }
  } catch (err) {
    res = err.toString();
  }

  return res;
}


  //Log in user
  Future<String> logInUser({
    required String mail,
    required String password,
  }) async {
    String res = "Some error occured";

    

    try {
      if (mail.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(email: mail, password: password);
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      res = err.toString();
    }

    return res;
  }

  signOutUser(BuildContext context){
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => WelcomePage()),
      (route) => false,
    );
  }
}