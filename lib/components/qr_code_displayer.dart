import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

void showDialogQR(BuildContext context, String url) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      backgroundColor: Colors.white,
      elevation: 0,
      content: SizedBox(
        height: 250,
        width: 250,
        child: FittedBox(
          child: Column(
            children: <Widget>[
              QrImage(
                data: url,
                version: QrVersions.auto,
                size: 250,
              ),
              Text(
                Uri.parse(url).host.toString(),
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    ),
    barrierDismissible: true,
  );
}
