import 'package:dia_vision/app/model/alimentacao.dart';

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

const kNome = "nome";
const kMarca = "marca";
const kMedida = "medida";
const kCalorias = "calorias";
const kPorcaoConsumida = "porcaoConsumida";
const kCaloriasConsumidas = "caloriasConsumidas";
const kProteinas = "proteinas";
const kColesterol = "colesterol";
const kCodigoPais = "codigoPais";
const kCarboidratos = "carboidratos";
const keyAlimentacao = "alimentacao";

const kAlimentoTable = "Alimento";

class Alimento extends ParseObject implements ParseCloneable {
  Alimento({
    num carboidratos,
    num calorias,
    num porcaoConsumida,
    num caloriasConsumidas,
    num colesterol,
    num proteinas,
    String marca,
    String medida,
    String codigoPais,
    String nome,
    String tipo,
    Alimentacao alimentacao,
  }) : super(kAlimentoTable) {
    this.medida = medida;
    this.marca = marca;
    this.codigoPais = codigoPais;
    this.calorias = calorias;
    this.caloriasConsumidas = caloriasConsumidas;
    this.porcaoConsumida = porcaoConsumida;
    this.nome = nome;
    this.tipo = tipo;
    this.carboidratos = carboidratos;
    this.colesterol = colesterol;
    this.proteinas = proteinas;
    this.alimentacao = alimentacao;
  }

  Alimento.clone() : this();

  @override
  Alimento clone(Map<String, dynamic> map) => Alimento.clone()..fromJson(map);

  @override
  Alimento fromJson(Map<String, dynamic> objectData) {
    super.fromJson(objectData);
    return this;
  }

  num get carboidratos => get<num>(kCarboidratos);
  set carboidratos(num carboidratos) => set<num>(kCarboidratos, carboidratos);

  num get colesterol => get<num>(kColesterol);
  set colesterol(num colesterol) => set<num>(kColesterol, colesterol);

  num get calorias => get<num>(kCalorias);
  set calorias(num calorias) => set<num>(kCalorias, calorias);

  num get caloriasConsumidas => get<num>(kCaloriasConsumidas);
  set caloriasConsumidas(num caloriasConsumidas) =>
      set<num>(kCaloriasConsumidas, caloriasConsumidas);

  num get porcaoConsumida => get<num>(kPorcaoConsumida);
  set porcaoConsumida(num porcaoConsumida) =>
      set<num>(kPorcaoConsumida, porcaoConsumida);

  num get proteinas => get<num>(kProteinas);
  set proteinas(num proteinas) => set<num>(kProteinas, proteinas);

  String get marca => get<String>(kMarca);
  set marca(String marca) => set<String>(kMarca, marca);

  String get medida => get<String>(kMedida);
  set medida(String medida) => set<String>(kMedida, medida);

  String get codigoPais => get<String>(kCodigoPais);
  set codigoPais(String codigoPais) => set<String>(kCodigoPais, codigoPais);

  String get nome => get<String>(kNome);
  set nome(String nome) => set<String>(kNome, nome);

  String get tipo => get<String>(kTipo);
  set tipo(String tipo) => set<String>(kTipo, tipo);

  set createdAt(DateTime data) => set<DateTime>("createdAt", data);

  Alimentacao get alimentacao =>
      Alimentacao.clone()..fromJson(get<ParseObject>(keyAlimentacao)?.toJson());
  set alimentacao(Alimentacao alimentacao) => set(keyAlimentacao, alimentacao);

  Alimento fromAPIJson(Map<String, dynamic> json) {
    try {
      final Map<String, dynamic> item = getJsonField(json, 'item');
      final Map<String, dynamic> nutritionalContents =
          getJsonField(item, 'nutritional_contents');
      final List<dynamic> servingSizes = getJsonField(item, 'serving_sizes');
      if (servingSizes.length > 0)
        medida = (getJsonField(servingSizes[0], 'value')?.toString() ?? "") +
            " " +
            (getJsonField(servingSizes[0], 'unit') ?? "");
      carboidratos = getJsonField(nutritionalContents, 'carbohydrates');
      colesterol = getJsonField(nutritionalContents, 'cholesterol');
      proteinas = getJsonField(nutritionalContents, 'protein');
      calorias =
          getJsonField(getJsonField(nutritionalContents, 'energy'), 'value');
      marca = getJsonField(item, 'brand_name');
      codigoPais = getJsonField(item, 'country_code');
      nome = getJsonField(item, 'description');
      tipo = getJsonField(item, 'type');
    } catch (e) {
      print(e);
    }
    return this;
  }

  dynamic getJsonField(Map<String, dynamic> json, String field) {
    return json == null ? null : json[field];
  }

  Map<String, dynamic> toAPIJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['marca'] = this.marca;
    data['codigoPais'] = this.codigoPais;
    data['nome'] = this.nome;
    data['tipo'] = this.tipo;
    data['carboidratos'] = this.carboidratos;
    data['colesterol'] = this.colesterol;
    data['proteinas'] = this.proteinas;
    data['calorias'] = this.calorias;
    data['porcaoConsumida'] = this.porcaoConsumida;
    data['caloriasConsumidas'] = this.caloriasConsumidas;
    data['medida'] = this.medida;
    return data;
  }
}
