import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/app_module.dart';
import 'package:dia_vision/app/app_widget.dart';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeParser();

  await initializateNotifications();

  runApp(ModularApp(
    module: AppModule(),
    child: const AppWidget(),
  ));
}

Future<void> initializateNotifications() async {
  await AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelKey: 'basic_channel',
      channelName: 'Basic notifications',
      channelDescription: 'Notification channel for basic notifications',
      defaultColor: kPrimaryColor,
      ledColor: Colors.white,
    ),
  ]);
}

Future<void> initializeParser() async {
  final appDocDir = await getApplicationDocumentsDirectory();
  await dotenv.load(fileName: ".env");

  await Parse().initialize(
    dotenv.env['kParseApplicationId']!,
    dotenv.env['kParseBaseUrl']!,
    clientKey: dotenv.env['kParseClientKey'],
    autoSendSessionId: true,
    coreStore: await CoreStoreSembastImp.getInstance(
      appDocDir.path + "/data",
      password: dotenv.env['kParseApplicationId'],
    ),
  );
}
