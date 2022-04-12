import 'package:dia_vision/app/shared/components/container_field_horarios.dart';
import 'package:dia_vision/app/shared/components/floating_options_button.dart';
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
  PreferenciasPage({Key? key}) : super(key: key);

  @override
  _PreferenciasPageState createState() => _PreferenciasPageState();
}

class _PreferenciasPageState
    extends ModularState<PreferenciasPage, PreferenciasController>
    with SingleTickerProviderStateMixin {
  final _focusNode1 = FocusNode();
  final _focusNode2 = FocusNode();
  final _focusNode3 = FocusNode();

  TextEditingController? valorMinimoController;
  TextEditingController? valorMaximoController;
  TextEditingController? horarioGlicemiaController;

  @override
  void initState() {
    initControllers();
    super.initState();
  }

  Future<void> initControllers() async {
    await controller.getData(widget.onError);
    horarioGlicemiaController =
        TextEditingController(text: controller.horarioGlicemia);
    valorMinimoController =
        TextEditingController(text: controller.valorMinimoGlicemia);
    valorMaximoController =
        TextEditingController(text: controller.valorMaximoGlicemia);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: widget.scaffoldKey,
      floatingActionButton: const FloatingOptionsButton(),
      appBar: AppBar(
        leading: const BackArrowButton(iconPadding: 5),
        title: const InkWellSpeakText(
          Text(
            "Preferências",
            style: TextStyle(
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
        child: Observer(builder: (_) {
          if (!controller.isDataReady) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  alignment: Alignment.centerLeft,
                  child: InkWellSpeakText(
                    Text(
                      "Notificações e alertas",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1?.color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                buildListTileSwitch(
                  controller.alertarGlicemia,
                  "Glicemia",
                  (bool alertarGlicemia) {
                    controller.setAlertarGlicemia(alertarGlicemia);
                    alertarGlicemia
                        ? controller.enableNotification(widget.onError)
                        : controller.disableNotification(
                            widget.onError, widget.onSuccess);
                  },
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
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  alignment: Alignment.centerLeft,
                  child: InkWellSpeakText(
                    Text(
                      "Tempo para relembrete",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1?.color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                buildDropdownButton(size),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  alignment: Alignment.centerLeft,
                  child: InkWellSpeakText(
                    Text(
                      "Glicemia",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1?.color,
                        fontWeight: FontWeight.w600,
                      ),
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
                  nextFocusNode: _focusNode3,
                ),
                controller.alertarGlicemia
                    ? Observer(
                        builder: (_) {
                          return ContainerFieldHorarios(
                            context: context,
                            horarios: controller.horarios,
                            setHorario: controller.setHorario,
                            addHorario: controller.addHorario,
                            removeHorario: controller.removeHorario,
                          );
                        },
                      )
                    : Container(),
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
      margin: const EdgeInsets.only(left: 15, right: 10),
      child: ListTile(
        title: InkWellSpeakText(
          Text(
            text,
            style: const TextStyle(
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
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      width: size.width * 0.9,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color.fromARGB(246, 36, 36, 36)
            : const Color(0xFFF5F6F9),
        borderRadius: BorderRadius.circular(29),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        leading: Semantics(
          excludeSemantics: true,
          child: InkWell(
            onTap: () =>
                Modular.get<FlutterTts>().speak(controller.tempoLembrete),
            child: const Icon(
              Icons.play_circle_fill,
              color: kPrimaryColor,
              size: 42,
            ),
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
            style: Theme.of(context).textTheme.bodyText1,
          ),
          elevation: 16,
          style: Theme.of(context).textTheme.bodyText1,
          underline: Container(),
          onChanged: controller.setTempoLembrete,
          items: ["3 min", "5 min", "10 min", "20 min", "30 min", "60 min"]
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
