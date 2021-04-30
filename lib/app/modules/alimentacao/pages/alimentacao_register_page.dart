import 'package:dia_vision/app/modules/alimentacao/controllers/alimentacao_register_controller.dart';
import 'package:dia_vision/app/modules/alimentacao/controllers/alimento_controller.dart';
import 'package:dia_vision/app/shared/components/text_field_container.dart';
import 'package:dia_vision/app/shared/components/ink_well_speak_text.dart';
import 'package:dia_vision/app/shared/components/rounded_input_field.dart';
import 'package:dia_vision/app/shared/components/back_arrow_button.dart';
import 'package:dia_vision/app/modules/home/domain/entities/module.dart';
import 'package:dia_vision/app/shared/components/rounded_button.dart';
import 'package:dia_vision/app/shared/components/confirm_dialog.dart';
import 'package:dia_vision/app/shared/utils/scaffold_utils.dart';
import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';
import 'package:dia_vision/app/model/alimentacao.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class AlimentacaoRegisterPage extends StatefulWidget with ScaffoldUtils {
  final Alimentacao alimentacao;

  AlimentacaoRegisterPage(this.alimentacao);

  @override
  _AlimentacaoRegisterPageState createState() =>
      _AlimentacaoRegisterPageState(scaffoldKey);
}

class _AlimentacaoRegisterPageState extends ModularState<
    AlimentacaoRegisterPage, AlimentacaoRegisterController> {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final alimentoController = Modular.get<AlimentoController>();

  _AlimentacaoRegisterPageState(this.scaffoldKey);

  final focusNode = FocusNode();

  TextEditingController tipoController;
  TextEditingController caloriasController;

  @override
  void initState() {
    initControllers();
    super.initState();
  }

  void initControllers() {
    controller.init(widget.alimentacao, widget.onError);
    tipoController = TextEditingController(text: controller.tipo);
    caloriasController = TextEditingController(text: controller.calorias);
  }

  Future _speak(String txt) => Modular.get<FlutterTts>().speak(txt);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: BackArrowButton(iconPadding: 5),
        title: InkWellSpeakText(
          Text(
            ALIMENTATION_REGISTER,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Observer(builder: (_) {
                return buildDropdownButton(size);
              }),
              InkWell(
                onTap: () => Modular.to
                    .pushNamed("${alimentation.routeName}/alimento/$REGISTER"),
                onLongPress: () => _speak("Toque para adicionar alimento"),
                child: TextFieldContainer(
                  height: 68,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(0),
                    leading: Icon(
                      Icons.add,
                      color: kPrimaryColor,
                      size: 42,
                    ),
                    title: Text(
                      ADD_FOOD,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
              ),
              Observer(builder: (_) {
                if (!alimentoController.isDataReady)
                  return Center(
                      child: Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: CircularProgressIndicator(),
                  ));
                if (alimentoController.alimentos.length > 0) {
                  final calorias = alimentoController.alimentos
                      .fold<num>(
                          0, (prev, element) => prev + (element.calorias ?? 0))
                      .toString();
                  controller.setCalorias(calorias);
                  caloriasController.text = calorias;
                } else {
                  return Container();
                }
                return Column(
                  children: alimentoController.alimentos
                      .map((a) => buildAlimentoWidget(
                          a.nome, a.marca, a.calorias?.toString() ?? ""))
                      .toList(),
                );
              }),
              RoundedInputField(
                hintText: "Calorias",
                controller: caloriasController,
                keyboardType: TextInputType.number,
                onChanged: controller.setCalorias,
                focusNode: focusNode,
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
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog(String nome, String marca) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ConfirmDialog(
          () {
            alimentoController.removerAlimento(nome, marca);
          },
          DEL_FOOD,
          WISH_REMOVE_FOOD,
        );
      },
    );
  }

  String getTextAndField(String field, String text) {
    return field != null ? "$field: $text." : "";
  }

  InkWell buildAlimentoWidget(String nome, String marca, String calorias) {
    return InkWell(
      onTap: () => _showMyDialog(nome, marca),
      onLongPress: () => _speak(
          "${getTextAndField('Nome', nome)} ${getTextAndField('Marca', marca)} ${getTextAndField('Calorias', calorias)}"),
      child: TextFieldContainer(
        child: ListTile(
          title: Text(nome ?? ""),
          trailing: Text("$calorias cal"),
          subtitle: Text(marca ?? ""),
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
          onTap: () =>
              Modular.get<FlutterTts>().speak(controller.tipo ?? SELECT_TYPE),
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
            SELECT_TYPE,
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
          items:
              MealType.values.map<DropdownMenuItem<String>>((MealType value) {
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
