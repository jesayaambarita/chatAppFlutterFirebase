import 'package:flutter/material.dart';
import 'package:projek_pertama/screen/btm.dart';

class Constant {
  static String appId = "1:523864981359:web:44c74955599157b4a2729a";
  static String apiKey = "AIzaSyB66jwkaiPXyXcunpklXDEamoV_BxZnues";
  static String messagingSenderId = "523864981359";
  static String projectId = "lelang-91fb3";
}

void showSnackbar(context, message, color) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: const TextStyle(fontSize: 14),
    ),
    backgroundColor: color,
    duration: const Duration(seconds: 5),
    action: SnackBarAction(
      label: "OK",
      onPressed: () {},
      textColor: Colors.white,
    ),
  ));
}

void nextScreen(context, page) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
  void next(context, page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
}
