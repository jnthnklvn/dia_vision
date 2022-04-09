import 'package:dia_vision/app/shared/theme/light_theme.dart';
import 'package:dia_vision/app/shared/theme/dark_theme.dart';
import 'package:dia_vision/app/app_controller.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'shared/utils/route_enum.dart';
import 'shared/utils/constants.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final _appController = Modular.get<AppController>();

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute('${RouteEnum.splash.name}/');

    return ValueListenableBuilder<bool>(
      valueListenable: _appController.themeSwitch,
      builder: (context, isDarkMode, child) {
        SystemChrome.setSystemUIOverlayStyle(
          isDarkMode ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
        );

        return MaterialApp.router(
          routerDelegate: Modular.routerDelegate,
          routeInformationParser: Modular.routeInformationParser,
          debugShowCheckedModeBanner: false,
          title: appName,
          themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
          theme: LightTheme().themeData,
          darkTheme: DarkTheme().themeData,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('pt', 'BR'),
            Locale('en', ''),
          ],
        );
      },
    );
  }
}
