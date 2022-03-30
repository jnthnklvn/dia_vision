import 'package:dia_vision/app/modules/home/domain/entities/module.dart' as md;
import 'package:dia_vision/app/repositories/app_visao_repository.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';

import 'controllers/app_visao_register_controller.dart';
import 'controllers/app_visao_controller.dart';
import 'pages/app_visao_register_page.dart';
import 'pages/apps_visao_page.dart';

import 'package:flutter_modular/flutter_modular.dart';

class AppVisaoModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => AppVisaoRepository()),
    Bind((i) => AppVisaoController(i())),
    Bind((i) => AppVisaoRegisterController(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(md.vision.routeName, child: (_, args) => AppsVisaoPage()),
    ChildRoute("/$registerStr",
        child: (_, args) => AppVisaoRegisterPage(args.data)),
  ];
}
