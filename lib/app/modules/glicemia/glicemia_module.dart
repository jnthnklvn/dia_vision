import 'package:dia_vision/app/shared/preferences/preferencias_preferences.dart';
import 'package:dia_vision/app/shared/local_storage/local_storage_shared.dart';
import 'package:dia_vision/app/modules/home/domain/entities/module.dart';
import 'package:dia_vision/app/repositories/glicemia_repository.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';

import 'controllers/glicemia_register_controller.dart';
import 'controllers/glicemia_controller.dart';
import 'pages/glicemia_register_page.dart';
import 'pages/glicemia_page.dart';

import 'package:flutter_modular/flutter_modular.dart';

class GlicemiaModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => LocalStorageShared()),
        Bind((i) => GlicemiaRepository()),
        Bind((i) => PreferenciasPreferences(i())),
        Bind((i) => GlicemiaController(i(), i(), i())),
        Bind((i) => GlicemiaRegisterController(i(), i(), i())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(glicemy.routeName, child: (_, args) => GlicemiaPage()),
        ModularRouter("/$REGISTER",
            child: (_, args) => GlicemiaRegisterPage(args.data)),
      ];
}
