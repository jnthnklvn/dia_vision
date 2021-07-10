import 'package:dia_vision/app/modules/centro_saude/controllers/centro_saude_controller.dart';
import 'package:dia_vision/app/modules/centro_saude/widgets/centro_saude_widget.dart';
import 'package:dia_vision/app/shared/components/floating_add_button.dart';
import 'package:dia_vision/app/shared/components/ink_well_speak_text.dart';
import 'package:dia_vision/app/modules/home/domain/entities/module.dart';
import 'package:dia_vision/app/shared/components/back_arrow_button.dart';
import 'package:dia_vision/app/shared/utils/scaffold_utils.dart';
import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/material.dart';

class CentrosSaudePage extends StatefulWidget with ScaffoldUtils {
  @override
  _CentrosSaudePageState createState() => _CentrosSaudePageState(scaffoldKey);
}

class _CentrosSaudePageState
    extends ModularState<CentrosSaudePage, CentroSaudeController> {
  final GlobalKey<ScaffoldState> scaffoldKey;

  _CentrosSaudePageState(this.scaffoldKey);

  @override
  void initState() {
    super.initState();
    controller.getData(widget.onError);
  }

  Future _speak(String txt) => Modular.get<FlutterTts>().speak(txt);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      floatingActionButton: FloatingAddButton(
        "$BUTTON $SUGGEST $MEDICAL_CENTER_TITLE",
        "${medicalCenters.routeName}/$REGISTER",
      ),
      appBar: AppBar(
        leading: BackArrowButton(iconPadding: 5),
        title: InkWellSpeakText(
          Text(
            MEDICAL_CENTERS,
            style: TextStyle(
              fontSize: kAppBarTitleSize,
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Semantics(
        sortKey: OrdinalSortKey(1),
        child: Container(
          width: double.infinity,
          height: size.height,
          color: Colors.white,
          alignment: Alignment.center,
          child: Observer(
            builder: (_) {
              if (controller.isLoading)
                return Center(child: CircularProgressIndicator());
              if (controller.centros.isEmpty)
                return InkWellSpeakText(
                  Text(
                    WITHOUT_MEDICAL_CENTER_REGISTERED,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, color: kPrimaryColor),
                  ),
                );
              return ListView.builder(
                itemCount: controller.centros.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return buildListTitle(context);
                  }
                  return CentroSaudeWidget(controller.centros[index - 1]);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildListTitle(BuildContext context) {
    return InkWell(
      onLongPress: () => _speak(
        "Opção " +
            (controller.tipo ?? "Todas os tipos") +
            " selecionada, toque para $CHANGE",
      ),
      onTap: () => showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            content: buildDropdownButton(),
          );
        },
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            controller.tipo ?? "Todas os tipos",
            style: TextStyle(
              fontSize: kAppBarTitleSize - 2,
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.filter_alt_outlined,
              size: 32,
              semanticLabel: "$BUTTON $CHANGE $TYPE",
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDropdownButton() {
    return Observer(builder: (_) {
      return SingleChildScrollView(
          child: Column(
        children: [
          buildDropdownMenuItem("Todas os tipos"),
          ...controller.tipos.map<DropdownMenuItem<String>>((String str) {
            return buildDropdownMenuItem(str);
          }).toList()
        ],
      ));
    });
  }

  DropdownMenuItem<String> buildDropdownMenuItem(String str) {
    return DropdownMenuItem<String>(
      value: str,
      child: InkWell(
        onTap: () {
          controller.filterData(str);
          Modular.to.pop();
        },
        onLongPress: () => _speak(str),
        child: ListTile(
          contentPadding: EdgeInsets.all(0),
          title: Text(
            str,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
