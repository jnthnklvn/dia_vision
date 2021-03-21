import 'package:dia_vision/app/modules/home/domain/entities/module.dart';
import 'package:dia_vision/app/model/medicacao_prescrita.dart';
import 'package:dia_vision/app/shared/utils/color_utils.dart';
import 'package:dia_vision/app/shared/utils/date_utils.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';

class MedicationWidget extends StatelessWidget with DateUtils {
  final MedicacaoPrescrita _medicacaoPrescrita;

  const MedicationWidget(this._medicacaoPrescrita);

  String getFullString(String fieldName, String text) {
    if (text?.isNotEmpty != true) return null;
    return "$fieldName: $text";
  }

  @override
  Widget build(BuildContext context) {
    final subtitleContents = [
      getFullString("Posologia", _medicacaoPrescrita.posologia?.toString()),
      getFullString("Dosagem", _medicacaoPrescrita.dosagem?.toString()),
      getFullString(
          "Data inicial", getDataBrFromDate(_medicacaoPrescrita.dataInicial)),
      getFullString(
          "Data final", getDataBrFromDate(_medicacaoPrescrita.dataFinal)),
      getFullString("Médico Prescritor", _medicacaoPrescrita.medicoPrescritor),
      getFullString(
          "Efeitos colaterais", _medicacaoPrescrita.efeitosColaterais),
    ];
    subtitleContents.removeWhere((e) => e == null);

    String stringToSpeak = subtitleContents.toString();
    stringToSpeak = stringToSpeak.length > 1
        ? stringToSpeak.substring(1, stringToSpeak.length - 1)
        : stringToSpeak;

    return InkWell(
      onTap: () => Modular.to.pushNamed(
        "${medications.routeName}/$REGISTER",
        arguments: _medicacaoPrescrita,
      ),
      onLongPress: () => Modular.get<FlutterTts>().speak(
        getFullString("Nome", _medicacaoPrescrita.nome) + stringToSpeak,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: ColorUtils.colors[
              _medicacaoPrescrita.nome.hashCode % ColorUtils.colors.length],
        ),
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        margin: EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Color(0xFF01215e),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  _medicacaoPrescrita.nome,
                  maxLines: 2,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
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
      maxLines: 2,
      style: TextStyle(
        fontSize: 18,
        color: Colors.white70,
      ),
    );
  }
}
