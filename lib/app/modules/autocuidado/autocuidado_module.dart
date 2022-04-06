import 'package:dia_vision/app/repositories/autocuidado_repository.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';

import 'controllers/autocuidado_controller.dart';
import 'pages/autocuidados_page.dart';
import 'pages/autocuidado_page.dart';

import 'package:flutter_modular/flutter_modular.dart';

class AutocuidadoModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => AutocuidadoRepository()),
    Bind((i) => AutocuidadoController(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => AutocuidadosPage()),
    ChildRoute("/$selfCareArticleRoute",
        child: (_, args) => AutocuidadoPage(args.data)),
  ];
}
