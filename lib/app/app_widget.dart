import 'package:flutter_modular/flutter_modular.dart';

import 'shared/utils/route_enum.dart';
import 'shared/utils/constants.dart';

import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_NAME,
      theme: ThemeData(
        backgroundColor: Colors.white,
        appBarTheme: AppBarTheme(color: Colors.white, elevation: 0),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: "Nunito",
      ),
      onGenerateRoute: Modular.generateRoute,
      initialRoute: RouteEnum.auth.name,
      navigatorKey: Modular.navigatorKey,
      supportedLocales: [
        const Locale('pt', 'BR'),
        const Locale('en', ''),
      ],
    );
  }
}
