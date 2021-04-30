import 'package:dia_vision/app/modules/alimentacao/controllers/alimento_controller.dart';
import 'package:dia_vision/app/modules/alimentacao/components/data_search.dart';
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
  AlimentoRegisterPage();

  @override
  _AlimentoRegisterPageState createState() =>
      _AlimentoRegisterPageState(scaffoldKey);
}

class _AlimentoRegisterPageState extends State<AlimentoRegisterPage> {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final alimentoController = Modular.get<AlimentoController>();

  _AlimentoRegisterPageState(this.scaffoldKey);

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
      key: scaffoldKey,
      appBar: AppBar(
        leading: BackArrowButton(iconPadding: 5),
        title: InkWell(
          onTap: () async {
            await showSearch(
              context: context,
              delegate: DataSearch(alimentoController, widget.onError),
            );
          },
          onLongPress: () => _speak(CLICK_SEARCH_FOOD),
          child: ListTile(
            contentPadding: EdgeInsets.all(0),
            trailing: Icon(
              Icons.search,
              size: 32,
              color: kPrimaryColor,
            ),
            title: Text(
              "$SEARCH_FOOD...",
              style: TextStyle(
                fontSize: kAppBarTitleSize,
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
        color: Colors.white,
        padding: const EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
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
                  hintText: "Medida (ex. 100 g)",
                  controller: alimentoController.medidaController,
                  keyboardType: TextInputType.text,
                  onChanged: alimentoController.setMedida,
                  focusNode: focusNode2,
                  nextFocusNode: focusNode3,
                ),
                RoundedInputField(
                  hintText: "Calorias (porção)",
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
                  hintText: "Calorias consumidas",
                  controller: alimentoController.caloriasConsumidasController,
                  keyboardType: TextInputType.number,
                  onChanged: alimentoController.setCaloriasConsumidas,
                  focusNode: focusNode4,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                RoundedButton(
                  text: ADD.toUpperCase(),
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
}
