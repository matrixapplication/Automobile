import 'package:flutter/material.dart';

void showCustomSnackBar( {required String message,required BuildContext context,bool isError = true}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: isError ? Colors.red : Colors.green,
    content: Text(message,style: const TextStyle(color: Colors.white),),
  ));
}