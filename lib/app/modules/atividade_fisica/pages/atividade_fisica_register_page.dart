import 'package:dia_vision/app/modules/atividade_fisica/controllers/atividade_fisica_register_controller.dart';
import 'package:dia_vision/app/shared/components/ink_well_speak_text.dart';
import 'package:dia_vision/app/shared/components/rounded_input_field.dart';
import 'package:dia_vision/app/shared/utils/decimal_input_formatter.dart';
import 'package:dia_vision/app/shared/components/back_arrow_button.dart';
import 'package:dia_vision/app/shared/components/rounded_button.dart';
import 'package:dia_vision/app/shared/utils/scaffold_utils.dart';
import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/model/atividade_fisica.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class AtividadeFisicaRegisterPage extends StatefulWidget with ScaffoldUtils {
  final AtividadeFisica atividadeFisica;

  AtividadeFisicaRegisterPage(this.atividadeFisica);

  @override
  _AtividadeFisicaRegisterPageState createState() =>
      _AtividadeFisicaRegisterPageState(scaffoldKey);
}

class _AtividadeFisicaRegisterPageState extends ModularState<
    AtividadeFisicaRegisterPage, AtividadeFisicaRegisterController> {
  final GlobalKey<ScaffoldState> scaffoldKey;

  _AtividadeFisicaRegisterPageState(this.scaffoldKey);

  final focusNode = FocusNode();
  final focusNode1 = FocusNode();

  TextEditingController tipoController;
  TextEditingController duracaoController;
  TextEditingController distanciaController;

  @override
  void initState() {
    initControllers();
    super.initState();
  }

  void initControllers() {
    controller.init(widget.atividadeFisica);
    tipoController = TextEditingController(text: controller.tipo);
    duracaoController = TextEditingController(text: controller.duracao);
    distanciaController = TextEditingController(text: controller.distancia);
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
            EXERCISE_REGISTER,
            style: TextStyle(
              fontSize: kAppBarTitleSize,
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
                buildDropdownButton(size),
                (controller.tipo == ExerciseType.Caminhada.name ||
                        controller.tipo == ExerciseType.Corrida.name)
                    ? RoundedInputField(
                        hintText: "Distância (km)",
                        controller: distanciaController,
                        keyboardType: TextInputType.number,
                        onChanged: controller.setDistancia,
                        focusNode: focusNode,
                        nextFocusNode: focusNode1,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          DecimalInputFormatter(),
                        ],
                      )
                    : Container(),
                RoundedInputField(
                  hintText: "Duração (minutos)",
                  controller: duracaoController,
                  keyboardType: TextInputType.number,
                  onChanged: controller.setDuracao,
                  focusNode: focusNode1,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
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
                        widget.onSuccess(REGISTRED_WITH_SUCCESS);
                        await Future.delayed(Duration(milliseconds: 1500));
                        Modular.to.pop();
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
          onTap: () => Modular.get<FlutterTts>()
              .speak(controller.tipo ?? "Selecione o tipo"),
          child: Icon(
            Icons.play_circle_fill,
            color: kPrimaryColor,
            size: 42,
          ),
        ),
        title: DropdownButton<String>(
          value: controller.tipo,
          icon: const Icon(
            Icons.keyboard_arrow_down_sharp,
            color: kPrimaryColor,
            size: 32,
          ),
          isExpanded: true,
          hint: Text(
            "Selecione o tipo",
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: 20,
            ),
          ),
          elevation: 16,
          style: const TextStyle(
            color: kPrimaryColor,
            fontSize: 20,
          ),
          underline: Container(),
          onChanged: controller.setTipo,
          items: ExerciseType.values
              .map<DropdownMenuItem<String>>((ExerciseType value) {
            return DropdownMenuItem<String>(
              value: value.name,
              child: Text(value.name),
            );
          }).toList(),
        ),
      ),
    );
  }
}
