import 'package:dia_vision/app/shared/components/rounded_input_field.dart';
import 'package:dia_vision/app/shared/components/ink_well_speak_text.dart';
import 'package:dia_vision/app/shared/components/back_arrow_button.dart';
import 'package:dia_vision/app/shared/components/rounded_button.dart';
import 'package:dia_vision/app/shared/utils/scaffold_utils.dart';
import 'package:dia_vision/app/shared/utils/constants.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'preferencias_controller.dart';

class PreferenciasPage extends StatefulWidget with ScaffoldUtils {
  @override
  _PreferenciasPageState createState() => _PreferenciasPageState(scaffoldKey);
}

class _PreferenciasPageState
    extends ModularState<PreferenciasPage, PreferenciasController>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final _focusNode1 = FocusNode();
  final _focusNode2 = FocusNode();

  _PreferenciasPageState(this.scaffoldKey);

  TextEditingController valorMinimoController;
  TextEditingController valorMaximoController;

  @override
  void initState() {
    initControllers();
    super.initState();
  }

  Future<void> initControllers() async {
    await controller.getData(widget.onError);
    valorMinimoController =
        TextEditingController(text: controller.valorMinimoGlicemia);
    valorMaximoController =
        TextEditingController(text: controller.valorMaximoGlicemia);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: BackArrowButton(iconPadding: 5),
        title: InkWellSpeakText(
          Text(
            "Preferências",
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
        padding: const EdgeInsets.only(top: 10),
        child: Observer(builder: (_) {
          if (!controller.isDataReady)
            return Center(child: CircularProgressIndicator());
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                buildListTileSwitch(
                  controller.alertarGlicemia,
                  "Glicemia",
                  controller.setAlertarGlicemia,
                ),
                buildListTileSwitch(
                  controller.alertarHipoHiperGlicemia,
                  "Hipo e hiper glicemia",
                  controller.setAlertarHipoHiperGlicemia,
                ),
                buildListTileSwitch(
                  controller.alertarMedicacao,
                  "Medicação",
                  controller.setAlertarMedicacao,
                ),
                SizedBox(height: 30),
                InkWellSpeakText(
                  Text(
                    "Tempo para relembrete",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                buildDropdownButton(size),
                SizedBox(height: 30),
                InkWellSpeakText(
                  Text(
                    "Limites de glicemia",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                RoundedInputField(
                  hintText: "Valor mínimo (mg/dL)",
                  controller: valorMinimoController,
                  keyboardType: TextInputType.number,
                  onChanged: controller.setValorMinimoGlicemia,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  focusNode: _focusNode1,
                  nextFocusNode: _focusNode2,
                ),
                RoundedInputField(
                  hintText: "Valor máximo (mg/dL)",
                  controller: valorMaximoController,
                  keyboardType: TextInputType.number,
                  onChanged: controller.setValorMaximoGlicemia,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  focusNode: _focusNode2,
                ),
                Observer(builder: (_) {
                  if (controller.isLoading)
                    return Center(
                        child: Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: CircularProgressIndicator(),
                    ));
                  return RoundedButton(
                    text: "SALVAR",
                    onPressed: () => controller.save(
                      widget.onError,
                      () async {
                        widget.onSuccess("Atualizado com sucesso!");
                      },
                    ),
                  );
                }),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget buildListTileSwitch(
    bool value,
    String text,
    void Function(bool) onChanged,
  ) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 10),
      child: ListTile(
        title: InkWellSpeakText(
          Text(
            text,
            style: TextStyle(
              fontSize: 22,
              color: kPrimaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          inactiveThumbColor: Colors.red[700],
          inactiveTrackColor: Colors.red[100],
        ),
      ),
    );
  }

  Widget buildDropdownButton(Size size) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      width: size.width * 0.9,
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
        leading: InkWell(
          onTap: () =>
              Modular.get<FlutterTts>().speak(controller.tempoLembrete),
          child: Icon(
            Icons.play_circle_fill,
            color: kPrimaryColor,
            size: 42,
          ),
        ),
        title: DropdownButton<String>(
          value: controller.tempoLembrete,
          icon: const Icon(
            Icons.keyboard_arrow_down_sharp,
            color: kPrimaryColor,
            size: 32,
          ),
          isExpanded: true,
          hint: Text(
            "Selecione o tempo para relembrete",
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 20,
            ),
          ),
          elevation: 16,
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 20,
          ),
          underline: Container(),
          onChanged: controller.setTempoLembrete,
          items: ["10 min", "30 min", "60 min"]
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
