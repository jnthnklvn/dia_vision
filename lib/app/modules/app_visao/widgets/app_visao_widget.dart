import 'package:dia_vision/app/shared/components/local_flutter_tts.dart';
import 'package:dia_vision/app/shared/utils/color_utils.dart';
import 'package:dia_vision/app/shared/utils/date_utils.dart' as dt;
import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/model/app_visao.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

import 'dart:io';

class AppVisaoWidget extends StatelessWidget with dt.DateUtil {
  final AppVisao _appVisao;
  final Function(String) _onError;

  AppVisaoWidget(this._appVisao, this._onError, {Key? key}) : super(key: key);

  String? getFullString(String? fieldName, String? text) {
    if (text?.isNotEmpty != true) return null;
    return "$fieldName: $text";
  }

  @override
  Widget build(BuildContext context) {
    final subtitleContents = [
      getFullString("Descrição", _appVisao.descricao),
    ];
    subtitleContents.removeWhere((e) => e == null);

    String stringToSpeak = subtitleContents.toString();
    stringToSpeak = stringToSpeak.length > 1
        ? stringToSpeak.substring(1, stringToSpeak.length - 1)
        : stringToSpeak;

    return InkWell(
      onTap: () => _launchURL(
        (Platform.isIOS
                ? _appVisao.linkAppleStore
                : _appVisao.linkGooglePlay) ??
            '',
      ),
      onLongPress: () => Modular.get<LocalFlutterTts>().speak(
        (getFullString("Título", _appVisao.titulo) ?? "") + ". $stringToSpeak",
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: ColorUtils.colors[_appVisao.titulo.toString().hashCode %
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
                  _appVisao.titulo ?? "",
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

  Future<void> _launchURL(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        _onError("Erro ao tentar acessar link do app.");
      }
    } catch (e) {
      _onError(e.toString());
    }
  }

  Widget buildSubtitlesText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white70,
      ),
    );
  }
}
