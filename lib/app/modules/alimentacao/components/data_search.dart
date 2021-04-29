import 'package:dia_vision/app/modules/alimentacao/controllers/alimento_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class DataSearch extends SearchDelegate<String> {
  final AlimentoController _alimentoController;
  final Function(String) onError;

  DataSearch(this._alimentoController, this.onError);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
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
              "A busca deve haver pelos menos 3 letras",
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
              child: Text("Não foram encontrados alimentos"),
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

  @override
  Widget buildSuggestions(BuildContext context) => Container();
}
