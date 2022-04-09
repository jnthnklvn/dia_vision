import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:flutter/material.dart';

import 'text_theme.dart';

class LightTheme {
  final ThemeData themeData = ThemeData(
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
      elevation: 1,
      color: Colors.white,
      titleTextStyle: textTheme.headline6!
          .copyWith(
            color: const Color(0xFF151515),
          )
          .apply(fontSizeFactor: 1.0),
      iconTheme: const IconThemeData(color: Color(0xFF151515)),
    ),
    textTheme: textTheme.apply(fontSizeFactor: 1.0, fontSizeDelta: 2),
    canvasColor: Colors.white,
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
  );
}
