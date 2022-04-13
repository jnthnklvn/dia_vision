import 'package:dia_vision/app/modules/autocuidado/controllers/autocuidado_controller.dart';
import 'package:dia_vision/app/modules/autocuidado/widgets/autocuidado_widget.dart';
import 'package:dia_vision/app/shared/components/floating_options_button.dart';
import 'package:dia_vision/app/shared/components/ink_well_speak_text.dart';
import 'package:dia_vision/app/shared/components/back_arrow_button.dart';
import 'package:dia_vision/app/shared/components/local_flutter_tts.dart';
import 'package:dia_vision/app/shared/utils/scaffold_utils.dart';
import 'package:dia_vision/app/shared/utils/color_utils.dart';
import 'package:dia_vision/app/shared/utils/date_utils.dart';
import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/material.dart';

class AutocuidadosPage extends StatefulWidget with ScaffoldUtils {
  AutocuidadosPage({Key? key}) : super(key: key);

  @override
  _AutocuidadosPageState createState() => _AutocuidadosPageState();
}

class _AutocuidadosPageState
    extends ModularState<AutocuidadosPage, AutocuidadoController>
    with DateUtil {
  @override
  void didChangeDependencies() {
    controller.getData(widget.onError);
    super.didChangeDependencies();
  }

  Future _speak(String txt) => Modular.get<LocalFlutterTts>().speak(txt);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const FloatingOptionsButton(),
      key: widget.scaffoldKey,
      appBar: AppBar(
        leading: const BackArrowButton(iconPadding: 5),
        title: const InkWellSpeakText(
          Text(
            selfCareTitle,
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
        alignment: Alignment.center,
        child: Observer(
          builder: (_) {
            if (controller.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (controller.autocuidados.isEmpty) {
              return InkWellSpeakText(
                Text(
                  withoutSelfCareRegistered,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.apply(color: kPrimaryColor),
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
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
            (controller.categoria ?? allCategories) +
            " selecionada, toque para $changeStr",
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
            controller.categoria ?? allCategories,
            style: const TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.filter_alt_outlined,
              size: 32,
              semanticLabel: "$buttonStr $changeStr $categoryStr",
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Color getColorToCategoria(String? str) {
    if (str?.isNotEmpty != true) return ColorUtils.colors[0];
    final idx = controller.categorias.toList().indexOf(str);
    return ColorUtils.colors[idx % ColorUtils.colors.length];
  }

  Widget buildDropdownButton() {
    return Observer(builder: (_) {
      return SingleChildScrollView(
          child: Column(
        children: [
          buildDropdownMenuItem(
              allCategories, getColorToCategoria(allCategories)),
          ...controller.categorias.map<DropdownMenuItem<String>>((String? str) {
            return buildDropdownMenuItem(
              str ?? '',
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
          margin: const EdgeInsets.symmetric(vertical: 3),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              stops: const [0.02, 0.02],
              colors: [color, color.withOpacity(0.1)],
            ),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            title: Text(
              str,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
