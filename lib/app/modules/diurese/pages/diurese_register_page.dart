import 'package:dia_vision/app/modules/diurese/controllers/diurese_register_controller.dart';
import 'package:dia_vision/app/shared/components/ink_well_speak_text.dart';
import 'package:dia_vision/app/shared/components/rounded_input_field.dart';
import 'package:dia_vision/app/shared/components/back_arrow_button.dart';
import 'package:dia_vision/app/shared/components/rounded_button.dart';
import 'package:dia_vision/app/shared/utils/scaffold_utils.dart';
import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';
import 'package:dia_vision/app/model/diurese.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class DiureseRegisterPage extends StatefulWidget with ScaffoldUtils {
  final Diurese diurese;

  DiureseRegisterPage(this.diurese);

  @override
  _DiureseRegisterPageState createState() =>
      _DiureseRegisterPageState(scaffoldKey);
}

class _DiureseRegisterPageState
    extends ModularState<DiureseRegisterPage, DiureseRegisterController> {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final _focusNode1 = FocusNode();
  final _focusNode2 = FocusNode();

  _DiureseRegisterPageState(this.scaffoldKey);

  TextEditingController volumeController;
  TextEditingController coloracaoController;

  @override
  void initState() {
    initControllers();
    super.initState();
  }

  void initControllers() {
    controller.init(widget.diurese);

    coloracaoController = TextEditingController(text: controller.coloracao);
    volumeController = TextEditingController(text: controller.volume);
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
            DIURESIS_CHECK_REGISTER,
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
        padding: const EdgeInsets.only(top: 20),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Observer(builder: (_) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RoundedInputField(
                  hintText: "Coloração",
                  controller: coloracaoController,
                  keyboardType: TextInputType.text,
                  focusNode: _focusNode1,
                  nextFocusNode: _focusNode2,
                  onChanged: controller.setColoracao,
                ),
                RoundedInputField(
                  hintText: "Volume",
                  controller: volumeController,
                  keyboardType: TextInputType.number,
                  onChanged: controller.setVolume,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    PesoInputFormatter(),
                  ],
                  focusNode: _focusNode2,
                ),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 10),
                  child: ListTile(
                    title: InkWellSpeakText(
                      Text(
                        "Houve ardor?",
                        style: TextStyle(
                          fontSize: 20,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    trailing: Switch(
                      value: controller.ardor,
                      onChanged: controller.setArdor,
                      inactiveThumbColor: Colors.red[700],
                      inactiveTrackColor: Colors.red[100],
                    ),
                  ),
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
}
