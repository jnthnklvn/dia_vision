import 'package:dia_vision/app/shared/utils/route_enum.dart';

import 'package:flutter_modular/flutter_modular.dart';

import 'home_controller.dart';
import 'home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => HomeController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(RouteEnum.home.name, child: (_, args) => const HomePage()),
  ];
}
