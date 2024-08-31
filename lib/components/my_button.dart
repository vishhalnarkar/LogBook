import "package:flutter/material.dart";

class MyButton extends StatelessWidget {
  final controller;
  final Function()? onTap;

  const MyButton({
    super.key, 
    required this.controller, 
    required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(25),
        margin: EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Text(
            controller,
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
