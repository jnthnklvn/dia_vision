import 'package:dia_vision/app/repositories/paciente_repository.dart';
import 'package:dia_vision/app/shared/utils/route_enum.dart';

import 'package:flutter_modular/flutter_modular.dart';

import 'preferencias/preferencias_controller.dart';
import 'preferencias/preferencias_page.dart';
import 'my_data/my_data_controller.dart';
import 'my_data/my_data_page.dart';
import 'profile_controller.dart';
import 'profile_page.dart';

class ProfileModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => ProfileController()),
        Bind((i) => PreferenciasController(i(), i(), i())),
        Bind((i) => PacienteRepository()),
        Bind((i) => MyDataController(i(), i(), i(), i())),
      ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => ProfilePage()),
    ChildRoute('${RouteEnum.myData.name}/', child: (_, args) => MyDataPage()),
    ChildRoute('${RouteEnum.preferences.name}/',
        child: (_, args) => PreferenciasPage()),
  ];
}
