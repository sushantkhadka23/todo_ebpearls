part of 'theme_bloc.dart';

abstract class ThemeEvent {}

class LoadTheme extends ThemeEvent {}

class UpdateTheme extends ThemeEvent {
  final ThemeMode mode;
  UpdateTheme(this.mode);
}

class UpdateSeedColor extends ThemeEvent {
  final Color seedColor;
  UpdateSeedColor(this.seedColor);
}
