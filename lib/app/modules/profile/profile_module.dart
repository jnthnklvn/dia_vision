import 'package:dia_vision/app/shared/preferences/preferencias_preferences.dart';
import 'package:dia_vision/app/shared/local_storage/local_storage_shared.dart';
import 'package:dia_vision/app/repositories/paciente_repository.dart';
import 'package:dia_vision/app/shared/utils/route_enum.dart';

import 'package:flutter_modular/flutter_modular.dart';

import 'preferencias/preferencias_controller.dart';
import 'preferencias/preferencias_page.dart';
import 'my_data/my_data_controller.dart';
import 'my_data/my_data_page.dart';
import 'profile_controller.dart';
import 'profile_page.dart';

class ProfileModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => ProfileController()),
        Bind((i) => PreferenciasController(i())),
        Bind((i) => PacienteRepository()),
        Bind((i) => LocalStorageShared()),
        Bind((i) => PreferenciasPreferences(i())),
        Bind((i) => MyDataController(i(), i(), i(), i())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter("/", child: (_, args) => ProfilePage()),
        ModularRouter(RouteEnum.my_data.name, child: (_, args) => MyDataPage()),
        ModularRouter(RouteEnum.preferences.name,
            child: (_, args) => PreferenciasPage()),
      ];
}
