import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
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
              child: CarouselSlider(
                items: [
                  Text("placeholder"),
                ],
                options: CarouselOptions(
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 15),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(45),
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
                  child: Text(
                    "Inventory",
                    style: TextStyle(fontSize: 24),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    fixedSize: Size(MediaQuery.of(context).size.width / 3, 60),
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
                  icon: Icon(Icons.settings),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
