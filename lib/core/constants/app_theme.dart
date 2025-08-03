import 'package:flutter/material.dart';
import 'package:todo_ebpearls/core/constants/app_constants.dart';

class AppTheme {
  static ThemeData lightTheme(Color seedColor) {
    return ThemeData(
      useMaterial3: true,
      fontFamily: AppConstants.manRopeFont,
      textTheme: TextTheme(),
      iconTheme: IconThemeData(),
      colorScheme: ColorScheme.fromSeed(seedColor: seedColor, brightness: Brightness.light),
    );
  }

  static ThemeData darkTheme(Color seedColor) {
    return ThemeData(
      useMaterial3: true,
      fontFamily: AppConstants.manRopeFont,
      textTheme: TextTheme(),
      iconTheme: IconThemeData(),
      colorScheme: ColorScheme.fromSeed(seedColor: seedColor, brightness: Brightness.dark),
    );
  }
}
