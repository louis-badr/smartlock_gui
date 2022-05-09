import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Card(
              child: ListTile(
                title: const Text("Dark Mode"),
                leading: const Icon(Icons.dark_mode_rounded),
                onTap: () {
                  AdaptiveTheme.of(context).toggleThemeMode();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
