import 'package:dia_vision/app/shared/utils/route_enum.dart';
import 'package:dia_vision/app/shared/utils/utils.dart';

import 'recovery/recovery_controller.dart';
import 'recovery/recovery_page.dart';
import 'register/register_controller.dart';
import 'register/register_page.dart';
import 'login/login_controller.dart';
import 'login/login_page.dart';

import 'package:flutter_modular/flutter_modular.dart';

class AuthModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => Utils()),
        Bind((i) => LoginController(i(), i())),
        Bind((i) => RegisterController(i(), i())),
        Bind((i) => RecoveryController(i(), i())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter("/", child: (_, args) => LoginPage()),
        ModularRouter(RouteEnum.register.name,
            child: (_, args) => RegisterPage()),
        ModularRouter(RouteEnum.recovery.name,
            child: (_, args) => RecoveryPage()),
      ];
}
