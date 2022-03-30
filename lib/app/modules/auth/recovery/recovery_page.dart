import 'package:dia_vision/app/shared/components/ink_well_speak_text.dart';
import 'package:dia_vision/app/shared/components/rounded_input_field.dart';
import 'package:dia_vision/app/shared/components/back_arrow_button.dart';
import 'package:dia_vision/app/shared/components/rounded_button.dart';
import 'package:dia_vision/app/shared/utils/scaffold_utils.dart';
import 'package:dia_vision/app/shared/utils/constants.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/material.dart';

import 'recovery_controller.dart';

class RecoveryPage extends StatefulWidget with ScaffoldUtils {
  RecoveryPage({Key? key}) : super(key: key);

  @override
  _RecoveryPageState createState() => _RecoveryPageState(scaffoldKey);
}

class _RecoveryPageState extends ModularState<RecoveryPage, RecoveryController>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey;

  _RecoveryPageState(this.scaffoldKey);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: size.height,
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
        child: SingleChildScrollView(
          child: Observer(builder: (_) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: const [
                    BackArrowButton(),
                  ],
                ),
                SizedBox(height: size.height * 0.02),
                Image.asset(
                  "assets/images/logo_name.png",
                  width: size.width * 0.8,
                  excludeFromSemantics: true,
                ),
                SizedBox(height: size.height * 0.1),
                RoundedInputField(
                  hintText: "Email",
                  keyboardType: TextInputType.emailAddress,
                  onChanged: controller.setEmail,
                  errorText: controller.emailError,
                ),
                SizedBox(height: size.height * 0.02),
                controller.isLoading
                    ? Center(
                        child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: const CircularProgressIndicator(),
                      ))
                    : RoundedButton(
                        text: "RECUPERAR",
                        onPressed: () => controller.recovery(
                          widget.onError,
                          () {
                            widget
                                .onSuccess("Solicitação efetuada com sucesso!");
                            controller.setEmail(null);
                          },
                        ),
                      ),
                SizedBox(height: size.height * 0.08),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: InkWellSpeakText(
                    Text(
                      "Informe o email cadastrado e confirme. Se for um email válido, um link para recuperação da senha será enviado para o endereço.",
                      style: TextStyle(fontSize: 20, color: kPrimaryColor),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
