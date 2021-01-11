import '../../shared/utils/route_enum.dart';

import 'package:flutter_modular/flutter_modular.dart';

import 'my_data/my_data_bloc.dart';
import 'my_data/my_data_page.dart';
import 'profile_bloc.dart';
import 'profile_page.dart';

class ProfileModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => ProfileBloc()),
        Bind((i) => MyDataBloc()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter("/", child: (_, args) => ProfilePage()),
        ModularRouter(RouteEnum.my_data.name, child: (_, args) => MyDataPage()),
      ];
}
