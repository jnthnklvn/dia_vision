import 'package:dia_vision/app/repositories/alimentacao_repository.dart';
import 'package:dia_vision/app/modules/home/domain/entities/module.dart' as md;
import 'package:dia_vision/app/repositories/alimento_api_repository.dart';
import 'package:dia_vision/app/repositories/alimento_repository.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';

import 'controllers/alimentacao_register_controller.dart';
import 'controllers/alimentacao_controller.dart';
import 'controllers/alimento_controller.dart';
import 'pages/alimentacao_register_page.dart';
import 'pages/alimentacao_page.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:dio/dio.dart';

import 'pages/alimento_register_page.dart';

class AlimentacaoModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => Dio()),
    Bind((i) => AlimentoRepository()),
    Bind((i) => AlimentacaoRepository()),
    Bind((i) => AlimentoAPIRepository(i())),
    Bind((i) => AlimentoController(i(), i())),
    Bind((i) => AlimentacaoController(i(), i())),
    Bind((i) => AlimentacaoRegisterController(i(), i(), i(), i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(md.alimentation.routeName,
        child: (_, args) => AlimentacaoPage()),
    ChildRoute("/$registerStr",
        child: (_, args) => AlimentacaoRegisterPage(args.data)),
    ChildRoute("alimento/$registerStr",
        child: (_, args) => AlimentoRegisterPage()),
  ];
}
