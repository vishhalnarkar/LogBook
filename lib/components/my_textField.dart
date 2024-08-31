import "package:flutter/material.dart";

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obsecureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obsecureText
  });

  @override
  Widget build(BuildContext context){
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 25.0),
    child:TextField(
      
      style: TextStyle(color: Colors.white),
      controller: controller,
      obscureText: obsecureText,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(4)
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white)
        ),
        fillColor: Color(0xFF252525),
        filled: true,
        hintStyle: TextStyle(color: const Color.fromARGB(255, 158, 158, 158)),
        hintText: hintText,
        labelStyle: TextStyle(color: Colors.white)
      ),
    )
    );
  }
}
