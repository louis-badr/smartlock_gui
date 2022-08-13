import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartlock_gui/constants.dart';
import 'package:smartlock_gui/models/inventory_models.dart';
import 'package:smartlock_gui/services/http_inventory_requests.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isLoaded = false;
  String selectedValue = 'demo';

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

  List<CabinetModel>? cabinets;
  getCabinetsData() async {
    cabinets = await getAllCabinets();
    if (cabinets != null) {
      // sort by cabinet ID alphabetical order
      cabinets!.sort((a, b) => a.id.compareTo(b.id));
      //categories!.insert(0, CategoryModel(title: "Others", id: 0));
    }
  }

  @override
  void initState() {
    super.initState();
    getSharedPrefs();
    getCabinetsData();
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
                child: ListTile(
                  title: const Text("Change cabinet ID"),
                  leading: const Icon(Icons.tag_rounded),
                  trailing: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Text(
                      selectedValue,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  onTap: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text("Select the current cabinet's ID"),
                        content: SizedBox(
                          width: double.maxFinite,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: cabinets?.length,
                              itemBuilder: (context, index) {
                                return RadioListTile(
                                  value: cabinets![index].id,
                                  groupValue: selectedValue,
                                  title: Text(cabinets![index].id),
                                  subtitle: cabinets![index].description != null
                                      ? Text(cabinets![index].description!)
                                      : null,
                                  onChanged: (value) => setState(
                                    () {
                                      selectedValue = value.toString();
                                    },
                                  ),
                                );
                              }),
                        ),
                        actions: <Widget>[
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, 'Ok'),
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              primary: Colors.blue,
                            ),
                            child: const Text(
                              "Ok",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
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
