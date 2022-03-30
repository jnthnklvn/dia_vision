import 'package:dia_vision/app/repositories/atividade_fisica_repository.dart';
import 'package:dia_vision/app/modules/home/domain/entities/module.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';

import 'controllers/atividade_fisica_register_controller.dart';
import 'controllers/atividade_fisica_controller.dart';
import 'pages/atividade_fisica_register_page.dart';
import 'pages/atividade_fisica_page.dart';

import 'package:flutter_modular/flutter_modular.dart';

class AtividadeFisicaModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => AtividadeFisicaRepository()),
    Bind((i) => AtividadeFisicaController(i(), i())),
    Bind((i) => AtividadeFisicaRegisterController(i(), i(), i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(exercises.routeName, child: (_, args) => AtividadeFisicaPage()),
    ChildRoute("/$registerStr",
        child: (_, args) => AtividadeFisicaRegisterPage(args.data)),
  ];
}
