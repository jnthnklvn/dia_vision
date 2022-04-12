import 'package:dia_vision/app/modules/alimentacao/controllers/alimento_controller.dart';
import 'package:dia_vision/app/modules/alimentacao/components/data_search.dart';
import 'package:dia_vision/app/shared/components/floating_options_button.dart';
import 'package:dia_vision/app/shared/components/ink_well_speak_text.dart';
import 'package:dia_vision/app/shared/components/rounded_input_field.dart';
import 'package:dia_vision/app/shared/components/back_arrow_button.dart';
import 'package:dia_vision/app/shared/components/rounded_button.dart';
import 'package:dia_vision/app/shared/utils/scaffold_utils.dart';
import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';
import 'package:dia_vision/app/model/alimento.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class AlimentoRegisterPage extends StatefulWidget with ScaffoldUtils {
  AlimentoRegisterPage({Key? key}) : super(key: key);

  @override
  _AlimentoRegisterPageState createState() => _AlimentoRegisterPageState();
}

class _AlimentoRegisterPageState extends State<AlimentoRegisterPage> {
  final alimentoController = Modular.get<AlimentoController>();

  final focusNode = FocusNode();
  final focusNode1 = FocusNode();
  final focusNode2 = FocusNode();
  final focusNode3 = FocusNode();
  final focusNode4 = FocusNode();

  @override
  void initState() {
    alimentoController.init(Alimento());
    super.initState();
  }

  Future _speak(String txt) => Modular.get<FlutterTts>().speak(txt);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: widget.scaffoldKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const FloatingOptionsButton(),
      appBar: AppBar(
        leading: const BackArrowButton(iconPadding: 5),
        title: InkWell(
          onTap: () async {
            await showSearch(
              context: context,
              delegate: DataSearch(alimentoController, widget.onError),
            );
          },
          onLongPress: () => _speak(clickToSearchFood),
          child: const ListTile(
            contentPadding: EdgeInsets.all(0),
            trailing: Icon(
              Icons.search,
              size: 32,
              color: kPrimaryColor,
            ),
            title: Text(
              "$searchFood...",
              style: TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
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
                RoundedInputField(
                  hintText: "Nome",
                  controller: alimentoController.nomeController,
                  keyboardType: TextInputType.text,
                  onChanged: alimentoController.setNome,
                  focusNode: focusNode,
                  nextFocusNode: focusNode1,
                ),
                RoundedInputField(
                  hintText: "Marca",
                  controller: alimentoController.marcaController,
                  keyboardType: TextInputType.text,
                  onChanged: alimentoController.setMarca,
                  focusNode: focusNode1,
                  nextFocusNode: focusNode2,
                ),
                RoundedInputField(
                  hintText: "Porção (ex. 100g)",
                  controller: alimentoController.medidaController,
                  keyboardType: TextInputType.text,
                  onChanged: alimentoController.setMedida,
                  focusNode: focusNode2,
                  nextFocusNode: focusNode3,
                ),
                RoundedInputField(
                  hintText: "Calorias (por porção)",
                  controller: alimentoController.caloriasController,
                  keyboardType: TextInputType.number,
                  onChanged: alimentoController.setCalorias,
                  focusNode: focusNode3,
                  nextFocusNode: focusNode4,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                RoundedInputField(
                  suffixIcon: InkWellSpeakText(Text(
                    getLastString(alimentoController.medida ?? '') ?? "",
                    style: TextStyle(color: Colors.grey[700]),
                  )),
                  hintText: "Porção consumida",
                  controller: alimentoController.porcaoConsumidaController,
                  keyboardType: TextInputType.number,
                  onChanged: alimentoController.setPorcaoConsumida,
                  focusNode: focusNode4,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                RoundedButton(
                  text: addStr.toUpperCase(),
                  onPressed: () {
                    final value =
                        alimentoController.addAlimento(widget.onError);
                    if (value) Modular.to.pop();
                  },
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  String? getLastString(String str) {
    final list = str.split(' ');
    return list.isNotEmpty == true ? "(${list[list.length - 1]})" : null;
  }
}
