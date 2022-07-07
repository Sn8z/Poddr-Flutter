import 'package:flutter/material.dart';

class ThemeService with ChangeNotifier {
  ThemeMode currentThemeMode = ThemeMode.system;

  void setSelectedTheme(ThemeMode themeMode) {
    currentThemeMode = themeMode;
    print(currentThemeMode.toString());
    notifyListeners();
  }

  ThemeData buildLightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.red,
      primaryColor: Colors.red[400],
    );
  }

  ThemeData buildDarkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.amber,
      primaryColor: Colors.orange[200],
    );
  }
}
