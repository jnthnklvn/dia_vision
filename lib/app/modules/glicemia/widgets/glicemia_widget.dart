import 'package:dia_vision/app/modules/home/domain/entities/module.dart';
import 'package:dia_vision/app/shared/components/local_flutter_tts.dart';
import 'package:dia_vision/app/shared/utils/color_utils.dart';
import 'package:dia_vision/app/shared/utils/date_utils.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';
import 'package:dia_vision/app/repositories/model/glicemia.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

class GlicemiaWidget extends StatelessWidget with DateUtil {
  final Glicemia _glicemia;

  GlicemiaWidget(this._glicemia, {Key? key}) : super(key: key);

  String? getFullString(String? fieldName, String? text) {
    if (text?.isNotEmpty != true) return null;
    return "$fieldName: $text.";
  }

  @override
  Widget build(BuildContext context) {
    final subtitleContents = [
      getFullString("Valor (mg/dL)", _glicemia.valor?.toString()),
      getFullString(
        "Horário",
        _glicemia.horario == HorarioType.outro
            ? _glicemia.horarioFixo
            : _glicemia.horario?.displayTitle,
      ),
    ];
    subtitleContents.removeWhere((e) => e == null);

    String stringToSpeak = subtitleContents.toString();
    stringToSpeak = stringToSpeak.length > 1
        ? stringToSpeak.substring(1, stringToSpeak.length - 1)
        : stringToSpeak;

    return InkWell(
      onTap: () => Modular.to.pushNamed(
        "${glicemy.routeName}/$registerStr/",
        arguments: _glicemia,
      ),
      onLongPress: () => Modular.get<LocalFlutterTts>().speak(stringToSpeak),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: ColorUtils.colors[
                  (_glicemia.horario?.displayTitle.toString().hashCode ?? 0) %
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
                  "Dia: " + (getDataBrFromDate(_glicemia.createdAt) ?? ""),
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
                        .toList()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
