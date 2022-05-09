import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smartlock_gui/components/home_screen_carousel.dart';
import 'package:smartlock_gui/screens/categories_screen.dart';
import 'package:smartlock_gui/screens/items_screen.dart';
import 'package:smartlock_gui/screens/settings_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.grey,
              child: const HomeScreenCarousel(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    print("Inventory");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CategoriesScreen()),
                    );
                  },
                  child: const Text(
                    "INVENTORY",
                    style: TextStyle(fontSize: 30),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    fixedSize:
                        Size(MediaQuery.of(context).size.width / 2.5, 70),
                  ),
                ),
                IconButton(
                  iconSize: 60,
                  onPressed: () {
                    print("Settings");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsScreen()),
                    );
                  },
                  icon: const Icon(Icons.settings),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
