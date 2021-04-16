import 'size_config.dart';

import 'package:flutter/material.dart';

/// Titles
const APP_NAME = "DiaVision";

const kAppBarTitleSize = 22.0;

const kPrimaryColor = Color(0xFF00778C);
const kPrimaryLightColor = Color(0xFFD6E9ED);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFD6E9ED), Color(0xFF00778C)],
);
const kSecondaryColor = Color(0xFF1B2535);
const kTextColor = Color(0xFF757575);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(24),
  color: kTextColor,
  fontWeight: FontWeight.bold,
);
