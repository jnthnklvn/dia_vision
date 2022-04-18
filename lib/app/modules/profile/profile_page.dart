import 'package:dia_vision/app/shared/components/floating_options_button.dart';
import 'package:dia_vision/app/shared/components/back_arrow_button.dart';
import 'package:dia_vision/app/shared/utils/route_enum.dart';
import 'package:dia_vision/app/app_controller.dart';

import 'components/profile_menu.dart';
import 'components/profile_pic.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final String title;
  const ProfilePage({Key? key, this.title = "Profile"}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const FloatingOptionsButton(visible: true),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                children: const [
                  BackArrowButton(),
                ],
              ),
              const SizedBox(height: 20),
              const ProfilePic(),
              const SizedBox(height: 40),
              ProfileMenu(
                text: "Meus dados",
                icon: "assets/icons/User Icon.svg",
                onPressed: () => Modular.to.pushNamed(
                    "${RouteEnum.profile.name}${RouteEnum.myData.name}/"),
              ),
              ProfileMenu(
                text: "Preferências",
                icon: "assets/icons/Settings.svg",
                onPressed: () => Modular.to.pushNamed(
                    "${RouteEnum.profile.name}${RouteEnum.preferences.name}/"),
              ),
              ProfileMenu(
                text: "Sair",
                icon: "assets/icons/Log out.svg",
                onPressed: () async {
                  await Modular.get<AppController>().logout();
                  Modular.to.pushReplacementNamed('${RouteEnum.auth.name}/');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
