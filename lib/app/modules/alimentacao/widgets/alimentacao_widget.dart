import 'package:dia_vision/app/modules/home/domain/entities/module.dart';
import 'package:dia_vision/app/shared/components/local_flutter_tts.dart';
import 'package:dia_vision/app/shared/utils/color_utils.dart';
import 'package:dia_vision/app/shared/utils/date_utils.dart' as dt;
import 'package:dia_vision/app/shared/utils/strings.dart';
import 'package:dia_vision/app/repositories/model/alimentacao.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

class AlimentacaoWidget extends StatelessWidget with dt.DateUtil {
  final Alimentacao _alimentacao;

  AlimentacaoWidget(this._alimentacao, {Key? key}) : super(key: key);

  String? getFullString(String fieldName, String? text) {
    if (text?.isNotEmpty != true) return null;
    return "$fieldName: $text.";
  }

  @override
  Widget build(BuildContext context) {
    final subtitleContents = [
      getFullString("Calorias", _alimentacao.calorias?.toString()),
      getFullString("Data", getDataBrFromDate(_alimentacao.createdAt)),
    ];
    subtitleContents.removeWhere((e) => e == null);

    String stringToSpeak = subtitleContents.toString();
    stringToSpeak = stringToSpeak.length > 1
        ? stringToSpeak.substring(1, stringToSpeak.length - 1)
        : stringToSpeak;

    return InkWell(
      onTap: () => Modular.to.pushNamed(
        "${alimentation.routeName}/$registerStr/",
        arguments: _alimentacao,
      ),
      onLongPress: () => Modular.get<LocalFlutterTts>()
          .speak("${getFullString('Tipo', _alimentacao.tipo)} $stringToSpeak"),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: ColorUtils.colors[_alimentacao.tipo.toString().hashCode %
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
                  _alimentacao.tipo ?? "",
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
