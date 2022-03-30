import 'package:dia_vision/app/shared/preferences/medication_notify_preferences.dart';
import 'package:dia_vision/app/repositories/medicacao_prescrita_repository.dart';
import 'package:dia_vision/app/modules/home/domain/entities/module.dart' as md;
import 'package:dia_vision/app/repositories/medication_repository.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';

import 'package:flutter_modular/flutter_modular.dart';

import 'controllers/medication_register_controller.dart';
import 'controllers/medications_controller.dart';
import 'pages/medication_register_page.dart';
import 'pages/medications_page.dart';

class MedicationsModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => MedicationNotifyPreferences(i())),
    Bind((i) => MedicamentoRepository()),
    Bind((i) => MedicacaoPrescritaRepository()),
    Bind((i) => MedicationsController(i(), i(), i())),
    Bind((i) => MedicationRegisterController(i(), i(), i(), i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(md.medications.routeName, child: (_, args) => MedicationsPage()),
    ChildRoute("/$registerStr",
        child: (_, args) => MedicationRegisterPage(args.data)),
  ];
}
