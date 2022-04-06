import 'package:dia_vision/app/shared/utils/route_enum.dart';
import 'package:dia_vision/app/shared/utils/utils.dart';

import 'recovery/recovery_controller.dart';
import 'recovery/recovery_page.dart';
import 'register/register_controller.dart';
import 'register/register_page.dart';
import 'login/login_controller.dart';
import 'login/login_page.dart';

import 'package:flutter_modular/flutter_modular.dart';

class AuthModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => Utils()),
    Bind((i) => LoginController(i(), i(), i())),
    Bind((i) => RegisterController(i(), i())),
    Bind((i) => RecoveryController(i(), i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => LoginPage()),
    ChildRoute('${RouteEnum.register.name}/',
        child: (_, args) => RegisterPage()),
    ChildRoute('${RouteEnum.recovery.name}/',
        child: (_, args) => RecoveryPage()),
  ];
}
