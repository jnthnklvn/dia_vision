import '../../../shared/components/rounded_password_field.dart';
import '../../../shared/components/rounded_input_field.dart';
import '../components/already_have_an_account_acheck.dart';
import '../../..//shared/components/rounded_button.dart';
import '../../../shared/utils/route_enum.dart';
import '../../../shared/utils/constants.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.15),
              Image.asset(
                "assets/images/logo_name.png",
                width: size.width * 0.8,
              ),
              SizedBox(height: size.height * 0.1),
              RoundedInputField(
                hintText: "Email",
                onChanged: (value) {},
              ),
              RoundedPasswordField(
                onChanged: (value) {},
              ),
              RoundedButton(
                text: "ENTRAR",
                onPressed: () => Modular.to.pushNamed(RouteEnum.home.name),
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                onPressed: () => Modular.to
                    .pushNamed(RouteEnum.auth.name + RouteEnum.register.name),
              ),
              GestureDetector(
                onTap: () => Modular.to
                    .pushNamed(RouteEnum.auth.name + RouteEnum.recovery.name),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Esqueceu sua senha? ",
                      style: TextStyle(color: kPrimaryColor, fontSize: 18),
                    ),
                    Text(
                      "Recuperar senha.",
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
