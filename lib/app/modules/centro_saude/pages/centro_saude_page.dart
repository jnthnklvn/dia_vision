import 'package:dia_vision/app/modules/centro_saude/controllers/centro_saude_controller.dart';
import 'package:dia_vision/app/shared/components/ink_well_speak_text.dart';
import 'package:dia_vision/app/shared/components/back_arrow_button.dart';
import 'package:dia_vision/app/shared/utils/scaffold_utils.dart';
import 'package:dia_vision/app/shared/utils/string_utils.dart';
import 'package:dia_vision/app/shared/utils/date_utils.dart';
import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';
import 'package:dia_vision/app/model/centro_saude.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';

class CentroSaudePage extends StatefulWidget with ScaffoldUtils {
  final CentroSaude _centroSaude;

  CentroSaudePage(this._centroSaude);

  @override
  _CentroSaudePageState createState() =>
      _CentroSaudePageState(scaffoldKey, _centroSaude);
}

class _CentroSaudePageState
    extends ModularState<CentroSaudePage, CentroSaudeController>
    with DateUtils {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final CentroSaude _centroSaude;

  Future _speak(String txt) => Modular.get<FlutterTts>().speak(txt);

  _CentroSaudePageState(this.scaffoldKey, this._centroSaude);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        actions: [
          Padding(padding: const EdgeInsets.all(8.0)),
        ],
        leading: BackArrowButton(iconPadding: 5),
        title: InkWellSpeakText(
          Text(
            MEDICAL_CENTER_TITLE,
            style: TextStyle(
              fontSize: kAppBarTitleSize,
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(6),
          child: ListView(
            children: <Widget>[
              Hero(
                tag: _centroSaude.nome ?? "",
                child: _getImageWidget(_centroSaude.linkImagem),
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
        );
      }
    } catch (e) {}
    return Container();
  }

  Container buildContainer(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          InkWellSpeakText(
            Text(
              _centroSaude.nome ?? "",
              style: TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWellSpeakText(
                  Text(
                    "Registrado em: " +
                        getDataBrFromDate(_centroSaude.createdAt),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ),
                InkWellSpeakText(
                  Text(
                    "Última atualização em: " +
                        getDataBrFromDate(_centroSaude.updatedAt),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15, bottom: 10),
            child: InkWellSpeakText(
              Text(
                _centroSaude.descricao ?? "",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          if (_centroSaude.endereco != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWellSpeakText(
                  Text(
                    "Endereço:",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                InkWellSpeakText(
                  Text(
                    getEnderecoFormatado(_centroSaude.endereco),
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          SizedBox(height: 15),
          if (_centroSaude.linkMaps != null)
            InkWell(
              onLongPress: () => _speak(
                  "Clique no link para ver a localização pelo Google Maps"),
              onTap: () {
                _launchURL(_centroSaude.linkMaps);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWellSpeakText(
                    Text(
                      "Para mais detalhes acesse a localização:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Text(
                    _centroSaude.linkMaps,
                    style: TextStyle(
                        color: kPrimaryColor,
                        decoration: TextDecoration.underline),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url))
      await launch(url);
    else
      widget.onError("Ocorreu um erro");
  }
}
