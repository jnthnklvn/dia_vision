import '../../../../app/shared/components/back_arrow_button.dart';
import '../../../shared/components/rounded_password_field.dart';
import '../../../shared/components/rounded_input_field.dart';
import '../components/already_have_an_account_acheck.dart';
import '../../../shared/components/rounded_button.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: size.height,
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  BackArrowButton(),
                ],
              ),
              SizedBox(height: size.height * 0.08),
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
                text: "REGISTRAR",
                onPressed: Modular.to.pop,
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                login: false,
                onPressed: Modular.to.pop,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
