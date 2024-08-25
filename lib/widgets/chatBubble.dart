import 'package:flutter/material.dart';

import '../Constants.dart';
import '../models/message.dart';



class chatBubble extends StatelessWidget {
  const chatBubble({super.key, required this.color,required this.message,required this.position});

   final Color color;
   final Message message;
   final AlignmentGeometry position;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: position,
      child: Container(
        padding: EdgeInsets.only(left: 16,top :16,bottom:25,right:16),
        // width: double.infinity,
        // height: 65,
        margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        decoration: BoxDecoration(
            borderRadius: position == Alignment.centerLeft?
                BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
                bottomRight: Radius.circular(32))
                :
                BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
                bottomLeft: Radius.circular(32)),
            color: color
        ),
        child: Text(message.message, style: TextStyle(color: Colors.white,fontSize: 20),),
      ),
    );
  }
}