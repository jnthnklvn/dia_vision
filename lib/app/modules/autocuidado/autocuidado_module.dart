import 'package:dia_vision/app/modules/home/domain/entities/module.dart';
import 'package:dia_vision/app/repositories/autocuidado_repository.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';

import 'controllers/autocuidado_controller.dart';
import 'pages/autocuidados_page.dart';
import 'pages/autocuidado_page.dart';

import 'package:flutter_modular/flutter_modular.dart';

class AutocuidadoModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AutocuidadoRepository()),
        Bind((i) => AutocuidadoController(i())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(selfCare.routeName,
            child: (_, args) => AutocuidadosPage()),
        ModularRouter("/$SELF_CARE_ARTICLE_ROUTE",
            child: (_, args) => AutocuidadoPage(args.data)),
      ];
}
