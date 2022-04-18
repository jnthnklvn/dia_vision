import 'package:dia_vision/app/shared/components/local_flutter_tts.dart';
import 'package:dia_vision/app/modules/home/domain/entities/module.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';
import 'package:dia_vision/app/model/autocuidado.dart';

import 'package:flutter_modular/flutter_modular.dart';
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

  Widget buildExpandedTexts(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            _autocuidado.titulo ?? "",
            maxLines: 5,
            style: Theme.of(context).textTheme.bodyText1?.merge(
                  const TextStyle(fontWeight: FontWeight.bold),
                ),
            overflow: TextOverflow.ellipsis,
          ),
          if (_autocuidado.categoria?.isNotEmpty == true)
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Text(
                "Categoria: " + (_autocuidado.categoria ?? ''),
                maxLines: 3,
                style: Theme.of(context).textTheme.bodyText1,
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
      onLongPress: () => Modular.get<LocalFlutterTts>().speak(stringToSpeak),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: categoriaColor,
        ),
        child: Card(
          color: Theme.of(context).brightness == Brightness.dark
              ? const Color.fromARGB(246, 36, 36, 36).withOpacity(.75)
              : const Color(0xFFF5F6F9).withOpacity(.75),
          margin: const EdgeInsets.all(5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          elevation: 3,
          child: buildExpandedTexts(context),
        ),
      ),
    );
  }
}
