import 'package:dia_vision/app/modules/home/domain/entities/module.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';

import 'pages/medication_register_page.dart';
import 'medications_bloc.dart';
import 'medications_page.dart';

import 'package:flutter_modular/flutter_modular.dart';

class MedicationsModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => MedicationsBloc()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(medications.routeName,
            child: (_, args) => MedicationsPage()),
        ModularRouter("/$REGISTER",
            child: (_, args) => MedicationRegisterPage()),
      ];
}
