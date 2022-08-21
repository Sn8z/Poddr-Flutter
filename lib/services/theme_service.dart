import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.dark) {
    debugPrint('Theme notifier constructor!');
  }

  void setDarkMode() {
    state = ThemeMode.dark;
  }

  void setLightMode() {
    state = ThemeMode.light;
  }

  void toggleMode() {
    state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  }
}

final themeModeProvider =
    StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  return ThemeModeNotifier();
});

ThemeData defaultLightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.red,
  scaffoldBackgroundColor: const Color.fromARGB(255, 220, 220, 220),
  fontFamily: 'Manrope',
  sliderTheme: const SliderThemeData(
    activeTrackColor: Colors.red,
    inactiveTrackColor: Color.fromARGB(255, 200, 200, 200),
    thumbColor: Color.fromARGB(255, 230, 230, 230),
  ),
);

ThemeData defaultDarkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.amber,
  primaryColor: Colors.amber[600],
  scaffoldBackgroundColor: const Color.fromARGB(255, 20, 20, 20),
  fontFamily: 'Manrope',
  sliderTheme: const SliderThemeData(
    activeTrackColor: Colors.amber,
    inactiveTrackColor: Color.fromARGB(255, 45, 45, 45),
    thumbColor: Color.fromARGB(255, 220, 220, 220),
  ),
);

class Themes {
  final ThemeData darkTheme;
  final ThemeData lightTheme;
  Themes({required this.darkTheme, required this.lightTheme});
}

class ThemeDataNotifier extends StateNotifier<Themes> {
  ThemeDataNotifier()
      : super(Themes(
          darkTheme: defaultDarkTheme,
          lightTheme: defaultLightTheme,
        ));

  void updateColor() {
    Random rnd = Random();
    Color clr = Color.fromRGBO(
      rnd.nextInt(255),
      rnd.nextInt(255),
      rnd.nextInt(255),
      1,
    );
    ThemeData dTheme = state.darkTheme.copyWith(primaryColor: clr);
    ThemeData lTheme = state.lightTheme.copyWith(primaryColor: clr);
    state = Themes(darkTheme: dTheme, lightTheme: lTheme);
  }
}

final themeDataProvider =
    StateNotifierProvider<ThemeDataNotifier, Themes>((ref) {
  return ThemeDataNotifier();
});
