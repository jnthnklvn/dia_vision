import 'package:dia_vision/app/model/endereco.dart';

import 'package:parse_server_sdk/parse_server_sdk.dart';

const kLinkMaps = "linkMaps";
const kLinkImagem = "linkImagem";
const kNome = "nome";
const kTipo = "tipo";
const kEndereco = 'endereco';
const kTelefone = 'telefone';
const kDescricao = "descricao";
const kCentroSaudeTable = "CentroSaude";

class CentroSaude extends ParseObject implements ParseCloneable {
  CentroSaude({
    String? nome,
    String? descricao,
    String? categoria,
    String? linkMaps,
    String? telefone,
    String? linkImagem,
    String? tipo,
    Endereco? endereco,
  }) : super(kCentroSaudeTable) {
    this.nome = nome;
    this.descricao = descricao;
    this.linkImagem = linkImagem;
    this.telefone = telefone;
    this.linkMaps = linkMaps;
    this.tipo = tipo;
    this.endereco = endereco;
  }

  CentroSaude.clone() : this();

  @override
  CentroSaude clone(Map<String, dynamic> map) =>
      CentroSaude.clone()..fromJson(map);

  @override
  CentroSaude fromJson(Map<String, dynamic> objectData) {
    super.fromJson(objectData);
    return this;
  }

  String? get linkMaps => get<String?>(kLinkMaps);
  set linkMaps(String? linkMaps) => set<String?>(kLinkMaps, linkMaps);

  String? get telefone => get<String?>(kTelefone);
  set telefone(String? telefone) => set<String?>(kTelefone, telefone);

  String? get linkImagem => get<String?>(kLinkImagem);
  set linkImagem(String? linkImagem) => set<String?>(kLinkImagem, linkImagem);

  String? get descricao => get<String?>(kDescricao);
  set descricao(String? descricao) => set<String?>(kDescricao, descricao);

  String? get nome => get<String?>(kNome);
  set nome(String? nome) => set<String?>(kNome, nome);

  String? get tipo => get<String?>(kTipo);
  set tipo(String? tipo) => set<String?>(kTipo, tipo);

  Endereco? get endereco {
    final enderecoAux = get<ParseObject?>(kEndereco)?.toJson();
    return enderecoAux != null
        ? (Endereco.clone()..fromJson(enderecoAux))
        : null;
  }

  set endereco(Endereco? endereco) => set(kEndereco, endereco);
}
