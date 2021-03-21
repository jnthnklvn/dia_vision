import 'package:dia_vision/app/shared/utils/strings.dart';
import 'package:dia_vision/app/app_module.dart';

import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeParser();

  runApp(ModularApp(module: AppModule()));
}

Future initializeParser() async {
  final appDocDir = await getApplicationDocumentsDirectory();

  await Parse().initialize(
    kParseApplicationId,
    kParseBaseUrl,
    clientKey: kParseClientKey,
    autoSendSessionId: true,
    debug: true,
    coreStore: await CoreStoreSembastImp.getInstance(
      appDocDir.path + "/data",
      password: kParseApplicationId,
    ),
  );
}
