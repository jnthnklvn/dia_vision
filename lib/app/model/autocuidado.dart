import 'package:dia_vision/app/shared/utils/date_utils.dart';

import 'package:parse_server_sdk/parse_server_sdk.dart';

const kLink = "link";
const kResumo = "resumo";
const kTitulo = "titulo";
const kCategoria = 'categoria';
const kLinkImagem = 'linkImagem';
const kAutoCuidadoTable = "AutoCuidado";

class Autocuidado extends ParseObject with DateUtils implements ParseCloneable {
  Autocuidado(
      {String titulo,
      String resumo,
      String categoria,
      String link,
      String linkImagem})
      : super(kAutoCuidadoTable) {
    this.titulo = titulo;
    this.resumo = resumo;
    this.categoria = categoria;
    this.link = link;
    this.linkImagem = linkImagem;
  }

  Autocuidado.clone() : this();

  @override
  Autocuidado clone(Map<String, dynamic> map) =>
      Autocuidado.clone()..fromJson(map);

  @override
  Autocuidado fromJson(Map<String, dynamic> objectData) {
    super.fromJson(objectData);
    return this;
  }

  set createdAt(DateTime data) => set<DateTime>("createdAt", data);

  String get link => get<String>(kLink);
  set link(String link) => set<String>(kLink, link);

  String get linkImagem => get<String>(kLinkImagem);
  set linkImagem(String linkImagem) => set<String>(kLinkImagem, linkImagem);

  String get resumo => get<String>(kResumo);
  set resumo(String resumo) => set<String>(kResumo, resumo);

  String get titulo => get<String>(kTitulo);
  set titulo(String titulo) => set<String>(kTitulo, titulo);

  String get categoria => get<String>(kCategoria);
  set categoria(String categoria) => set<String>(kCategoria, categoria);
}
