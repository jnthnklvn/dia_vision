import 'package:dia_vision/app/modules/home/domain/entities/module.dart';
import 'package:dia_vision/app/shared/components/local_flutter_tts.dart';
import 'package:dia_vision/app/shared/utils/color_utils.dart';
import 'package:dia_vision/app/shared/utils/date_utils.dart';
import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';
import 'package:dia_vision/app/model/diurese.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

class DiureseWidget extends StatelessWidget with DateUtil {
  final Diurese _diurese;

  DiureseWidget(this._diurese, {Key? key}) : super(key: key);

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
      getStringFromBool("Houve ardor?", _diurese.ardor),
      getFullString("Volume (mL)", _diurese.volume?.toString()),
      getFullString("Coloração", _diurese.coloracao),
    ];
    subtitleContents.removeWhere((e) => e == null);

    String stringToSpeak = subtitleContents.toString();
    stringToSpeak = stringToSpeak.length > 1
        ? stringToSpeak.substring(1, stringToSpeak.length - 1)
        : stringToSpeak;

    return InkWell(
      onTap: () => Modular.to.pushNamed(
        "${kidney.routeName}/$registerStr/",
        arguments: _diurese,
      ),
      onLongPress: () => Modular.get<LocalFlutterTts>().speak(stringToSpeak),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: ColorUtils.colors[_diurese.coloracao.toString().hashCode %
                  ColorUtils.colors.length]
              .withOpacity(0.5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        margin: const EdgeInsets.all(8),
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
                  "Dia: " + (getDataBrFromDate(_diurese.createdAt) ?? ""),
                  maxLines: 2,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
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
      maxLines: 2,
      style: const TextStyle(color: Colors.white70),
    );
  }
}
