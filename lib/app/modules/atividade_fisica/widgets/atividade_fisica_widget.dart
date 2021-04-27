import 'package:dia_vision/app/modules/home/domain/entities/module.dart';
import 'package:dia_vision/app/shared/utils/color_utils.dart';
import 'package:dia_vision/app/shared/utils/date_utils.dart';
import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/model/atividade_fisica.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';

class AtividadeFisicaWidget extends StatelessWidget with DateUtils {
  final AtividadeFisica _atividadeFisica;

  const AtividadeFisicaWidget(this._atividadeFisica);

  String getFullString(String fieldName, String text) {
    if (text?.isNotEmpty != true) return null;
    return "$fieldName: $text.";
  }

  @override
  Widget build(BuildContext context) {
    final subtitleContents = [
      getFullString("Distância (km)", _atividadeFisica.distancia?.toString()),
      getFullString("Duração (minutos)", _atividadeFisica.duracao?.toString()),
    ];
    subtitleContents.removeWhere((e) => e == null);

    String stringToSpeak = subtitleContents.toString();
    stringToSpeak = stringToSpeak.length > 1
        ? stringToSpeak.substring(1, stringToSpeak.length - 1)
        : stringToSpeak;

    return InkWell(
      onTap: () => Modular.to.pushNamed(
        "${exercises.routeName}/$REGISTER",
        arguments: _atividadeFisica,
      ),
      onLongPress: () => Modular.get<FlutterTts>().speak(
          "${getFullString('Tipo', _atividadeFisica.tipo)} $stringToSpeak"),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: ColorUtils.colors[_atividadeFisica.tipo.toString().hashCode %
                  ColorUtils.colors.length]
              .withOpacity(0.5),
        ),
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        margin: EdgeInsets.all(5),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: kSecondaryColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  _atividadeFisica.tipo ?? "",
                  maxLines: 2,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: subtitleContents
                      .map((e) => buildSubtitlesText(e))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSubtitlesText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 18,
        color: Colors.white70,
      ),
    );
  }
}
