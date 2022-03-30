import 'package:dia_vision/app/modules/home/domain/entities/module.dart';
import 'package:dia_vision/app/repositories/glicemia_repository.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';

import 'controllers/glicemia_register_controller.dart';
import 'controllers/glicemia_controller.dart';
import 'pages/glicemia_register_page.dart';
import 'pages/glicemia_page.dart';

import 'package:flutter_modular/flutter_modular.dart';

class GlicemiaModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => GlicemiaRepository()),
    Bind((i) => GlicemiaController(i(), i(), i())),
    Bind((i) => GlicemiaRegisterController(i(), i(), i(), i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(glicemy.routeName, child: (_, args) => GlicemiaPage()),
    ChildRoute("/$registerStr",
        child: (_, args) => GlicemiaRegisterPage(args.data)),
  ];
}
