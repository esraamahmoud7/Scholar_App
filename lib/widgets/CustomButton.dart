import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key,required this.text,required this.OnTap});

  String text;
  VoidCallback?  OnTap;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: OnTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        width: 380,
        height: 60,
        child: Center(child: Text(text,style: TextStyle(fontSize: 20),)),
      ),
    );
  }

}