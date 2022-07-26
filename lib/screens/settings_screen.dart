import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartlock_gui/constants.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isLoaded = false;

  bool? _enableCSWarning;
  bool? _enableCSAlarm;
  double? _brightnessSliderValue;

  // Gets shared preferences for all settings when entering the screen
  void getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _enableCSWarning = prefs.getBool("enableCSWarning");
    _enableCSAlarm = prefs.getBool("enableCSAlarm");
    _brightnessSliderValue = prefs.getDouble("brightnessSliderValue");
    // If preferences are not set (null) we give them a default value
    _enableCSWarning ??= true;
    _enableCSAlarm ??= true;
    _brightnessSliderValue ??= 100;
    setState(() {
      isLoaded = true;
    });
  }

  void setBoolPref(String varName, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(varName, value);
  }

  void setDoublePref(String varName, double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(varName, value);
  }

  void setBrightness(String value) async {
    await post(
      Uri.parse("$baseUrlLocal/screen-brightness?value=$value"),
    );
  }

  @override
  void initState() {
    super.initState();
    getSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Visibility(
          visible: isLoaded,
          replacement: const Center(child: CircularProgressIndicator()),
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
              Card(
                child: ClipPath(
                  clipper: ShapeBorderClipper(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Slider(
                          value: _brightnessSliderValue!,
                          max: 100,
                          //divisions: 20,
                          label: _brightnessSliderValue.toString(),
                          onChanged: (double value) {
                            setState(() {
                              _brightnessSliderValue = value;
                            });
                          },
                          onChangeEnd: (double value) {
                            setDoublePref("brightnessSliderValue", value);
                            setBrightness(value.round().toString());
                          },
                        ),
                      ),
                      IgnorePointer(
                        child: ListTile(
                          title: const Text("Touchscreen brightness"),
                          leading: const Icon(Icons.sunny),
                          trailing: Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: Text(
                              "${_brightnessSliderValue!.round()}%",
                              style: const TextStyle(
                                //fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: SwitchListTile(
                  title: const Text("Door left open warning message"),
                  subtitle:
                      const Text("This setting will be applied on restart"),
                  value: _enableCSWarning!,
                  secondary: const Icon(Icons.warning_rounded),
                  onChanged: (bool value) {
                    setBoolPref("enableCSWarning", value);
                    setState(() {
                      _enableCSWarning = value;
                    });
                  },
                ),
              ),
              Card(
                child: SwitchListTile(
                  title: const Text("Door left open alarm"),
                  subtitle:
                      const Text("This setting will be applied on restart"),
                  value: _enableCSAlarm!,
                  secondary: const Icon(Icons.volume_up_rounded),
                  onChanged: (bool value) {
                    setBoolPref("enableCSAlarm", value);
                    setState(() {
                      _enableCSAlarm = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
