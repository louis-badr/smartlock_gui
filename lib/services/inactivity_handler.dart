import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smartlock_gui/screens/home_screen.dart';

void returnToHomeScreen(context, int maxInactivity) {
  Timer(Duration(seconds: maxInactivity), () {
    Navigator.pushNamed(context, '/');
  });
}
