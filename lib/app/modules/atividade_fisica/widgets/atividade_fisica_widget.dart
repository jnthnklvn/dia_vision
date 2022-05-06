import 'package:dia_vision/app/modules/home/domain/entities/module.dart';
import 'package:dia_vision/app/shared/components/local_flutter_tts.dart';
import 'package:dia_vision/app/shared/utils/color_utils.dart';
import 'package:dia_vision/app/shared/utils/date_utils.dart' as dt;
import 'package:dia_vision/app/repositories/model/atividade_fisica.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

class AtividadeFisicaWidget extends StatelessWidget with dt.DateUtil {
  final AtividadeFisica _atividadeFisica;

  AtividadeFisicaWidget(this._atividadeFisica, {Key? key}) : super(key: key);

  String? getFullString(String? fieldName, String? text, {String? finalText}) {
    if (text?.isNotEmpty != true) return null;
    return "$fieldName: $text${finalText ?? ""}.";
  }

  @override
  Widget build(BuildContext context) {
    final subtitleContents = [
      getFullString("Distância", _atividadeFisica.distancia?.toString(),
          finalText: " km"),
      getFullString("Duração", _atividadeFisica.duracao?.toString(),
          finalText: " min"),
      getFullString("Data", getDataBrFromDate(_atividadeFisica.createdAt)),
    ];
    subtitleContents.removeWhere((e) => e == null);

    String stringToSpeak = subtitleContents.toString();
    stringToSpeak = stringToSpeak.length > 1
        ? stringToSpeak.substring(1, stringToSpeak.length - 1)
        : stringToSpeak;

    return InkWell(
      onTap: () => Modular.to.pushNamed(
        "${exercises.routeName}/$registerStr/",
        arguments: _atividadeFisica,
      ),
      onLongPress: () => Modular.get<LocalFlutterTts>().speak(
          "${getFullString('Tipo', _atividadeFisica.tipo, finalText: "")} $stringToSpeak"),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: ColorUtils.colors[_atividadeFisica.tipo.toString().hashCode %
                  ColorUtils.colors.length]
              .withOpacity(0.5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        margin: const EdgeInsets.all(5),
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
                  _atividadeFisica.tipo ?? "",
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
                              style: Theme.of(context).textTheme.bodyText1,
                            ))
                        .toList()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
