import 'package:flutter/material.dart';
import 'package:smartlock_gui/components/home_screen_carousel.dart';
import 'package:smartlock_gui/components/qr_code_displayer.dart';
import 'package:smartlock_gui/constants.dart';
import 'package:smartlock_gui/screens/categories_screen.dart';
import 'package:smartlock_gui/screens/settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
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
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                  ),
                ),
                const SizedBox(
                  width: 35,
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        actionsPadding:
                            const EdgeInsets.only(right: 20, bottom: 5),
                        actions: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SettingsScreen()),
                              );
                            },
                            child: const Text(
                              "Settings",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              showDialogQR(context, gitRepoURL);
                            },
                            child: const Text(
                              "GitHub",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              primary: Colors.blue,
                            ),
                          ),
                        ],
                        title: const Text("Thanks for using Smart Lock V2 !"),
                        content: const Text(
                            "For more information on the project, visit our GitHub page or contact me at :\nlouis.badr@edu.devinci.fr"),
                      ),
                      barrierDismissible: true,
                    );
                  },
                  icon: const Icon(Icons.info_outline_rounded),
                  iconSize: 45,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
