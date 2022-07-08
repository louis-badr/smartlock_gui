import 'package:smartlock_gui/constants.dart';
import 'package:flutter/material.dart';

void showLockStateSnackBar(BuildContext context, int responseCode) {
  String message;
  IconData icon;
  MaterialColor color;
  switch (responseCode) {
    case 200:
      {
        message = "Door open";
        icon = Icons.lock_open_rounded;
        color = Colors.green;
      }
      break;

    case 403:
      {
        message = "Access Denied";
        icon = Icons.front_hand_rounded;
        color = Colors.red;
      }
      break;

    case 404:
      {
        message = "Unknown card";
        icon = Icons.question_mark_rounded;
        color = Colors.orange;
      }
      break;

    default:
      {
        message = "Internal Error";
        icon = Icons.error_rounded;
        color = Colors.grey;
      }
      break;
  }
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      content: SizedBox(
          height: 85,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 50,
              ),
              const SizedBox(width: 30),
              Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  //fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ],
          )),
      duration: const Duration(seconds: 5),
      //behavior: SnackBarBehavior.floating,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(clipRadiusCarousel),
              topRight: Radius.circular(clipRadiusCarousel))),
    ),
  );
}
