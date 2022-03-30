import 'package:dia_vision/app/repositories/centro_saude_repository.dart';
import 'package:dia_vision/app/modules/home/domain/entities/module.dart';
import 'package:dia_vision/app/repositories/endereco_repository.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';

import 'controllers/centro_saude_register_controller.dart';
import 'controllers/centro_saude_controller.dart';
import 'pages/centro_saude_register_page.dart';
import 'pages/centros_saude_page.dart';
import 'pages/centro_saude_page.dart';

import 'package:flutter_modular/flutter_modular.dart';

class CentroSaudeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => EnderecoRepository()),
    Bind((i) => CentroSaudeRepository()),
    Bind((i) => CentroSaudeController(i())),
    Bind((i) => CentroSaudeRegisterController(i(), i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(medicalCenters.routeName,
        child: (_, args) => CentrosSaudePage()),
    ChildRoute("/$registerStr",
        child: (_, args) => CentroSaudeRegisterPage(args.data)),
    ChildRoute("/page", child: (_, args) => CentroSaudePage(args.data)),
  ];
}
