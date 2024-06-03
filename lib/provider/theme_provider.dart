import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  static const String _themeModeKey = 'theme_mode';

  ThemeProvider() {
    _loadThemeMode();
  }

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode {
    if (_themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance!.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return _themeMode == ThemeMode.dark;
    }
  }

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final savedThemeMode = prefs.getString(_themeModeKey);

    if (savedThemeMode != null) {
      _themeMode = ThemeMode.values.firstWhere(
        (e) => e.toString() == savedThemeMode,
        orElse: () => ThemeMode.system,
      );
    }

    notifyListeners(); // Perbarui UI setelah memuat tema
  }

  Future<void> _saveThemeMode(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeModeKey, themeMode.toString());
    notifyListeners(); // Perbarui UI setelah menyimpan tema
  }

  void toggleTheme(bool isOn) {
    _themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    _saveThemeMode(_themeMode);
  }
}

const COLOR_PRIMARY = Colors.blue;
const COLOR_ACCENT = Colors.lightBlueAccent;

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: COLOR_PRIMARY,
  textTheme: TextTheme(bodyText1: TextStyle(color: Colors.grey.shade900)),
  dialogTheme: DialogTheme(
      backgroundColor: Colors.blue.shade100,
      // iconColor: Colors.blue,
      surfaceTintColor: Colors.blue),
  switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.all<Color>(Colors.grey.shade300),
      thumbColor: MaterialStateProperty.all<Color>(Colors.blue),
      trackOutlineColor: MaterialStateProperty.all<Color>(Colors.blue)),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(COLOR_PRIMARY),
      foregroundColor: MaterialStateProperty.all(Colors.white), // Warna teks
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(color: Colors.black), // Warna label pada TextField
    hintStyle: TextStyle(color: Colors.grey), // Warna hint pada TextField
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.blue
      )
    )
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: COLOR_PRIMARY,
  switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
      thumbColor: MaterialStateProperty.all<Color>(Colors.blue),
      trackOutlineColor: MaterialStateProperty.all<Color>(Colors.blue)),
  dialogTheme: DialogTheme(
      backgroundColor: Colors.black,
      iconColor: Colors.blue,
      surfaceTintColor: Colors.blue),
  textTheme: TextTheme(
    // bodyText1: TextStyle(color: Colors.black),
    bodyText2: TextStyle(color: Colors.white),
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(color: Colors.white), // Warna label pada TextField
    hintStyle: TextStyle(color: Colors.grey), // Warna hint pada TextField
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.blue
      )
    )
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(COLOR_PRIMARY),
      foregroundColor: MaterialStateProperty.all(Colors.white), // Warna teks
    ),
  ),
);
