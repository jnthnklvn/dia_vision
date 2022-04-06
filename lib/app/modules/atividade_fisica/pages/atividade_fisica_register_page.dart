import 'package:dia_vision/app/modules/atividade_fisica/controllers/atividade_fisica_register_controller.dart';
import 'package:dia_vision/app/shared/components/floating_options_button.dart';
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
  final AtividadeFisica? atividadeFisica;

  AtividadeFisicaRegisterPage(this.atividadeFisica, {Key? key})
      : super(key: key);

  @override
  _AtividadeFisicaRegisterPageState createState() =>
      _AtividadeFisicaRegisterPageState();
}

class _AtividadeFisicaRegisterPageState extends ModularState<
    AtividadeFisicaRegisterPage, AtividadeFisicaRegisterController> {
  final focusNode = FocusNode();
  final focusNode1 = FocusNode();

  TextEditingController? tipoController;
  TextEditingController? tipo2Controller;
  TextEditingController? duracaoController;
  TextEditingController? distanciaController;

  @override
  void initState() {
    initControllers();
    super.initState();
  }

  void initControllers() {
    controller.init(widget.atividadeFisica);
    tipoController = TextEditingController(text: controller.tipo);
    tipo2Controller = TextEditingController(text: controller.tipo2);
    duracaoController = TextEditingController(text: controller.duracao);
    distanciaController = TextEditingController(text: controller.distancia);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingOptionsButton(),
      key: widget.scaffoldKey,
      appBar: AppBar(
        leading: const BackArrowButton(iconPadding: 5),
        title: const InkWellSpeakText(
          Text(
            exerciseRegister,
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
        color: Theme.of(context).backgroundColor,
        padding: const EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Observer(builder: (_) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                buildDropdownButton(size),
                (controller.tipo == ExerciseType.caminhada.name ||
                        controller.tipo == ExerciseType.corrida.name)
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
                (controller.tipo == ExerciseType.outro.name)
                    ? RoundedInputField(
                        hintText: "Tipo",
                        controller: tipo2Controller,
                        keyboardType: TextInputType.text,
                        onChanged: controller.setTipo2,
                        focusNode: focusNode,
                        nextFocusNode: focusNode1,
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
                  if (controller.isLoading) {
                    return Center(
                        child: Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      child: const CircularProgressIndicator(),
                    ));
                  }
                  return RoundedButton(
                    text: "SALVAR",
                    onPressed: () => controller.save(
                      widget.onError,
                      () async {
                        widget.onSuccess(registeredWithSuccess);
                        await Future.delayed(
                            const Duration(milliseconds: 1500));
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
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      width: size.width * 0.9,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color.fromARGB(246, 36, 36, 36)
            : kPrimaryLightColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        leading: Semantics(
          excludeSemantics: true,
          child: InkWell(
            onTap: () => Modular.get<FlutterTts>()
                .speak(controller.tipo ?? "Selecione o tipo"),
            child: const Icon(
              Icons.play_circle_fill,
              color: kPrimaryColor,
              size: 42,
            ),
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
              color: Theme.of(context).textTheme.bodyText1?.color,
              fontSize: 18,
            ),
          ),
          elevation: 16,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyText1?.color,
            fontSize: 18,
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
