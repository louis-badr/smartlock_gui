import 'package:flutter/material.dart';
import 'package:smartlock_gui/screens/home_screen.dart';

void main() {
  runApp(SmartLockGUIApp());
}

class SmartLockGUIApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Smart Lock GUI",
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      home: HomeScreen(),
    );
  }
}
