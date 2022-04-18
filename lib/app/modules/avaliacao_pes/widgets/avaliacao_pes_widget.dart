import 'package:dia_vision/app/shared/components/local_flutter_tts.dart';
import 'package:dia_vision/app/modules/home/domain/entities/module.dart';
import 'package:dia_vision/app/shared/utils/color_utils.dart';
import 'package:dia_vision/app/shared/utils/date_utils.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';
import 'package:dia_vision/app/model/avaliacao_pes.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

class AvaliacaoPesWidget extends StatelessWidget with DateUtil {
  final AvaliacaoPes _avaliacaoPes;

  AvaliacaoPesWidget(this._avaliacaoPes, {Key? key}) : super(key: key);

  String? getFullString(String? fieldName, String? text) {
    if (text?.isNotEmpty != true) return null;
    return "$fieldName: $text.";
  }

  String? getStringFromBool(String? fieldName, bool? value) {
    if (value == null) return null;
    return "$fieldName ${value ? 'Sim' : 'Não'}.";
  }

  @override
  Widget build(BuildContext context) {
    final subtitleContents = [
      getStringFromBool("Possui calos?", _avaliacaoPes.calos),
      getStringFromBool(
          "Checa os pés antes de calçar?", _avaliacaoPes.checaAntesCalcar),
      getStringFromBool("Corta unhas?", _avaliacaoPes.cortaUnhas),
      getFullString("Última consulta",
          getDataBrFromDate(_avaliacaoPes.dataUltimaConsulta)),
      getStringFromBool("Estão hidratados?", _avaliacaoPes.hidratados),
      getStringFromBool("Estão lavados?", _avaliacaoPes.lavou),
      getFullString("Temperatura da lavagem", _avaliacaoPes.temperaturaLavagem),
      getStringFromBool(
          "Possuem pontos vermelhos?", _avaliacaoPes.pontosVermelhos),
      getStringFromBool("Possuem rachaduras?", _avaliacaoPes.rachaduras),
      getStringFromBool("Secou?", _avaliacaoPes.secou),
      getStringFromBool(
          "Usa protetor solar nos pés?", _avaliacaoPes.usaProtetorSolarPes),
    ];
    subtitleContents.removeWhere((e) => e == null);

    String stringToSpeak = subtitleContents.toString();
    stringToSpeak = stringToSpeak.length > 1
        ? stringToSpeak.substring(1, stringToSpeak.length - 1)
        : stringToSpeak;

    return InkWell(
      onTap: () => Modular.to.pushNamed(
        "${feet.routeName}/$registerStr/",
        arguments: _avaliacaoPes,
      ),
      onLongPress: () => Modular.get<LocalFlutterTts>().speak(stringToSpeak),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: ColorUtils.colors[
                  _avaliacaoPes.temperaturaLavagem.toString().hashCode %
                      ColorUtils.colors.length]
              .withOpacity(0.5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        margin: const EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Theme.of(context).brightness == Brightness.dark
                ? const Color.fromARGB(246, 36, 36, 36).withOpacity(.75)
                : const Color(0xFFF5F6F9).withOpacity(.75),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  "Dia: " + (getDataBrFromDate(_avaliacaoPes.createdAt) ?? ""),
                  maxLines: 2,
                  style: Theme.of(context).textTheme.bodyText1?.merge(
                        const TextStyle(fontWeight: FontWeight.bold),
                      ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: subtitleContents
                      .map((e) => Text(
                            e ?? '',
                            maxLines: 2,
                            style: Theme.of(context).textTheme.bodyText1,
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
