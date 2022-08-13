import 'dart:async';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:smartlock_gui/components/door_open_warning_dialog.dart';
import 'package:smartlock_gui/constants.dart';
import 'package:smartlock_gui/screens/categories_screen.dart';
import 'package:smartlock_gui/screens/home_screen.dart';
import 'package:smartlock_gui/screens/items_screen.dart';
import 'package:smartlock_gui/screens/settings_screen.dart';
import 'package:smartlock_gui/services/http_inventory_requests.dart';
import 'package:smartlock_gui/services/sse_service.dart';
import 'package:sse_client/sse_client.dart';
//import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(SmartLockGUIApp());
}

class SmartLockGUIApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //streamRfidSSE(context);
    streamClosingSensorSSE(context);
    return AdaptiveTheme(
      light: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        //textTheme: GoogleFonts.robotoTextTheme(),
        dialogTheme: const DialogTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
        ),
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        sliderTheme: SliderThemeData(
          trackHeight: 55,
          trackShape: const RectangularSliderTrackShape(),
          valueIndicatorShape: SliderComponentShape.noOverlay,
          inactiveTrackColor: Colors.transparent,
          overlayShape: SliderComponentShape.noOverlay,
          thumbShape: SliderComponentShape.noOverlay,
          activeTickMarkColor: Colors.transparent,
          inactiveTickMarkColor: Colors.transparent,
        ),
      ),
      dark: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        toggleableActiveColor: Colors.blue,
        //textTheme: GoogleFonts.robotoTextTheme(ThemeData(brightness: Brightness.dark).textTheme),
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        sliderTheme: SliderThemeData(
          trackHeight: 60,
          trackShape: const RectangularSliderTrackShape(),
          valueIndicatorShape: SliderComponentShape.noOverlay,
          inactiveTrackColor: Colors.transparent,
          overlayShape: SliderComponentShape.noOverlay,
          thumbShape: SliderComponentShape.noOverlay,
          activeTickMarkColor: Colors.transparent,
          inactiveTickMarkColor: Colors.transparent,
        ),
      ),
      initial: AdaptiveThemeMode.dark,
      builder: (theme, darkTheme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Smart Lock GUI',
        theme: theme,
        darkTheme: darkTheme,
        //home: HomeScreen(),
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(),
          '/settings': (context) => SettingsScreen(),
          '/categories': (context) => CategoriesScreen(),
        },
      ),
    );
  }
}
