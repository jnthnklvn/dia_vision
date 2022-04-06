import 'package:dia_vision/app/modules/medications/controllers/medication_register_controller.dart';
import 'package:dia_vision/app/shared/components/container_field_horarios.dart';
import 'package:dia_vision/app/shared/components/text_field_container.dart';
import 'package:dia_vision/app/shared/components/ink_well_speak_text.dart';
import 'package:dia_vision/app/shared/components/rounded_input_field.dart';
import 'package:dia_vision/app/shared/components/semantic_icon_play.dart';
import 'package:dia_vision/app/shared/utils/horario_input_formatter.dart';
import 'package:dia_vision/app/shared/components/back_arrow_button.dart';
import 'package:dia_vision/app/shared/components/rounded_button.dart';
import 'package:dia_vision/app/shared/utils/scaffold_utils.dart';
import 'package:dia_vision/app/model/medicacao_prescrita.dart';
import 'package:dia_vision/app/shared/utils/date_utils.dart' as dt;
import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';
import 'package:dia_vision/app/model/medicamento.dart';

import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';

class MedicationRegisterPage extends StatefulWidget with ScaffoldUtils {
  final MedicacaoPrescrita? medicacaoPrescrita;

  MedicationRegisterPage(this.medicacaoPrescrita, {Key? key}) : super(key: key);

  @override
  _MedicationRegisterPageState createState() => _MedicationRegisterPageState();
}

class _MedicationRegisterPageState
    extends ModularState<MedicationRegisterPage, MedicationRegisterController>
    with dt.DateUtil {
  final _focusNodes = List<FocusNode>.generate(6, (index) => FocusNode());

  _MedicationRegisterPageState() {
    nomeController = TextEditingController();
  }

  TextEditingController? nomeController;
  TextEditingController? horarioInicialController;
  TextEditingController? dataFinalController;
  TextEditingController? dataInicialController;
  TextEditingController? posologiaController;
  TextEditingController? dosagemController;
  TextEditingController? medicoPrescritorController;
  TextEditingController? efeitosColateraisController;

  @override
  void initState() {
    initControllers();
    super.initState();
  }

  void initControllers() {
    controller.init(widget.medicacaoPrescrita);

    nomeController = TextEditingController(text: controller.nome);
    posologiaController =
        TextEditingController(text: controller.posologia?.value1);
    dosagemController = TextEditingController(text: controller.dosagem);
    horarioInicialController =
        TextEditingController(text: controller.horarioInicial);
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
      key: widget.scaffoldKey,
      appBar: AppBar(
        leading: const BackArrowButton(iconPadding: 5),
        title: const InkWellSpeakText(
          Text(
            medicationRegister,
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
                buildTextFieldWithSuggestions(context),
                RoundedInputField(
                  hintText: "Dosagem (${controller.medidaDosagem ?? ""})",
                  controller: dosagemController,
                  keyboardType: TextInputType.number,
                  onChanged: controller.setDosagem,
                  focusNode: _focusNodes[1],
                  nextFocusNode: _focusNodes[2],
                  suffixIcon: DropdownButton<String>(
                    value: controller.medidaDosagem,
                    icon: const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: kPrimaryColor,
                      size: 32,
                    ),
                    hint: Text(
                      "medida",
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
                    onChanged: controller.setMedidaDosagem,
                    items: controller.medidas
                        .map<DropdownMenuItem<String>>((String medida) {
                      return DropdownMenuItem<String>(
                        value: medida,
                        child: Text(medida),
                      );
                    }).toList(),
                  ),
                ),
                buildDropdownButton(size),
                controller.posologia?.value1 == "Personalizado"
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
                controller.posologia?.value1 == "Personalizado"
                    ? Container()
                    : RoundedInputField(
                        hintText: "Horário inicial",
                        controller: horarioInicialController,
                        keyboardType: TextInputType.number,
                        onChanged: controller.setHorarioInicial,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          HorarioInputFormatter(),
                        ],
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
                  focusNode: _focusNodes[2],
                  nextFocusNode: _focusNodes[3],
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
                  focusNode: _focusNodes[3],
                  nextFocusNode: _focusNodes[4],
                ),
                RoundedInputField(
                  hintText: "Médico prescritor",
                  controller: medicoPrescritorController,
                  keyboardType: TextInputType.text,
                  onChanged: controller.setMedicoPrescritor,
                  focusNode: _focusNodes[4],
                  nextFocusNode: _focusNodes[5],
                ),
                RoundedInputField(
                  hintText: "Efeitos colaterais",
                  controller: efeitosColateraisController,
                  keyboardType: TextInputType.text,
                  onChanged: controller.setEfeitosColaterais,
                  focusNode: _focusNodes[5],
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

  TextFieldContainer buildTextFieldWithSuggestions(BuildContext context) {
    return TextFieldContainer(
      child: TypeAheadField(
        textFieldConfiguration: TextFieldConfiguration(
          focusNode: _focusNodes[0],
          onChanged: controller.setNome,
          controller: nomeController,
          onSubmitted: (_) {
            _focusNodes[0].unfocus();
            FocusScope.of(context).requestFocus(_focusNodes[1]);
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            labelText: "Nome",
            suffixIcon: Observer(builder: (_) {
              if (controller.isSearching) {
                return Transform.scale(
                  scale: 0.6,
                  child: const CircularProgressIndicator(strokeWidth: 5),
                );
              }
              return const SizedBox();
            }),
            icon: Semantics(
              excludeSemantics: true,
              child: SemanticIconPlay(
                text: "Nome: ${controller.nome ?? ""}",
              ),
            ),
            labelStyle: TextStyle(
              color: Theme.of(context).textTheme.bodyText1?.color,
              fontSize: 18,
            ),
            hintText: "Nome",
            border: InputBorder.none,
          ),
        ),
        suggestionsCallback: (pattern) =>
            controller.getSuggestions(widget.onError),
        itemBuilder: (_, Medicamento suggestion) {
          return ListTile(
            trailing: SemanticIconPlay(
              text: suggestion.nomeComercial ?? suggestion.nomeSubstancia ?? '',
            ),
            title: Text(suggestion.nomeComercial ?? ''),
            subtitle: Text(suggestion.nomeSubstancia ?? ''),
          );
        },
        hideOnEmpty: true,
        onSuggestionSelected: (Medicamento suggestion) {
          nomeController!.text = suggestion.nomeComercial ?? '';
          controller.setNome(suggestion.nomeComercial);
          controller.medicamentoSelecionado = suggestion;
        },
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
        leading: SemanticIconPlay(
          text: controller.posologia?.value1 ??
              "Selecione a posologia (intervalo em horas)",
        ),
        title: DropdownButton<String>(
          value: controller.posologia?.value1,
          icon: const Icon(
            Icons.keyboard_arrow_down_sharp,
            color: kPrimaryColor,
            size: 32,
          ),
          isExpanded: true,
          hint: Text(
            "Posologia (intervalo em horas)",
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
          onChanged: controller.setPosologia,
          items: controller.horariosList
              .map<DropdownMenuItem<String>>((Tuple2<String, int> tuple) {
            return DropdownMenuItem<String>(
              value: tuple.value1,
              child: Text(tuple.value1),
            );
          }).toList(),
        ),
      ),
    );
  }
}
