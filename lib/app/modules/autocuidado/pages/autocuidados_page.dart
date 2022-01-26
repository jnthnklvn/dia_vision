import 'package:dia_vision/app/modules/autocuidado/controllers/autocuidado_controller.dart';
import 'package:dia_vision/app/modules/autocuidado/widgets/autocuidado_widget.dart';
import 'package:dia_vision/app/shared/components/ink_well_speak_text.dart';
import 'package:dia_vision/app/shared/components/back_arrow_button.dart';
import 'package:dia_vision/app/shared/utils/scaffold_utils.dart';
import 'package:dia_vision/app/shared/utils/color_utils.dart';
import 'package:dia_vision/app/shared/utils/date_utils.dart';
import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class AutocuidadosPage extends StatefulWidget with ScaffoldUtils {
  @override
  _AutocuidadosPageState createState() => _AutocuidadosPageState(scaffoldKey);
}

class _AutocuidadosPageState
    extends ModularState<AutocuidadosPage, AutocuidadoController>
    with DateUtils {
  final GlobalKey<ScaffoldState> scaffoldKey;

  _AutocuidadosPageState(this.scaffoldKey);

  @override
  void didChangeDependencies() {
    controller.getData(widget.onError);
    super.didChangeDependencies();
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
            SELF_CARE_TITLE,
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
        alignment: Alignment.center,
        child: Observer(
          builder: (_) {
            if (controller.isLoading)
              return Center(child: CircularProgressIndicator());
            if (controller.autocuidados.isEmpty)
              return InkWellSpeakText(
                Text(
                  WITHOUT_SELF_CARE_REGISTERED,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, color: kPrimaryColor),
                ),
              );
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 10),
              itemCount: controller.autocuidados.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return buildListTitle(context);
                }
                final autocuidado = controller.autocuidados[index - 1];
                return AutocuidadoWidget(
                  autocuidado,
                  getColorToCategoria(autocuidado.categoria),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget buildListTitle(BuildContext context) {
    return InkWell(
      onLongPress: () => _speak(
        "Opção " +
            (controller.categoria ?? ALL_CATEGORIES) +
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
            controller.categoria ?? ALL_CATEGORIES,
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
              semanticLabel: "$BUTTON $CHANGE $CATEGORY",
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Color getColorToCategoria(String str) {
    final idx = controller.categorias.toList().indexOf(str);
    return ColorUtils.colors[idx % ColorUtils.colors.length];
  }

  Widget buildDropdownButton() {
    return Observer(builder: (_) {
      return SingleChildScrollView(
          child: Column(
        children: [
          buildDropdownMenuItem(
              ALL_CATEGORIES, getColorToCategoria(ALL_CATEGORIES)),
          ...controller.categorias.map<DropdownMenuItem<String>>((String str) {
            return buildDropdownMenuItem(
              str,
              getColorToCategoria(str),
            );
          }).toList()
        ],
      ));
    });
  }

  DropdownMenuItem<String> buildDropdownMenuItem(String str, Color color) {
    return DropdownMenuItem<String>(
      value: str,
      child: InkWell(
        onTap: () {
          controller.filterData(str);
          Modular.to.pop();
        },
        onLongPress: () => _speak(str),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 3),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              stops: const [0.02, 0.02],
              colors: [color, color.withOpacity(0.1)],
            ),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            title: Text(
              str,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
