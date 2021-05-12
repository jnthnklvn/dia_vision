import 'package:dia_vision/app/modules/medications/controllers/medication_register_controller.dart';
import 'package:dia_vision/app/shared/components/text_field_container.dart';
import 'package:dia_vision/app/shared/components/ink_well_speak_text.dart';
import 'package:dia_vision/app/shared/components/rounded_input_field.dart';
import 'package:dia_vision/app/shared/utils/horario_input_formatter.dart';
import 'package:dia_vision/app/shared/components/back_arrow_button.dart';
import 'package:dia_vision/app/shared/components/rounded_button.dart';
import 'package:dia_vision/app/shared/components/choose_dialog.dart';
import 'package:dia_vision/app/shared/utils/scaffold_utils.dart';
import 'package:dia_vision/app/model/medicacao_prescrita.dart';
import 'package:dia_vision/app/shared/utils/date_utils.dart';
import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';
import 'package:dia_vision/app/model/medicamento.dart';

import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';

class MedicationRegisterPage extends StatefulWidget with ScaffoldUtils {
  final MedicacaoPrescrita medicacaoPrescrita;

  MedicationRegisterPage(this.medicacaoPrescrita);

  @override
  _MedicationRegisterPageState createState() =>
      _MedicationRegisterPageState(scaffoldKey);
}

class _MedicationRegisterPageState
    extends ModularState<MedicationRegisterPage, MedicationRegisterController>
    with DateUtils {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final _focusNodes = List<FocusNode>.generate(6, (index) => FocusNode());

  _MedicationRegisterPageState(this.scaffoldKey) {
    nomeController = TextEditingController();
  }

  TextEditingController nomeController;
  TextEditingController horarioInicialController;
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

  Future<dynamic> _speak(String txt) => Modular.get<FlutterTts>().speak(txt);

  Widget timePickerSpinner() {
    return AlertDialog(
      title: Container(
        color: Colors.white,
        child: InkWellSpeakText(
          Text(
            "Adicionar horário",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: kPrimaryColor,
                fontSize: 24,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
      titlePadding: EdgeInsets.only(top: 10),
      contentPadding: EdgeInsets.only(top: 10),
      actions: [
        RaisedButton(
          child: Text(
            "Cancelar",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          onLongPress: () => _speak("$BUTTON cancelar"),
          onPressed: Navigator.of(context).pop,
          color: kPrimaryColor,
        ),
        RaisedButton(
          child: Text(
            "Adicionar",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          onLongPress: () => _speak("$BUTTON adicionar"),
          onPressed: () {
            controller.horarios.add(controller.horario);
            Navigator.of(context).pop();
          },
          color: kPrimaryColor,
        ),
      ],
      content: Container(
        color: Colors.white,
        child: TimePickerSpinner(
          normalTextStyle: TextStyle(fontSize: 24, color: kPrimaryColor),
          highlightedTextStyle: TextStyle(fontSize: 24, color: kSecondaryColor),
          itemWidth: 100,
          alignment: Alignment.center,
          time: DateTime(2021, 1, 1, 12, 00),
          isForce2Digits: true,
          onTimeChange: (time) {
            controller.horario = getHorarioFromDate(time);
          },
        ),
      ),
    );
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
                buildTextFieldWithSuggestions(context),
                RoundedInputField(
                  hintText: "Dosagem",
                  controller: dosagemController,
                  keyboardType: TextInputType.number,
                  onChanged: controller.setDosagem,
                  focusNode: _focusNodes[1],
                  nextFocusNode: _focusNodes[2],
                ),
                buildDropdownButton(size),
                controller.posologia?.value1 == "Personalizado"
                    ? buildContainerHorarios(context)
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

  TextFieldContainer buildContainerHorarios(BuildContext context) {
    return TextFieldContainer(
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 3),
        trailing: InkWell(
          child: const Icon(
            Icons.add,
            color: kPrimaryColor,
            size: 32,
          ),
          onLongPress: () => _speak("Adicione um horário"),
          onTap: () => showDialog(
            context: context,
            builder: (context) {
              return timePickerSpinner();
            },
          ),
        ),
        leading: Semantics(
          excludeSemantics: true,
          child: InkWell(
            onTap: () => _speak(controller.horarios.length == 0
                ? "Adicione um horário"
                : controller.horarios.toString()),
            child: Icon(
              Icons.play_circle_fill,
              color: kPrimaryColor,
              size: 42,
            ),
          ),
        ),
        title: controller.horarios.length == 0
            ? Text(
                "Adicione um horário",
                style: TextStyle(color: Colors.grey[700]),
              )
            : NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overscroll) {
                  overscroll.disallowGlow();
                  return;
                },
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: controller.horarios
                        .map((e) => buildContainerHorario(e))
                        .toList(),
                  ),
                ),
              ),
      ),
    );
  }

  Widget buildContainerHorario(String e) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: RaisedButton(
        onLongPress: () => _speak("$e. Toque para editar/remover."),
        onPressed: () => _showMyDialog(e),
        child: Text(e, style: TextStyle(fontWeight: FontWeight.w600)),
      ),
    );
  }

  Future<void> _showMyDialog(String e) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ChooseDialog(
          () {
            controller.horarios.remove(e);
            showDialog(
              context: context,
              builder: (context) {
                return timePickerSpinner();
              },
            );
          },
          () {
            controller.horarios.remove(e);
          },
        );
      },
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
                  child: CircularProgressIndicator(strokeWidth: 5),
                );
              }
              return SizedBox();
            }),
            icon: Semantics(
              excludeSemantics: true,
              child: InkWell(
                onTap: () => _speak("Nome"),
                child: Icon(
                  Icons.play_circle_fill,
                  color: kPrimaryColor,
                  size: 42,
                ),
              ),
            ),
            hintText: "Nome",
            border: InputBorder.none,
          ),
        ),
        suggestionsCallback: (pattern) =>
            controller.getSuggestions(widget.onError),
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
        leading: Semantics(
          excludeSemantics: true,
          child: InkWell(
            onTap: () => _speak(controller.posologia?.value1 ??
                "Selecione a posologia (intervalo em horas)"),
            child: Icon(
              Icons.play_circle_fill,
              color: kPrimaryColor,
              size: 42,
            ),
          ),
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
