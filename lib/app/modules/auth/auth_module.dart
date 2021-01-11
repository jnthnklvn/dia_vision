import '../../shared/utils/route_enum.dart';

import 'recovery/recovery_bloc.dart';
import 'recovery/recovery_page.dart';
import 'register/register_bloc.dart';
import 'register/register_page.dart';
import 'login/login_bloc.dart';
import 'login/login_page.dart';

import 'package:flutter_modular/flutter_modular.dart';

class AuthModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => LoginBloc()),
        Bind((i) => RegisterBloc()),
        Bind((i) => RecoveryBloc()),
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
