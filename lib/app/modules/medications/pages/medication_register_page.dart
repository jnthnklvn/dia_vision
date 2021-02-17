import 'package:dia_vision/app/shared/components/ink_well_speak_text.dart';
import 'package:dia_vision/app/shared/components/rounded_input_field.dart';
import 'package:dia_vision/app/shared/components/back_arrow_button.dart';
import 'package:dia_vision/app/shared/components/rounded_button.dart';
import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

class MedicationRegisterPage extends StatefulWidget {
  @override
  _MedicationRegisterPageState createState() => _MedicationRegisterPageState();
}

class _MedicationRegisterPageState extends State<MedicationRegisterPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: BackArrowButton(iconPadding: 5),
        title: InkWellSpeakText(
          Text(
            MEDICATION_REGISTER,
            style: TextStyle(
              fontSize: 24,
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: size.height,
        color: Colors.white,
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RoundedInputField(
                hintText: "Nome comercial",
                onChanged: (value) {},
              ),
              RoundedInputField(
                hintText: "Nome da substância",
                onChanged: (value) {},
              ),
              RoundedInputField(
                hintText: "Dosagem",
                keyboardType: TextInputType.number,
                onChanged: (value) {},
              ),
              RoundedInputField(
                hintText: "Posologia",
                keyboardType: TextInputType.number,
                onChanged: (value) {},
              ),
              RoundedInputField(
                hintText: "Fim do tratamento",
                keyboardType: TextInputType.datetime,
                onChanged: (value) {},
              ),
              RoundedInputField(
                hintText: "Médico prescritor",
                keyboardType: TextInputType.text,
                onChanged: (value) {},
              ),
              RoundedInputField(
                hintText: "Efeitos colaterais",
                keyboardType: TextInputType.text,
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
