import 'package:dia_vision/app/shared/components/floating_options_button.dart';
import 'package:dia_vision/app/shared/components/ink_well_speak_text.dart';
import 'package:dia_vision/app/shared/components/rounded_input_field.dart';
import 'package:dia_vision/app/shared/components/back_arrow_button.dart';
import 'package:dia_vision/app/shared/components/rounded_button.dart';
import 'package:dia_vision/app/shared/utils/scaffold_utils.dart';
import 'package:dia_vision/app/shared/utils/constants.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'my_data_controller.dart';

class MyDataPage extends StatefulWidget with ScaffoldUtils {
  MyDataPage({Key? key}) : super(key: key);

  @override
  _MyDataPageState createState() => _MyDataPageState();
}

class _MyDataPageState extends ModularState<MyDataPage, MyDataController>
    with SingleTickerProviderStateMixin {
  final _focusNode1 = FocusNode();
  final _focusNode2 = FocusNode();
  final _focusNode3 = FocusNode();
  final _focusNode4 = FocusNode();
  final _focusNode5 = FocusNode();
  final _focusNode6 = FocusNode();

  TextEditingController? dataController;
  TextEditingController? emailController;
  TextEditingController? nomeController;
  TextEditingController? pesoController;
  TextEditingController? alturaController;
  TextEditingController? telefoneController;

  @override
  void initState() {
    controller.getData(widget.onError, initControllers);
    super.initState();
  }

  void initControllers() {
    dataController = TextEditingController(text: controller.dataNascimento);
    emailController = TextEditingController(text: controller.email);
    nomeController = TextEditingController(text: controller.nome);
    pesoController = TextEditingController(text: controller.peso);
    alturaController = TextEditingController(text: controller.altura);
    telefoneController = TextEditingController(text: controller.telefone);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingOptionsButton(),
      key: widget.scaffoldKey,
      appBar: AppBar(
        leading: const BackArrowButton(iconPadding: 5),
        title: const InkWellSpeakText(
          Text(
            "Edite seus dados",
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
        child: Observer(builder: (_) {
          if (!controller.isDataReady) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RoundedInputField(
                  focusNode: _focusNode1,
                  nextFocusNode: _focusNode2,
                  hintText: "Email",
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: controller.setEmail,
                  errorText: controller.emailError,
                ),
                RoundedInputField(
                  focusNode: _focusNode2,
                  onChanged: controller.setNome,
                  controller: nomeController,
                  keyboardType: TextInputType.text,
                  nextFocusNode: _focusNode3,
                  hintText: "Nome",
                ),
                RoundedInputField(
                  onChanged: controller.setTelefone,
                  focusNode: _focusNode3,
                  controller: telefoneController,
                  keyboardType: TextInputType.number,
                  nextFocusNode: _focusNode4,
                  hintText: "Telefone",
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    TelefoneInputFormatter(),
                  ],
                ),
                RoundedInputField(
                  focusNode: _focusNode4,
                  nextFocusNode: _focusNode5,
                  hintText: "Data de Nascimento",
                  keyboardType: TextInputType.number,
                  controller: dataController,
                  onChanged: controller.setDataNascimento,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    DataInputFormatter(),
                  ],
                ),
                RoundedInputField(
                  focusNode: _focusNode5,
                  nextFocusNode: _focusNode6,
                  hintText: "Peso",
                  controller: pesoController,
                  keyboardType: TextInputType.number,
                  onChanged: controller.setPeso,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    PesoInputFormatter(),
                  ],
                ),
                RoundedInputField(
                  focusNode: _focusNode6,
                  hintText: "Altura",
                  controller: alturaController,
                  keyboardType: TextInputType.number,
                  onChanged: controller.setAltura,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    AlturaInputFormatter(),
                  ],
                ),
                controller.isLoading
                    ? Center(
                        child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: const CircularProgressIndicator(),
                      ))
                    : RoundedButton(
                        text: "SALVAR",
                        onPressed: () => controller.save(
                          widget.onError,
                          () async {
                            widget.onSuccess("Atualizado com sucesso!");
                          },
                        ),
                      ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
