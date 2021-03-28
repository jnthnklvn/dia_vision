import 'package:dia_vision/app/modules/avaliacao_pes/controllers/avaliacao_pes_register_controller.dart';
import 'package:dia_vision/app/shared/components/ink_well_speak_text.dart';
import 'package:dia_vision/app/shared/components/rounded_input_field.dart';
import 'package:dia_vision/app/shared/components/back_arrow_button.dart';
import 'package:dia_vision/app/shared/components/rounded_button.dart';
import 'package:dia_vision/app/shared/utils/scaffold_utils.dart';
import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';
import 'package:dia_vision/app/model/avaliacao_pes.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class AvaliacaoPesRegisterPage extends StatefulWidget with ScaffoldUtils {
  final AvaliacaoPes avaliacaoPes;

  AvaliacaoPesRegisterPage(this.avaliacaoPes);

  @override
  _AvaliacaoPesRegisterPageState createState() =>
      _AvaliacaoPesRegisterPageState(scaffoldKey);
}

class _AvaliacaoPesRegisterPageState extends ModularState<
    AvaliacaoPesRegisterPage, AvaliacaoPesRegisterController> {
  final GlobalKey<ScaffoldState> scaffoldKey;

  _AvaliacaoPesRegisterPageState(this.scaffoldKey);

  TextEditingController temperaturaLavagemController;
  TextEditingController dataUltimaConsultaController;

  @override
  void initState() {
    initControllers();
    super.initState();
  }

  void initControllers() {
    controller.init(widget.avaliacaoPes);

    dataUltimaConsultaController =
        TextEditingController(text: controller.dataUltimaConsulta);
    temperaturaLavagemController =
        TextEditingController(text: controller.temperaturaLavagem);
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
            FEET_CHECK_REGISTER,
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
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Observer(builder: (_) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RoundedInputField(
                  hintText: "Data da última consulta",
                  controller: dataUltimaConsultaController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    DataInputFormatter(),
                  ],
                  onChanged: controller.setDataUltimaConsulta,
                ),
                buildDropdownButton(size),
                buildListTileSwitch(
                  controller.pontosVermelhos,
                  "Possuem pontos vermelhos?",
                  controller.setPontosVermelhos,
                ),
                buildListTileSwitch(
                  controller.calos,
                  "Possuem calos?",
                  controller.setCalos,
                ),
                buildListTileSwitch(
                  controller.usaProtetorSolarPes,
                  "Usa protetor solar nos pés?",
                  controller.setUsaProtetorSolarPes,
                ),
                buildListTileSwitch(
                  controller.checaAntesCalcar,
                  "Checa sapatos antes de calçar?",
                  controller.setChecaAntesCalcar,
                ),
                buildListTileSwitch(
                  controller.rachaduras,
                  "Possuem rachaduras?",
                  controller.setRachaduras,
                ),
                buildListTileSwitch(
                  controller.hidratados,
                  "Estão hidratados?",
                  controller.setHidratados,
                ),
                buildListTileSwitch(
                  controller.cortaUnhas,
                  "Corta as unhas?",
                  controller.setCortaUnhas,
                ),
                buildListTileSwitch(
                  controller.secou,
                  "Secou?",
                  controller.setSecou,
                ),
                buildListTileSwitch(
                  controller.lavou,
                  "Lavou?",
                  controller.setLavou,
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
                        controller.isEdicao
                            ? widget.onSuccess("Atualizado com sucesso!")
                            : Modular.to.pop();
                      },
                    ),
                  );
                }),
              ],
            );
          }),
        ),
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
              fontSize: 20,
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
          onTap: () => Modular.get<FlutterTts>().speak(
              controller.temperaturaLavagem ??
                  "Selecione uma opção de temperatura"),
          child: Icon(
            Icons.play_circle_fill,
            color: kPrimaryColor,
            size: 42,
          ),
        ),
        title: DropdownButton<String>(
          value: controller.temperaturaLavagem,
          icon: const Icon(
            Icons.keyboard_arrow_down_sharp,
            color: kPrimaryColor,
            size: 32,
          ),
          isExpanded: true,
          hint: Text(
            "Selecione uma temperatura",
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 18,
            ),
          ),
          elevation: 16,
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 18,
          ),
          underline: Container(),
          onChanged: controller.setTemperaturaLavagem,
          items: <String>['Quente', 'Morno', 'Frio']
              .map<DropdownMenuItem<String>>((value) {
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
