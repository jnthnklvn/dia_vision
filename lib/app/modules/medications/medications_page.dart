import 'package:dia_vision/app/modules/medications/widgets/medication_widget.dart';
import 'package:dia_vision/app/shared/components/ink_well_speak_text.dart';
import 'package:dia_vision/app/modules/home/domain/entities/module.dart';
import 'package:dia_vision/app/shared/components/back_arrow_button.dart';
import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';

class MedicationsPage extends StatefulWidget {
  @override
  _MedicationsPageState createState() => _MedicationsPageState();
}

class _MedicationsPageState extends State<MedicationsPage> {
  Future _speak(String txt) => Modular.get<FlutterTts>().speak(txt);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        backgroundColor: kPrimaryColor,
        child: InkWell(
          onTap: () =>
              Modular.to.pushNamed("${medications.routeName}/$REGISTER"),
          onLongPress: () => _speak("$BUTTON $ADD $REGISTRY"),
          child: Icon(Icons.add),
        ),
      ),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onLongPress: () => _speak("$BUTTON $SHARE $REGISTRY"),
              child: Icon(
                Icons.share,
                size: 32,
                color: kPrimaryColor,
              ),
            ),
          ),
        ],
        leading: BackArrowButton(iconPadding: 5),
        title: InkWellSpeakText(
          Text(
            MEDICATIONS,
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
        margin: EdgeInsets.all(10),
        child: true
            ? ListView(
                children: [
                  MedicationWidget("Dorflex",
                      "Posologia: 2 pílulas \nDosagem: 2 vezes por dia"),
                  MedicationWidget("Rinossorso",
                      "Posologia: 2 pílulas \nDosagem: 3 vezes por dia"),
                  MedicationWidget("Rivotril",
                      "Posologia: 2 pílulas \nDosagem: 3 vezes por dia"),
                  MedicationWidget("Minoxidil",
                      "Posologia: 2 pílulas \nDosagem: 1 vezes por dia"),
                  MedicationWidget("Dorfxclex",
                      "Posologia: 2 pílulas \nDosagem: 2 vezes por dia"),
                  MedicationWidget("Rinoaxzssorso",
                      "Posologia: 2 pílulas \nDosagem: 3 vezes por dia"),
                  MedicationWidget("Rivotcaril",
                      "Posologia: 2 pílulas \nDosagem: 3 vezes por dia"),
                  MedicationWidget("Minoavxidil",
                      "Posologia: 2 pílulas \nDosagem: 1 vezes por dia"),
                ],
              )
            : InkWellSpeakText(
                Text(
                  WITHOUT_MEDICACOES_REGISTERED,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, color: kPrimaryColor),
                ),
              ),
      ),
    );
  }
}
