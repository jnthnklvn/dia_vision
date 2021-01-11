import '../app/shared/utils/route_enum.dart';
import '../app/app_widget.dart';
import '../app/app_bloc.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

import 'modules/auth/auth_module.dart';
import 'modules/home/home_module.dart';
import 'modules/profile/profile_module.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppBloc()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(RouteEnum.home.name, module: HomeModule()),
        ModularRouter(RouteEnum.auth.name, module: AuthModule()),
        ModularRouter(RouteEnum.profile.name, module: ProfileModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();
}
