import 'package:flutter/material.dart';

class ColorUtils {
  static final List<ColorSwatch> _colors = [];

  static List<ColorSwatch> get colors {
    if (_colors.isEmpty) {
      _colors.addAll(Colors.accents);
      _colors.addAll(Colors.primaries);
    }
    return _colors;
  }
}
