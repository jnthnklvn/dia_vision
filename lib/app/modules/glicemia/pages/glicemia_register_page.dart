import 'package:dia_vision/app/modules/glicemia/controllers/glicemia_register_controller.dart';
import 'package:dia_vision/app/shared/components/floating_options_button.dart';
import 'package:dia_vision/app/shared/components/ink_well_speak_text.dart';
import 'package:dia_vision/app/shared/components/rounded_input_field.dart';
import 'package:dia_vision/app/shared/utils/horario_input_formatter.dart';
import 'package:dia_vision/app/shared/components/back_arrow_button.dart';
import 'package:dia_vision/app/modules/home/domain/entities/module.dart';
import 'package:dia_vision/app/shared/components/alert_msg_dialog.dart';
import 'package:dia_vision/app/shared/components/rounded_button.dart';
import 'package:dia_vision/app/shared/utils/scaffold_utils.dart';
import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';
import 'package:dia_vision/app/model/glicemia.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class GlicemiaRegisterPage extends StatefulWidget with ScaffoldUtils {
  final Glicemia? glicemia;

  GlicemiaRegisterPage(this.glicemia, {Key? key}) : super(key: key);

  @override
  _GlicemiaRegisterPageState createState() => _GlicemiaRegisterPageState();
}

class _GlicemiaRegisterPageState
    extends ModularState<GlicemiaRegisterPage, GlicemiaRegisterController> {
  final _focusNode1 = FocusNode();
  final _focusNode2 = FocusNode();

  TextEditingController? valorController;
  TextEditingController? horarioController;

  @override
  void initState() {
    initControllers();
    super.initState();
  }

  void initControllers() {
    controller.init(widget.glicemia);
    valorController = TextEditingController(text: controller.valor);
    horarioController = TextEditingController(text: controller.horarioFixo);
  }

  Future<void> _showMyDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertMsgDialog(
          () {
            Modular.to.popUntil(ModalRoute.withName(glicemy.routeName));
          },
          'Entendi',
          '''Uma ${controller.isHiperGlicemia ? 'alta' : 'baixa'} nos limites de glicemia foi detectada, gerando um alerta de ${controller.isHiperGlicemia ? 'hiperglicemia' : 'hipoglicemia'}.''',
          "Alerta de ${controller.isHiperGlicemia ? 'hiperglicemia' : 'hipoglicemia'}",
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: widget.scaffoldKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const FloatingOptionsButton(),
      appBar: AppBar(
        leading: const BackArrowButton(iconPadding: 5),
        title: const InkWellSpeakText(
          Text(
            glicemyRegister,
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
        padding: const EdgeInsets.only(top: 20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Observer(builder: (_) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RoundedInputField(
                  hintText: "Valor (mg/dL)",
                  controller: valorController,
                  keyboardType: TextInputType.number,
                  onChanged: controller.setValor,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  focusNode: _focusNode1,
                  nextFocusNode: _focusNode2,
                ),
                buildDropdownButton(size),
                controller.horario != "Outro"
                    ? Container()
                    : RoundedInputField(
                        hintText: "Horário",
                        controller: horarioController,
                        keyboardType: TextInputType.number,
                        onChanged: controller.setHorarioFixo,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          HorarioInputFormatter(),
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
                        if (controller.isHiperGlicemia ||
                            controller.isHipoGlicemia) {
                          _showMyDialog();
                        } else {
                          controller.isEdicao
                              ? widget.onSuccess("Atualizado com sucesso!")
                              : Modular.to.pop();
                        }
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
            : const Color(0xFFF5F6F9),
        borderRadius: BorderRadius.circular(29),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        leading: Semantics(
          excludeSemantics: true,
          child: InkWell(
            onTap: () => Modular.get<FlutterTts>()
                .speak(controller.horario ?? "Selecione o horário"),
            child: const Icon(
              Icons.play_circle_fill,
              color: kPrimaryColor,
              size: 42,
            ),
          ),
        ),
        title: DropdownButton<String>(
          focusNode: _focusNode2,
          value: controller.horario,
          icon: const Icon(
            Icons.keyboard_arrow_down_sharp,
            color: kPrimaryColor,
            size: 32,
          ),
          isExpanded: true,
          hint: Text(
            "Selecione o horário",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          elevation: 16,
          style: Theme.of(context).textTheme.bodyText1,
          underline: Container(),
          onChanged: controller.setHorario,
          items: HorarioType.values
              .map<DropdownMenuItem<String>>((HorarioType value) {
            return DropdownMenuItem<String>(
              value: value.displayTitle,
              child: Text(value.displayTitle ?? ''),
            );
          }).toList(),
        ),
      ),
    );
  }
}
