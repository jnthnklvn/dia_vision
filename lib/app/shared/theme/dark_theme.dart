import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:flutter/material.dart';

import 'text_theme.dart';

class DarkTheme {
  final double fontScale;

  DarkTheme(this.fontScale);

  ThemeData get themeData => ThemeData(
        primaryColor: kPrimaryColor,
        toggleableActiveColor: kPrimaryColor,
        indicatorColor: kPrimaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: kPrimaryColor,
          secondary: kPrimaryColor,
          background: Colors.black,
        ),
        appBarTheme: AppBarTheme(
          elevation: 1,
          color: Colors.black,
          titleTextStyle: textTheme.headline6!
              .copyWith(
                color: Colors.white,
              )
              .apply(fontSizeFactor: fontScale),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        textTheme: textTheme.apply(fontSizeFactor: fontScale, fontSizeDelta: 2),
        canvasColor: Colors.black,
        backgroundColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
      );
}
