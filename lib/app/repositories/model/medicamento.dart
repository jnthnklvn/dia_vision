import 'package:parse_server_sdk/parse_server_sdk.dart';

const kNomeSubstancia = "nomeSubstancia";
const kNomeComercial = "nomeComercial";
const kMedicamentoTable = "Medicamento";

class Medicamento extends ParseObject implements ParseCloneable {
  Medicamento({
    String? nomeSubstancia,
    String? nomeComercial,
  }) : super(kMedicamentoTable) {
    this.nomeSubstancia = nomeSubstancia;
    this.nomeComercial = nomeComercial;
  }

  Medicamento.clone() : this();

  @override
  Medicamento clone(Map<String, dynamic> map) =>
      Medicamento.clone()..fromJson(map);

  @override
  Medicamento fromJson(Map<String, dynamic> objectData) {
    super.fromJson(objectData);
    return this;
  }

  String? get nomeSubstancia => get<String?>(kNomeSubstancia);
  set nomeSubstancia(String? nomeSubstancia) =>
      set<String?>(kNomeSubstancia, nomeSubstancia);

  String? get nomeComercial => get<String?>(kNomeComercial);
  set nomeComercial(String? nomeComercial) =>
      set<String?>(kNomeComercial, nomeComercial);
}
