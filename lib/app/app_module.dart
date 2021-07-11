import 'package:dia_vision/app/shared/preferences/preferencias_preferences.dart';
import 'package:dia_vision/app/shared/local_storage/local_storage_shared.dart';
import 'package:dia_vision/app/shared/preferences/config_preferences.dart';
import 'package:dia_vision/app/repositories/user_repository.dart';
import 'package:dia_vision/app/modules/splash/intro_page.dart';
import 'package:dia_vision/app/shared/utils/route_enum.dart';
import 'package:dia_vision/app/shared/utils/utils.dart';
import 'package:dia_vision/app/app_widget.dart';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';

import 'modules/atividade_fisica/atividade_fisica_module.dart';
import 'modules/avaliacao_pes/avaliacao_pes_module.dart';
import 'modules/centro_saude/centro_saude_module.dart';
import 'modules/autocuidado/autocuidado_module.dart';
import 'modules/medications/medications_module.dart';
import 'modules/alimentacao/alimentacao_module.dart';
import 'modules/app_visao/app_visao_module.dart';
import 'modules/glicemia/glicemia_module.dart';
import 'modules/diurese/diurese_module.dart';
import 'modules/profile/profile_module.dart';
import 'modules/auth/auth_module.dart';
import 'modules/home/home_module.dart';

import 'app_controller.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => Utils()),
        Bind((i) => FlutterTts()),
        Bind((i) => UserRepository()),
        Bind((i) => LocalStorageShared()),
        Bind((i) => ConfigPreferences(i())),
        Bind((i) => AwesomeNotifications()),
        Bind((i) => PreferenciasPreferences(i())),
        Bind((i) => AppController(i(), i(), i())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(RouteEnum.home.name, module: HomeModule()),
        ModularRouter(RouteEnum.splash.name, child: (_, args) => IntroPage()),
        ModularRouter(RouteEnum.auth.name, module: AuthModule()),
        ModularRouter(RouteEnum.profile.name, module: ProfileModule()),
        ModularRouter(RouteEnum.medications.name, module: MedicationsModule()),
        ModularRouter(RouteEnum.feet.name, module: AvaliacaoPesModule()),
        ModularRouter(RouteEnum.kidney.name, module: DiureseModule()),
        ModularRouter(RouteEnum.glicemy.name, module: GlicemiaModule()),
        ModularRouter(RouteEnum.selfCare.name, module: AutocuidadoModule()),
        ModularRouter(RouteEnum.medicalCenters.name,
            module: CentroSaudeModule()),
        ModularRouter(RouteEnum.vision.name, module: AppVisaoModule()),
        ModularRouter(RouteEnum.exercises.name,
            module: AtividadeFisicaModule()),
        ModularRouter(RouteEnum.alimentation.name, module: AlimentacaoModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();
}
