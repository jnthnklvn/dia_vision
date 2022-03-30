import 'package:dia_vision/app/modules/centro_saude/controllers/centro_saude_controller.dart';
import 'package:dia_vision/app/shared/components/ink_well_speak_text.dart';
import 'package:dia_vision/app/shared/components/back_arrow_button.dart';
import 'package:dia_vision/app/shared/utils/scaffold_utils.dart';
import 'package:dia_vision/app/shared/utils/string_utils.dart';
import 'package:dia_vision/app/shared/utils/date_utils.dart';
import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';
import 'package:dia_vision/app/model/centro_saude.dart';
import 'package:dia_vision/app/model/endereco.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';

class CentroSaudePage extends StatefulWidget with ScaffoldUtils {
  final CentroSaude _centroSaude;

  CentroSaudePage(this._centroSaude, {Key? key}) : super(key: key);

  @override
  _CentroSaudePageState createState() =>
      _CentroSaudePageState(scaffoldKey, _centroSaude);
}

class _CentroSaudePageState
    extends ModularState<CentroSaudePage, CentroSaudeController> with DateUtil {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final CentroSaude _centroSaude;

  Future _speak(String txt) => Modular.get<FlutterTts>().speak(txt);

  _CentroSaudePageState(this.scaffoldKey, this._centroSaude);

  String getEnderecoFormatado(Endereco endereco) {
    String strFormatada = endereco.rua ?? "";
    strFormatada +=
        endereco.numero != null ? ", " + endereco.numero.toString() : "";
    strFormatada +=
        isNullOrEmpty(endereco.complemento) ? "" : ", " + endereco.complemento!;
    strFormatada +=
        isNullOrEmpty(endereco.bairro) ? "" : ", " + endereco.bairro!;
    strFormatada +=
        isNullOrEmpty(endereco.cidade) ? "" : ", " + endereco.cidade!;
    strFormatada +=
        isNullOrEmpty(endereco.estado) ? "" : "/" + endereco.estado!;
    strFormatada += isNullOrEmpty(endereco.cep) ? "" : ", " + endereco.cep!;
    return strFormatada;
  }

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
            medicalCenterTitle,
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
                tag: _centroSaude.nome ?? "",
                child: _centroSaude.linkImagem == null
                    ? Container()
                    : _getImageWidget(_centroSaude.linkImagem!),
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
              _centroSaude.nome ?? "",
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
                    "Registrado em: " +
                        (getDataBrFromDate(_centroSaude.createdAt) ?? ''),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ),
                InkWellSpeakText(
                  Text(
                    "Última atualização em: " +
                        (getDataBrFromDate(_centroSaude.updatedAt) ?? ''),
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
            margin: const EdgeInsets.only(top: 15, bottom: 10),
            child: InkWellSpeakText(
              Text(
                _centroSaude.descricao ?? "",
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
          if (_centroSaude.endereco != null)
            InkWell(
              onLongPress: () => _speak(_centroSaude.endereco == null
                  ? "Endereço não encontrado."
                  : "Endereço: ${getEnderecoFormatado(_centroSaude.endereco!)}."),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Endereço:",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    _centroSaude.endereco == null
                        ? "Endereço não encontrado."
                        : "Endereço: ${getEnderecoFormatado(_centroSaude.endereco!)}.",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 15),
          if (_centroSaude.telefone != null)
            InkWell(
              onLongPress: () =>
                  _speak("Telefone para contato: ${_centroSaude.telefone}"),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Telefone para contato:",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    _centroSaude.telefone ?? '',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 15),
          if (_centroSaude.linkMaps != null)
            InkWell(
              onLongPress: () => _speak(
                  "Clique no link para ver a localização pelo Google Maps"),
              onTap: _centroSaude.linkMaps != null
                  ? () => _launchURL(_centroSaude.linkMaps!)
                  : null,
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
                    _centroSaude.linkMaps ?? '',
                    style: const TextStyle(
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
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      widget.onError("Ocorreu um erro");
    }
  }
}
