import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:flutter/material.dart';

import 'text_theme.dart';

abstract class DarkTheme {
  static const Color _backColor = Colors.black;

  static final ThemeData themeData = ThemeData(
    primaryColor: kPrimaryColor,
    toggleableActiveColor: kPrimaryColor,
    indicatorColor: kPrimaryColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: kPrimaryColor,
      secondary: kPrimaryColor,
      background: _backColor,
    ),
    appBarTheme: AppBarTheme(
      elevation: 1,
      color: Colors.black,
      titleTextStyle: textTheme.headline6!.copyWith(color: Colors.white),
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    textTheme: Typography.whiteMountainView.merge(textTheme),
    canvasColor: _backColor,
    backgroundColor: _backColor,
    scaffoldBackgroundColor: _backColor,
  );
}
