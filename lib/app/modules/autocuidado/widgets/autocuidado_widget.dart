import 'package:dia_vision/app/modules/home/domain/entities/module.dart';
import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';
import 'package:dia_vision/app/model/autocuidado.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';

class AutocuidadoWidget extends StatelessWidget {
  final Autocuidado _autocuidado;
  final Color categoriaColor;

  const AutocuidadoWidget(this._autocuidado, this.categoriaColor, {Key? key})
      : super(key: key);

  String? getFullString(String? fieldName, String? text) {
    if (text?.isNotEmpty != true) return null;
    return "$fieldName: $text.";
  }

  Widget buildExpandedTexts() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            _autocuidado.titulo ?? "",
            maxLines: 5,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          if (_autocuidado.categoria?.isNotEmpty == true)
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Text(
                "Categoria: " + (_autocuidado.categoria ?? ''),
                maxLines: 3,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final subtitleContents = [
      getFullString("Categoria", _autocuidado.categoria),
      getFullString("Título", _autocuidado.titulo),
    ];
    subtitleContents.removeWhere((e) => e == null);

    String stringToSpeak = subtitleContents.toString();
    stringToSpeak = stringToSpeak.length > 1
        ? stringToSpeak.substring(1, stringToSpeak.length - 1)
        : stringToSpeak;

    return InkWell(
      onTap: () => Modular.to.pushNamed(
        "${selfCare.routeName}/$selfCareArticleRoute/",
        arguments: _autocuidado,
      ),
      onLongPress: () => Modular.get<FlutterTts>().speak(stringToSpeak),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: categoriaColor,
        ),
        child: Card(
          color: kSecondaryColor,
          margin: const EdgeInsets.all(5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          elevation: 3,
          child: buildExpandedTexts(),
        ),
      ),
    );
  }
}
