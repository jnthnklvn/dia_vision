import 'package:dia_vision/app/repositories/medicacao_prescrita_repository.dart';
import 'package:dia_vision/app/repositories/avaliacao_pes_repository.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';

import 'controllers/avaliacao_pes_register_controller.dart';
import 'controllers/avaliacao_pes_controller.dart';
import 'pages/avaliacao_pes_register_page.dart';
import 'pages/avaliacao_pes_page.dart';

import 'package:flutter_modular/flutter_modular.dart';

class AvaliacaoPesModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => AvaliacaoPesRepository()),
    Bind((i) => MedicacaoPrescritaRepository()),
    Bind((i) => AvaliacaoPesController(i(), i())),
    Bind((i) => AvaliacaoPesRegisterController(i(), i(), i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => AvaliacaoPesPage()),
    ChildRoute("/$registerStr/",
        child: (_, args) => AvaliacaoPesRegisterPage(args.data)),
  ];
}
