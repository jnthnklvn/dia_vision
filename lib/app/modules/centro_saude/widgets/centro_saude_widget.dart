import 'package:dia_vision/app/modules/home/domain/entities/module.dart';
import 'package:dia_vision/app/shared/utils/color_utils.dart';
import 'package:dia_vision/app/shared/utils/date_utils.dart';
import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/model/centro_saude.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';

class CentroSaudeWidget extends StatelessWidget with DateUtil {
  final CentroSaude _centroSaude;

  CentroSaudeWidget(this._centroSaude, {Key? key}) : super(key: key);

  String? getFullString(String? fieldName, String? text) {
    if (text?.isNotEmpty != true) return null;
    return "$fieldName: $text. ";
  }

  @override
  Widget build(BuildContext context) {
    final subtitleContents = [
      getFullString("Tipo", _centroSaude.tipo),
      getFullString("Telefone", _centroSaude.telefone),
      getFullString("Descrição", _centroSaude.descricao),
    ];
    subtitleContents.removeWhere((e) => e == null);

    String stringToSpeak = subtitleContents.toString();
    stringToSpeak = stringToSpeak.length > 1
        ? stringToSpeak.substring(1, stringToSpeak.length - 1)
        : stringToSpeak;

    return InkWell(
      onTap: () => Modular.to.pushNamed(
        "${medicalCenters.routeName}/page",
        arguments: _centroSaude,
      ),
      onLongPress: () => Modular.get<FlutterTts>().speak(
        (getFullString("Nome", _centroSaude.nome) ?? "") + stringToSpeak,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: ColorUtils.colors[_centroSaude.nome.toString().hashCode %
                  ColorUtils.colors.length]
              .withOpacity(0.5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        margin: const EdgeInsets.all(5),
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
                  _centroSaude.nome ?? "",
                  maxLines: 2,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: subtitleContents
                      .map((e) => buildSubtitlesText(e ?? ''))
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
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 18,
        color: Colors.white70,
      ),
    );
  }
}
