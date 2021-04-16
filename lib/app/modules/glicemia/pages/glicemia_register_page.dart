import 'package:dia_vision/app/modules/glicemia/controllers/glicemia_register_controller.dart';
import 'package:dia_vision/app/shared/components/ink_well_speak_text.dart';
import 'package:dia_vision/app/shared/components/rounded_input_field.dart';
import 'package:dia_vision/app/shared/utils/horario_input_formatter.dart';
import 'package:dia_vision/app/shared/components/back_arrow_button.dart';
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
  final Glicemia glicemia;

  GlicemiaRegisterPage(this.glicemia);

  @override
  _GlicemiaRegisterPageState createState() =>
      _GlicemiaRegisterPageState(scaffoldKey);
}

class _GlicemiaRegisterPageState
    extends ModularState<GlicemiaRegisterPage, GlicemiaRegisterController> {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final _focusNode1 = FocusNode();
  final _focusNode2 = FocusNode();

  _GlicemiaRegisterPageState(this.scaffoldKey);

  TextEditingController valorController;
  TextEditingController horarioController;

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: BackArrowButton(iconPadding: 5),
        title: InkWellSpeakText(
          Text(
            GLICEMY_REGISTER,
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
        padding: const EdgeInsets.only(top: 20),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
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
              .speak(controller.horario ?? "Selecione o horário"),
          child: Icon(
            Icons.play_circle_fill,
            color: kPrimaryColor,
            size: 42,
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
          onChanged: controller.setHorario,
          items: HorarioType.values
              .map<DropdownMenuItem<String>>((HorarioType value) {
            return DropdownMenuItem<String>(
              value: value.displayTitle,
              child: Text(value.displayTitle),
            );
          }).toList(),
        ),
      ),
    );
  }
}
