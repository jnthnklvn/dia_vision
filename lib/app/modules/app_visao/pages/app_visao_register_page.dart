import 'package:dia_vision/app/modules/app_visao/controllers/app_visao_register_controller.dart';
import 'package:dia_vision/app/shared/components/ink_well_speak_text.dart';
import 'package:dia_vision/app/shared/components/rounded_input_field.dart';
import 'package:dia_vision/app/shared/components/back_arrow_button.dart';
import 'package:dia_vision/app/shared/components/rounded_button.dart';
import 'package:dia_vision/app/shared/utils/scaffold_utils.dart';
import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';
import 'package:dia_vision/app/model/app_visao.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class AppVisaoRegisterPage extends StatefulWidget with ScaffoldUtils {
  final AppVisao appVisao;

  AppVisaoRegisterPage(this.appVisao);

  @override
  _AppVisaoRegisterPageState createState() =>
      _AppVisaoRegisterPageState(scaffoldKey);
}

class _AppVisaoRegisterPageState
    extends ModularState<AppVisaoRegisterPage, AppVisaoRegisterController> {
  final GlobalKey<ScaffoldState> scaffoldKey;

  _AppVisaoRegisterPageState(this.scaffoldKey);

  final focusNode = FocusNode();
  final focusNode1 = FocusNode();
  final focusNode2 = FocusNode();
  final focusNode3 = FocusNode();

  final tituloController = TextEditingController();
  final descricaoController = TextEditingController();
  final linkAppleStoreController = TextEditingController();
  final linkAppGooglePlayController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: BackArrowButton(iconPadding: 5),
        title: InkWellSpeakText(
          Text(
            SUGGEST_VISION_APP_REGISTER,
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
              RoundedInputField(
                hintText: "Titulo",
                controller: tituloController,
                keyboardType: TextInputType.text,
                onChanged: controller.setTitulo,
                focusNode: focusNode,
                nextFocusNode: focusNode1,
              ),
              RoundedInputField(
                hintText: "Descrição",
                controller: descricaoController,
                keyboardType: TextInputType.text,
                onChanged: controller.setDescricao,
                focusNode: focusNode1,
                nextFocusNode: focusNode2,
              ),
              RoundedInputField(
                hintText: "Link do app na GooglePlay",
                controller: linkAppGooglePlayController,
                keyboardType: TextInputType.text,
                onChanged: controller.setLinkGooglePlay,
                focusNode: focusNode2,
                nextFocusNode: focusNode3,
              ),
              RoundedInputField(
                hintText: "Link do app na AppleStore",
                controller: linkAppleStoreController,
                keyboardType: TextInputType.text,
                onChanged: controller.setLinkAppleStore,
                focusNode: focusNode3,
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
                      widget.onSuccess("Solicitação enviada!");
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
}
