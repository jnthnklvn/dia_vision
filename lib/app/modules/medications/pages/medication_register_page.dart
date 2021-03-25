import 'package:dia_vision/app/modules/medications/medication_register_controller.dart';
import 'package:dia_vision/app/shared/components/text_field_container.dart';
import 'package:dia_vision/app/shared/components/ink_well_speak_text.dart';
import 'package:dia_vision/app/shared/components/rounded_input_field.dart';
import 'package:dia_vision/app/shared/components/back_arrow_button.dart';
import 'package:dia_vision/app/shared/components/rounded_button.dart';
import 'package:dia_vision/app/shared/utils/scaffold_utils.dart';
import 'package:dia_vision/app/model/medicacao_prescrita.dart';
import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';
import 'package:dia_vision/app/model/medicamento.dart';

import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class MedicationRegisterPage extends StatefulWidget with ScaffoldUtils {
  final MedicacaoPrescrita medicacaoPrescrita;

  MedicationRegisterPage(this.medicacaoPrescrita);

  @override
  _MedicationRegisterPageState createState() =>
      _MedicationRegisterPageState(scaffoldKey);
}

class _MedicationRegisterPageState
    extends ModularState<MedicationRegisterPage, MedicationRegisterController> {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final _focusNode1 = FocusNode();
  final _focusNode2 = FocusNode();
  final _focusNode3 = FocusNode();
  final _focusNode4 = FocusNode();
  final _focusNode5 = FocusNode();
  final _focusNode6 = FocusNode();
  final _focusNode7 = FocusNode();

  _MedicationRegisterPageState(this.scaffoldKey) {
    nomeController = TextEditingController();
  }

  TextEditingController nomeController;
  TextEditingController dataFinalController;
  TextEditingController dataInicialController;
  TextEditingController posologiaController;
  TextEditingController dosagemController;
  TextEditingController medicoPrescritorController;
  TextEditingController efeitosColateraisController;

  @override
  void initState() {
    initControllers();
    super.initState();
  }

  void initControllers() {
    controller.init(widget.medicacaoPrescrita);

    nomeController = TextEditingController(text: controller.nome);
    posologiaController = TextEditingController(text: controller.posologia);
    dosagemController = TextEditingController(text: controller.dosagem);
    dataInicialController = TextEditingController(text: controller.dataInicial);
    dataFinalController = TextEditingController(text: controller.dataFinal);
    medicoPrescritorController =
        TextEditingController(text: controller.medicoPrescritor);
    efeitosColateraisController =
        TextEditingController(text: controller.efeitosColaterais);
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
        padding: const EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildTextFieldWithSuggestions(context),
              RoundedInputField(
                hintText: "Dosagem",
                controller: dosagemController,
                keyboardType: TextInputType.number,
                onChanged: controller.setDosagem,
                focusNode: _focusNode2,
                nextFocusNode: _focusNode3,
              ),
              RoundedInputField(
                hintText: "Posologia",
                controller: posologiaController,
                keyboardType: TextInputType.number,
                onChanged: controller.setPosologia,
                focusNode: _focusNode3,
                nextFocusNode: _focusNode4,
              ),
              RoundedInputField(
                hintText: "Data inicial",
                controller: dataInicialController,
                keyboardType: TextInputType.number,
                onChanged: controller.setDataInicial,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  DataInputFormatter(),
                ],
                focusNode: _focusNode4,
                nextFocusNode: _focusNode5,
              ),
              RoundedInputField(
                hintText: "Data final",
                controller: dataFinalController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  DataInputFormatter(),
                ],
                onChanged: controller.setDataFinal,
                focusNode: _focusNode5,
                nextFocusNode: _focusNode6,
              ),
              RoundedInputField(
                hintText: "Médico prescritor",
                controller: medicoPrescritorController,
                keyboardType: TextInputType.text,
                onChanged: controller.setMedicoPrescritor,
                focusNode: _focusNode6,
                nextFocusNode: _focusNode7,
              ),
              RoundedInputField(
                hintText: "Efeitos colaterais",
                controller: efeitosColateraisController,
                keyboardType: TextInputType.text,
                onChanged: controller.setEfeitosColaterais,
                focusNode: _focusNode7,
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
          ),
        ),
      ),
    );
  }

  TextFieldContainer buildTextFieldWithSuggestions(BuildContext context) {
    return TextFieldContainer(
      child: TypeAheadField(
        textFieldConfiguration: TextFieldConfiguration(
          focusNode: _focusNode1,
          onChanged: controller.setNome,
          controller: nomeController,
          onSubmitted: (_) {
            _focusNode1.unfocus();
            FocusScope.of(context).requestFocus(_focusNode2);
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            labelText: "Nome",
            suffixIcon: Observer(builder: (_) {
              if (controller.isSearching) {
                return Transform.scale(
                  scale: 0.6,
                  child: CircularProgressIndicator(strokeWidth: 5),
                );
              }
              return SizedBox();
            }),
            icon: InkWell(
              onTap: () => Modular.get<FlutterTts>().speak("Nome"),
              child: Icon(
                Icons.play_circle_fill,
                color: kPrimaryColor,
                size: 42,
              ),
            ),
            hintText: "Nome",
            border: InputBorder.none,
          ),
        ),
        suggestionsCallback: (pattern) async {
          return controller.getSuggestions(widget.onError);
        },
        itemBuilder: (_, Medicamento suggestion) {
          return ListTile(
            title: Text(suggestion.nomeComercial),
            subtitle: Text(suggestion.nomeSubstancia),
          );
        },
        hideOnEmpty: true,
        onSuggestionSelected: (Medicamento suggestion) {
          nomeController.text = suggestion.nomeComercial;
          controller.setNome(suggestion.nomeComercial);
          controller.medicamentoSelecionado = suggestion;
        },
      ),
    );
  }
}
