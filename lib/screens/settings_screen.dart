import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: DarkModeSwitchTile(),
          ),
        ],
      ),
    );
  }
}

class DarkModeSwitchTile extends StatefulWidget {
  const DarkModeSwitchTile({Key? key}) : super(key: key);

  @override
  State<DarkModeSwitchTile> createState() => _DarkModeSwitchTileState();
}

class _DarkModeSwitchTileState extends State<DarkModeSwitchTile> {
  bool _lights = false;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: const Text('Dark Mode'),
      value: _lights,
      onChanged: (bool value) {
        setState(() {
          _lights = value;
          _lights ? print("Dark Mode On") : print("Dark Mode Off");
        });
      },
      secondary: const Icon(Icons.dark_mode),
    );
  }
}
