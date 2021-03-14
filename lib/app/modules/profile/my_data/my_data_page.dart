import 'package:dia_vision/app/shared/components/rounded_password_field.dart';
import 'package:dia_vision/app/shared/components/ink_well_speak_text.dart';
import 'package:dia_vision/app/shared/components/rounded_input_field.dart';
import 'package:dia_vision/app/shared/components/back_arrow_button.dart';
import 'package:dia_vision/app/shared/components/rounded_button.dart';
import 'package:dia_vision/app/shared/utils/constants.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

class MyDataPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: BackArrowButton(iconPadding: 5),
        title: InkWellSpeakText(
          Text(
            "Edite seus dados",
            style: TextStyle(
              fontSize: 24,
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          Icon(
            Icons.save,
            size: 32,
            color: kPrimaryColor,
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: size.height,
        color: Colors.white,
        padding: const EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RoundedInputField(
                hintText: "jonathan.santos@dcomp.ufs.br",
                enabled: false,
                icon: Icons.person,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {},
              ),
              RoundedInputField(
                hintText: "Nome",
                onChanged: (value) {},
              ),
              RoundedInputField(
                hintText: "Telefone",
                onChanged: (value) {},
              ),
              RoundedInputField(
                hintText: "Data de Nascimento",
                keyboardType: TextInputType.datetime,
                onChanged: (value) {},
              ),
              RoundedInputField(
                hintText: "Peso",
                keyboardType: TextInputType.number,
                onChanged: (value) {},
              ),
              RoundedInputField(
                hintText: "Altura",
                keyboardType: TextInputType.number,
                onChanged: (value) {},
              ),
              RoundedPasswordField(
                hintText: "Confirme sua senha",
                onChanged: (value) {},
              ),
              RoundedButton(
                text: "SALVAR",
                onPressed: Modular.to.pop,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
