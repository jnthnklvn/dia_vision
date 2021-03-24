import 'package:dia_vision/app/repositories/medicacao_prescrita_repository.dart';
import 'package:dia_vision/app/repositories/avaliacao_pes_repository.dart';
import 'package:dia_vision/app/modules/home/domain/entities/module.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';

import 'controllers/avaliacao_pes_register_controller.dart';
import 'controllers/avaliacao_pes_controller.dart';
import 'pages/avaliacao_pes_register_page.dart';
import 'pages/avaliacao_pes_page.dart';

import 'package:flutter_modular/flutter_modular.dart';

class AvaliacaoPesModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AvaliacaoPesRepository()),
        Bind((i) => MedicacaoPrescritaRepository()),
        Bind((i) => AvaliacaoPesController(i(), i())),
        Bind((i) => AvaliacaoPesRegisterController(i(), i(), i())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(feet.routeName, child: (_, args) => AvaliacaoPesPage()),
        ModularRouter("/$REGISTER",
            child: (_, args) => AvaliacaoPesRegisterPage(args.data)),
      ];
}
