import 'dart:async';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

void showDialogQR(BuildContext context, String url) {
  Timer? _timer;
  showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext builderContext) {
        _timer = Timer(const Duration(seconds: 10), () {
          Navigator.of(context).pop();
        });

        return AlertDialog(
          backgroundColor: Colors.white,
          //elevation: 0,
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
        );
      }).then((val) {
    if (_timer!.isActive) {
      _timer!.cancel();
    }
  });
}
