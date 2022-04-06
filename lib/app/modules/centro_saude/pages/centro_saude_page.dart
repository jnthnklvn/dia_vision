import 'package:dia_vision/app/modules/centro_saude/controllers/centro_saude_controller.dart';
import 'package:dia_vision/app/shared/components/floating_options_button.dart';
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
import 'package:flutter/material.dart';

class CentroSaudePage extends StatefulWidget with ScaffoldUtils {
  final CentroSaude centroSaude;

  CentroSaudePage(this.centroSaude, {Key? key}) : super(key: key);

  @override
  _CentroSaudePageState createState() => _CentroSaudePageState();
}

class _CentroSaudePageState
    extends ModularState<CentroSaudePage, CentroSaudeController> with DateUtil {
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
      key: widget.scaffoldKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingOptionsButton(),
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
                tag: widget.centroSaude.nome ?? "",
                child: widget.centroSaude.linkImagem == null
                    ? Container()
                    : _getImageWidget(widget.centroSaude.linkImagem!),
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
              widget.centroSaude.nome ?? "",
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
                        (getDataBrFromDate(widget.centroSaude.createdAt) ?? ''),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ),
                InkWellSpeakText(
                  Text(
                    "Última atualização em: " +
                        (getDataBrFromDate(widget.centroSaude.updatedAt) ?? ''),
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
                widget.centroSaude.descricao ?? "",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).textTheme.bodyText1?.color,
                ),
              ),
            ),
          ),
          if (widget.centroSaude.endereco != null)
            InkWell(
              onLongPress: () => widget.speak(widget.centroSaude.endereco ==
                      null
                  ? "Endereço não encontrado."
                  : "Endereço: ${getEnderecoFormatado(widget.centroSaude.endereco!)}."),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Endereço:",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1?.color,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    widget.centroSaude.endereco == null
                        ? "Endereço não encontrado."
                        : "Endereço: ${getEnderecoFormatado(widget.centroSaude.endereco!)}.",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1?.color,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 15),
          if (widget.centroSaude.telefone != null)
            InkWell(
              onLongPress: () => widget.speak(
                  "Telefone para contato: ${widget.centroSaude.telefone}"),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Telefone para contato:",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1?.color,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    widget.centroSaude.telefone ?? '',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1?.color,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 15),
          if (widget.centroSaude.linkMaps != null)
            InkWell(
              onLongPress: () => widget.speak(
                  "Clique no link para ver a localização pelo Google Maps"),
              onTap: widget.centroSaude.linkMaps != null
                  ? () => _launchURL(widget.centroSaude.linkMaps!)
                  : null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWellSpeakText(
                    Text(
                      "Para mais detalhes acesse a localização:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyText1?.color,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Text(
                    widget.centroSaude.linkMaps ?? '',
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
