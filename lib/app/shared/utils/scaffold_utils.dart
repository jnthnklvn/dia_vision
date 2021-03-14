import 'package:dia_vision/app/shared/components/snack_bars.dart';

import 'package:flutter/material.dart';

class ScaffoldUtils {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  void onError(String message) =>
      scaffoldKey.currentState?.showSnackBar(SnackBars.error(message));
  void onSuccess(String message) =>
      scaffoldKey.currentState?.showSnackBar(SnackBars.confirmation(message));
}
