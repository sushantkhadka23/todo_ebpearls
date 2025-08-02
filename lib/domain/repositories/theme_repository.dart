import 'package:flutter/material.dart';

abstract class ThemeRepository {
  loadTheme();
  setTheme(ThemeMode mode);
  Future<ThemeMode> getTheme();
  setSeedColor(Color color);
  Future<Color> getSeedColor();
}
