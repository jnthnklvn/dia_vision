import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:flutter/material.dart';

import 'text_theme.dart';

abstract class LightTheme {
  static final ThemeData themeData = ThemeData(
    primaryColor: kPrimaryColor,
    toggleableActiveColor: kPrimaryColor,
    indicatorColor: kPrimaryColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: kPrimaryColor,
      secondary: kPrimaryColor,
      background: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      color: Colors.white,
      titleTextStyle: textTheme.headline6!.copyWith(
        color: const Color(0xFF151515),
      ),
      iconTheme: const IconThemeData(color: Color(0xFF151515)),
    ),
    textTheme: Typography.blackMountainView.merge(textTheme),
    canvasColor: Colors.white,
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
  );
}
