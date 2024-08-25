import 'package:flutter/material.dart';


void showSnakeBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)),);
}
