import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smartlock_gui/components/door_open_warning_dialog.dart';
import 'package:smartlock_gui/components/home_screen_carousel.dart';
import 'package:smartlock_gui/components/lock_snackbar.dart';
import 'package:smartlock_gui/components/qr_code_displayer.dart';
import 'package:smartlock_gui/constants.dart';
import 'package:smartlock_gui/screens/categories_screen.dart';
import 'package:smartlock_gui/screens/settings_screen.dart';
import 'package:sse_client/sse_client.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          // Image carousel
          const HomeScreenCarousel(),
          // Buttons under the carousel
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoriesScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "INVENTORY",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 35,
                ),
                IconButton(
                  onPressed: () {
                    Timer? _timer;
                    showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext builderContext) {
                          _timer = Timer(const Duration(seconds: 10), () {
                            Navigator.of(context)
                                .popUntil(ModalRoute.withName('/'));
                          });
                          return AlertDialog(
                            actionsPadding:
                                const EdgeInsets.only(right: 20, bottom: 5),
                            actions: <Widget>[
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/settings');
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: const StadiumBorder(),
                                ),
                                child: const Text(
                                  "Settings",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  showDialogQR(context, gitRepoURL);
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: const StadiumBorder(),
                                  primary: Colors.blue,
                                ),
                                child: const Text(
                                  "GitHub",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                            title: const Text(
                              "Thanks for using Smart Lock V2",
                            ),
                            content: const Text(
                              "This project is still in development, for more information visit our GitHub page.\nTo report an issue send an email to louis.badr@edu.devinci.fr",
                            ),
                          );
                        }).then((val) {
                      if (_timer!.isActive) {
                        _timer!.cancel();
                      }
                    });
                  },
                  icon: const Icon(Icons.info_outline_rounded),
                  iconSize: 45,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
