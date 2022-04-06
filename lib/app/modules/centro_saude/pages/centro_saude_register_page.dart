import 'package:dia_vision/app/modules/centro_saude/controllers/centro_saude_register_controller.dart';
import 'package:dia_vision/app/shared/components/ink_well_speak_text.dart';
import 'package:dia_vision/app/shared/components/rounded_input_field.dart';
import 'package:dia_vision/app/shared/components/back_arrow_button.dart';
import 'package:dia_vision/app/shared/components/rounded_button.dart';
import 'package:dia_vision/app/shared/utils/scaffold_utils.dart';
import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';
import 'package:dia_vision/app/model/centro_saude.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class CentroSaudeRegisterPage extends StatefulWidget with ScaffoldUtils {
  final CentroSaude centroSaude;

  CentroSaudeRegisterPage(this.centroSaude, {Key? key}) : super(key: key);

  @override
  _CentroSaudeRegisterPageState createState() =>
      _CentroSaudeRegisterPageState();
}

class _CentroSaudeRegisterPageState extends ModularState<
    CentroSaudeRegisterPage, CentroSaudeRegisterController> {
  final focusNode = FocusNode();
  final focusNode1 = FocusNode();
  final focusNode2 = FocusNode();
  final focusNode3 = FocusNode();
  final focusNode4 = FocusNode();
  final focusNode5 = FocusNode();
  final focusNode6 = FocusNode();
  final focusNode7 = FocusNode();
  final focusNode8 = FocusNode();
  final focusNode9 = FocusNode();

  final nomeController = TextEditingController();
  final tipoController = TextEditingController();
  final telefoneController = TextEditingController();
  final descricaoController = TextEditingController();
  final linkController = TextEditingController();
  final cidadeController = TextEditingController();
  final estadoController = TextEditingController();
  final bairroController = TextEditingController();
  final numeroController = TextEditingController();
  final ruaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: widget.scaffoldKey,
      appBar: AppBar(
        leading: const BackArrowButton(iconPadding: 5),
        title: const InkWellSpeakText(
          Text(
            suggestMedicalCenterRegister,
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
          physics: const BouncingScrollPhysics(),
          child: Observer(builder: (_) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RoundedInputField(
                  hintText: "Nome",
                  controller: nomeController,
                  keyboardType: TextInputType.text,
                  onChanged: controller.setNome,
                  focusNode: focusNode,
                  nextFocusNode: focusNode1,
                ),
                RoundedInputField(
                  onChanged: controller.setTelefone,
                  controller: telefoneController,
                  keyboardType: TextInputType.number,
                  hintText: "Telefone para contato",
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    TelefoneInputFormatter(),
                  ],
                  focusNode: focusNode1,
                  nextFocusNode: focusNode2,
                ),
                RoundedInputField(
                  hintText: "Descrição",
                  controller: descricaoController,
                  keyboardType: TextInputType.text,
                  onChanged: controller.setDescricao,
                  focusNode: focusNode2,
                  nextFocusNode: focusNode3,
                ),
                RoundedInputField(
                  hintText: "Tipo",
                  controller: tipoController,
                  keyboardType: TextInputType.text,
                  onChanged: controller.setTipo,
                  focusNode: focusNode3,
                  nextFocusNode: focusNode4,
                ),
                RoundedInputField(
                  hintText: "Link do Google Maps",
                  controller: linkController,
                  keyboardType: TextInputType.text,
                  onChanged: controller.setLinkMaps,
                  focusNode: focusNode4,
                  nextFocusNode: focusNode5,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 15, right: 10),
                  child: ListTile(
                    title: const InkWellSpeakText(
                      Text(
                        "Adicionar endereço?",
                        style: TextStyle(
                          fontSize: 20,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    trailing: Switch(
                      value: controller.adcEndereco,
                      onChanged: controller.setAdcEndereco,
                      inactiveThumbColor: Colors.red[700],
                      inactiveTrackColor: Colors.red[100],
                    ),
                  ),
                ),
                if (controller.adcEndereco)
                  Column(
                    children: [
                      RoundedInputField(
                        hintText: "Estado",
                        controller: estadoController,
                        keyboardType: TextInputType.text,
                        onChanged: controller.setEstado,
                        focusNode: focusNode5,
                        nextFocusNode: focusNode6,
                      ),
                      RoundedInputField(
                        hintText: "Cidade",
                        controller: cidadeController,
                        keyboardType: TextInputType.text,
                        onChanged: controller.setCidade,
                        focusNode: focusNode6,
                        nextFocusNode: focusNode7,
                      ),
                      RoundedInputField(
                        hintText: "Bairro",
                        controller: bairroController,
                        keyboardType: TextInputType.text,
                        onChanged: controller.setBairro,
                        focusNode: focusNode7,
                        nextFocusNode: focusNode8,
                      ),
                      RoundedInputField(
                        hintText: "Rua",
                        controller: ruaController,
                        keyboardType: TextInputType.text,
                        onChanged: controller.setRua,
                        focusNode: focusNode8,
                        nextFocusNode: focusNode9,
                      ),
                      RoundedInputField(
                        hintText: "Número",
                        controller: numeroController,
                        keyboardType: TextInputType.text,
                        onChanged: controller.setNumero,
                        focusNode: focusNode9,
                      ),
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
                        widget.onSuccess("Solicitação enviada!");
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
}
