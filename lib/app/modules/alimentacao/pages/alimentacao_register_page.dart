import 'package:dia_vision/app/modules/alimentacao/controllers/alimentacao_register_controller.dart';
import 'package:dia_vision/app/modules/alimentacao/controllers/alimento_controller.dart';
import 'package:dia_vision/app/shared/components/floating_options_button.dart';
import 'package:dia_vision/app/shared/components/text_field_container.dart';
import 'package:dia_vision/app/shared/components/ink_well_speak_text.dart';
import 'package:dia_vision/app/shared/components/rounded_input_field.dart';
import 'package:dia_vision/app/shared/components/back_arrow_button.dart';
import 'package:dia_vision/app/modules/home/domain/entities/module.dart';
import 'package:dia_vision/app/shared/components/local_flutter_tts.dart';
import 'package:dia_vision/app/shared/components/rounded_button.dart';
import 'package:dia_vision/app/shared/components/confirm_dialog.dart';
import 'package:dia_vision/app/shared/utils/scaffold_utils.dart';
import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';
import 'package:dia_vision/app/model/alimentacao.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class AlimentacaoRegisterPage extends StatefulWidget with ScaffoldUtils {
  final Alimentacao? alimentacao;

  AlimentacaoRegisterPage(this.alimentacao, {Key? key}) : super(key: key);

  @override
  _AlimentacaoRegisterPageState createState() =>
      _AlimentacaoRegisterPageState();
}

class _AlimentacaoRegisterPageState extends ModularState<
    AlimentacaoRegisterPage, AlimentacaoRegisterController> {
  final alimentoController = Modular.get<AlimentoController>();

  final focusNode = FocusNode();

  TextEditingController? tipoController;
  TextEditingController? caloriasController;

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
            alimentationRegister,
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
        padding: const EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Observer(builder: (_) {
                return buildDropdownButton(size);
              }),
              InkWell(
                onTap: () => Modular.to.pushNamed(
                    "${alimentation.routeName}/alimento/$registerStr/"),
                onLongPress: () =>
                    widget.speak("Toque para adicionar alimento"),
                child: TextFieldContainer(
                  height: 68,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    leading: const Icon(
                      Icons.add,
                      color: kPrimaryColor,
                      size: 42,
                    ),
                    title: Text(
                      addFood,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).textTheme.bodyText1?.color,
                      ),
                    ),
                  ),
                ),
              ),
              Observer(builder: (_) {
                if (!alimentoController.isDataReady) {
                  return Center(
                      child: Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    child: const CircularProgressIndicator(),
                  ));
                }
                if (alimentoController.alimentos.isNotEmpty) {
                  final calorias = alimentoController.alimentos
                      .fold<num>(
                          0,
                          (prev, element) =>
                              prev + (element.caloriasConsumidas ?? 0))
                      .toString();
                  controller.setCalorias(calorias);
                  caloriasController?.text = calorias;
                } else {
                  return Container();
                }
                return Column(
                  children: alimentoController.alimentos
                      .map((a) => buildAlimentoWidget(
                          a.nome ?? '',
                          a.marca ?? '',
                          a.caloriasConsumidas?.toString() ?? ""))
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
                      await Future.delayed(const Duration(milliseconds: 1500));
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
          () => alimentoController.removerAlimento(nome, marca),
          delFood,
          wishToRemoveFood,
        );
      },
    );
  }

  String getTextAndField(String? field, String text) {
    return field != null ? "$field: $text." : "";
  }

  InkWell buildAlimentoWidget(String nome, String marca, String calorias) {
    return InkWell(
      onTap: () => _showMyDialog(nome, marca),
      onLongPress: () => widget.speak(
          "${getTextAndField('Nome', nome)} ${getTextAndField('Marca', marca)} ${getTextAndField('Calorias consumidas', calorias)}"),
      child: TextFieldContainer(
        child: ListTile(
          title: Text(nome),
          trailing: Text("$calorias cal"),
          subtitle: Text(marca),
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
            onTap: () => Modular.get<LocalFlutterTts>()
                .speak(controller.tipo ?? selectType),
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
            selectType,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          elevation: 16,
          style: Theme.of(context).textTheme.bodyText1,
          underline: Container(),
          onChanged: controller.setTipo,
          items:
              MealType.values.map<DropdownMenuItem<String>>((MealType value) {
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
