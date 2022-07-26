import 'package:flutter/material.dart';

void showDoorOpenWarningDialog(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
            backgroundColor: Colors.red,
            title: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Icon(
                    Icons.alarm_rounded,
                    color: Colors.white,
                    size: 35,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Please close the door",
                    style: TextStyle(color: Colors.white),
                  )
                ]),
          ));
}
