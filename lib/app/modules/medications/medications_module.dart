import 'package:dia_vision/app/shared/preferences/medication_notify_preferences.dart';
import 'package:dia_vision/app/repositories/medicacao_prescrita_repository.dart';
import 'package:dia_vision/app/shared/preferences/preferencias_preferences.dart';
import 'package:dia_vision/app/shared/local_storage/local_storage_shared.dart';
import 'package:dia_vision/app/modules/home/domain/entities/module.dart';
import 'package:dia_vision/app/repositories/medication_repository.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';

import 'controllers/medication_register_controller.dart';
import 'controllers/medications_controller.dart';
import 'pages/medication_register_page.dart';
import 'pages/medications_page.dart';

import 'package:flutter_modular/flutter_modular.dart';

class MedicationsModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => LocalStorageShared()),
        Bind((i) => PreferenciasPreferences(i())),
        Bind((i) => MedicationNotifyPreferences(i())),
        Bind((i) => MedicamentoRepository()),
        Bind((i) => MedicacaoPrescritaRepository()),
        Bind((i) => MedicationsController(i(), i(), i())),
        Bind((i) => MedicationRegisterController(i(), i(), i(), i())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(medications.routeName,
            child: (_, args) => MedicationsPage()),
        ModularRouter("/$REGISTER",
            child: (_, args) => MedicationRegisterPage(args.data)),
      ];
}
