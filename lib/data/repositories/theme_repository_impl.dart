import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:todo_ebpearls/core/constants/app_constants.dart';
import 'package:todo_ebpearls/domain/repositories/theme_repository.dart';

class ThemeRepositoryImpl extends ThemeRepository {
  @override
  loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString(AppConstants.themeModeKey);
    if (themeString == null) {
      await setTheme(ThemeMode.system);
    }
  }

  @override
  setTheme(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    String modeString;
    switch (mode) {
      case ThemeMode.light:
        modeString = 'light';
        break;
      case ThemeMode.dark:
        modeString = 'dark';
        break;
      case ThemeMode.system:
        modeString = 'system';
        break;
    }
    await prefs.setString(AppConstants.themeModeKey, modeString);
  }

  @override
  Future<ThemeMode> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString(AppConstants.themeModeKey) ?? 'system';
    switch (themeString) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      case 'system':
        return ThemeMode.system;
      default:
        return ThemeMode.system;
    }
  }

  @override
  Future<Color> getSeedColor() async {
    final prefs = await SharedPreferences.getInstance();
    final colorString = prefs.getString(AppConstants.seedColorKey);
    if (colorString == null) return Colors.deepPurple;
    final colorInt = int.tryParse(colorString, radix: 16) ?? Colors.deepPurple.toARGB32();
    final color = Color(colorInt);

    return color;
  }

  @override
  setSeedColor(Color color) async {
    final prefs = await SharedPreferences.getInstance();
    final colorString = color.toARGB32().toRadixString(16);
    await prefs.setString(AppConstants.seedColorKey, colorString);
  }
}
