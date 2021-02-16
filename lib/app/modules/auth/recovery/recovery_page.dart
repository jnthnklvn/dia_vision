import '../../../../app/shared/components/back_arrow_button.dart';
import '../../../shared/components/rounded_input_field.dart';
import '../../../shared/components/rounded_button.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

class RecoveryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: size.height,
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
              SizedBox(height: size.height * 0.02),
              Image.asset(
                "assets/images/logo_name.png",
                width: size.width * 0.8,
              ),
              SizedBox(height: size.height * 0.1),
              RoundedInputField(
                hintText: "Email",
                onChanged: (value) {},
              ),
              SizedBox(height: size.height * 0.02),
              RoundedButton(
                text: "RECUPERAR",
                onPressed: Modular.to.pop,
              ),
              SizedBox(height: size.height * 0.08),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "Informe o email cadastrado e confirme. Um link para recuperação da senha será enviado por email.",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
