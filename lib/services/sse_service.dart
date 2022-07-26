import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartlock_gui/components/door_open_warning_dialog.dart';
import 'package:smartlock_gui/components/lock_snackbar.dart';
import 'package:smartlock_gui/constants.dart';
import 'package:sse_client/sse_client.dart';

void streamRfidSSE(context) async {
  final sseClientRFID = SseClient.connect(
    Uri.parse('$baseUrlLocal/stream/rfid?unlock=true'),
  );
  sseClientRFID.stream!.listen(
    (event) {
      //print(event.toString());
      int authCode = int.parse(event
          .toString()
          .substring(event.toString().length - 3, event.toString().length));
      showLockStateSnackBar(context, authCode);
    },
  );
}

void streamClosingSensorSSE(context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? enableCSWarning = prefs.getBool("enableCSWarning");
  bool? enableCSAlarm = prefs.getBool("enableCSAlarm");
  if (enableCSWarning == true || enableCSAlarm == true) {
    final sseClientCS = SseClient.connect(
      Uri.parse(
          '$baseUrlLocal/stream/closing-sensor?alarm=${enableCSAlarm.toString()}'),
    );
    if (enableCSWarning == true) {
      sseClientCS.stream!.listen(
        (event) {
          //print(event.toString());
          if (event.toString().contains('open')) {
            showDoorOpenWarningDialog(context);
          } else {
            Navigator.of(context, rootNavigator: true).pop();
          }
        },
      );
    }
  }
}
