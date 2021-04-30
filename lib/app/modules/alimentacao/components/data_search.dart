import 'package:dia_vision/app/modules/alimentacao/controllers/alimento_controller.dart';
import 'package:dia_vision/app/shared/components/ink_well_speak_text.dart';
import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate<String> {
  final AlimentoController _alimentoController;
  final Function(String) onError;

  Future _speak(String txt) => Modular.get<FlutterTts>().speak(txt);

  DataSearch(this._alimentoController, this.onError)
      : super(
          searchFieldLabel: SEARCH,
          searchFieldStyle: TextStyle(
            fontSize: kAppBarTitleSize,
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        );

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
          size: 32,
          color: kPrimaryColor,
        ),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        color: kPrimaryColor,
        size: 32,
        progress: transitionAnimation,
      ),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              NOT_ENOUGH_LETTERS,
            ),
          )
        ],
      );
    }

    _alimentoController.searchAPI(onError, query);

    return Observer(builder: (_) {
      if (_alimentoController.isLoading) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(child: CircularProgressIndicator()),
          ],
        );
      } else if (_alimentoController.alimentosAPI.length == 0) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: InkWellSpeakText(
                Text(
                  NO_FOODS_FOUND,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, color: kPrimaryColor),
                ),
              ),
            ),
          ],
        );
      }
      return ListView.builder(
        itemCount: _alimentoController.alimentosAPI.length,
        itemBuilder: (context, index) {
          var result = _alimentoController.alimentosAPI[index];
          return InkWell(
            onTap: () {
              _alimentoController.calorias = result.calorias.toString();
              _alimentoController.marca = result.marca;
              _alimentoController.nome = result.nome;
              _alimentoController.medida = result.medida;
              _alimentoController.caloriasController.text =
                  result.calorias.toString();
              _alimentoController.marcaController.text = result.marca;
              _alimentoController.medidaController.text = result.medida;
              _alimentoController.nomeController.text = result.nome;
              Navigator.of(context).pop();
            },
            onLongPress: () => _speak(
                "${getFieldAndText("Nome", result.nome)} ${getFieldAndText("Marca", result.marca)} ${getFieldAndText("Calorias", result.calorias?.toString())}"),
            child: ListTile(
              title: Text(result.nome ?? result.marca ?? ""),
              subtitle: Text(result.marca ?? result.nome ?? ""),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text((result.calorias?.toString() ?? "") + " calorias"),
                  Text(result.medida ?? ""),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  String getFieldAndText(String field, String text) {
    if (text?.isNotEmpty != true) return null;
    return "$field: $text.";
  }

  @override
  Widget buildSuggestions(BuildContext context) => Container();
}
