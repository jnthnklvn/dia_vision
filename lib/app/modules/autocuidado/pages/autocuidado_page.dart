import 'package:dia_vision/app/modules/autocuidado/controllers/autocuidado_controller.dart';
import 'package:dia_vision/app/shared/components/ink_well_speak_text.dart';
import 'package:dia_vision/app/shared/components/back_arrow_button.dart';
import 'package:dia_vision/app/shared/utils/scaffold_utils.dart';
import 'package:dia_vision/app/shared/utils/date_utils.dart';
import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';
import 'package:dia_vision/app/model/autocuidado.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';

class AutocuidadoPage extends StatefulWidget with ScaffoldUtils {
  final Autocuidado _autocuidado;

  AutocuidadoPage(this._autocuidado, {Key? key}) : super(key: key);

  @override
  _AutocuidadoPageState createState() =>
      _AutocuidadoPageState(scaffoldKey, _autocuidado);
}

class _AutocuidadoPageState
    extends ModularState<AutocuidadoPage, AutocuidadoController> with DateUtil {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Autocuidado _autocuidado;

  Future _speak(String txt) => Modular.get<FlutterTts>().speak(txt);

  _AutocuidadoPageState(this.scaffoldKey, this._autocuidado);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        actions: const [
          Padding(padding: EdgeInsets.all(8.0)),
        ],
        leading: const BackArrowButton(iconPadding: 5),
        title: const InkWellSpeakText(
          Text(
            selfCareTitle,
            style: TextStyle(
              fontSize: kAppBarTitleSize,
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(6),
          child: ListView(
            children: <Widget>[
              Hero(
                tag: _autocuidado.titulo ?? '',
                child: _autocuidado.linkImagem != null
                    ? _getImageWidget(_autocuidado.linkImagem!)
                    : Container(),
              ),
              buildContainer(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getImageWidget(String linkImagem) {
    try {
      if (linkImagem != '') {
        return Image.network(
          linkImagem,
          fit: BoxFit.cover,
          excludeFromSemantics: true,
        );
      }
    } catch (_) {}
    return Container();
  }

  Container buildContainer(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          InkWellSpeakText(
            Text(
              _autocuidado.titulo ?? "",
              style: const TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWellSpeakText(
                  Text(
                    "Publicado em: " +
                        (getDataBrFromDate(_autocuidado.createdAt) ?? ''),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ),
                InkWellSpeakText(
                  Text(
                    "Última atualização em: " +
                        (getDataBrFromDate(_autocuidado.updatedAt) ?? ''),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 20),
            child: InkWellSpeakText(
              Text(
                _autocuidado.resumo ?? "",
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
          if (_autocuidado.link != null)
            InkWell(
              onLongPress: () => _speak("Para mais detalhes clique no link"),
              onTap: (_autocuidado.link != null)
                  ? () => _launchURL(_autocuidado.link!)
                  : null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWellSpeakText(
                    Text(
                      "Para mais detalhes acesse:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Text(
                    _autocuidado.link ?? '',
                    style: const TextStyle(
                      color: kPrimaryColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      widget.onError("Ocorreu um erro");
    }
  }
}
