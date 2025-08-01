import 'package:flutter/material.dart';

class AppSize {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late Orientation orientation;
  static late double defaultSize;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
    defaultSize = screenWidth * 0.024;
  }

  static const double viewMargin = 16;
  static const double viewPadding = 76;
  static const double viewSpacing = 24;
  static const double spacedViewSpacing = 48;

  static const double titleHeight = 22;
  static const double buttonHeight = 54;
  static const double textFieldHeight = 47;
  static const double cardHeight = 262;
  static const double containerHeight = 183;
  static const double profileImageHeight = 80;
  static const double imageHeight = 140;

  static const double textFieldWidth = 353;
  static const double cardWidth = 352;
  static const double imageWidth = 169;

  static const double buttonRadius = 25;
  static const double cornerRadius = 16;
  static const double cornerRadiusMedium = 8;
  static const double cornerRadiusSmall = 4;

  static const double iconHeight = 24;
  static const double smallIconHeight = 20;
  static const double circleAvatarWidth = 45;
  static const double circleAvatarHeight = 44;

  static const double titleSubtitleSpacing = 11;
  static const double inset = 16;
  static const double checkBoxHeight = 24;
  static const double placeholder = 24;

  static double scaled(double size) => size * defaultSize;

  static bool get isPortrait => orientation == Orientation.portrait;
  static bool get isLandscape => orientation == Orientation.landscape;
}
