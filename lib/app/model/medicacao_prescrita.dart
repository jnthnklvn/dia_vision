import 'package:dia_vision/app/shared/utils/date_utils.dart';
import 'package:dia_vision/app/model/paciente.dart';

import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'medicamento.dart';

const kMedicamento = "medicamento";
const kNome = "nome";
const kDosagem = "dosagem";
const keyPaciente = 'paciente';
const kPosologia = "posologia";
const kMedicoPrescritor = "medicoPrescritor";
const kEfeitosColaterais = "efeitosColaterais";
const kDataFinal = "dataFinal";
const kDataInicial = "dataInicial";
const kMedicacaoPrescritaTable = "MedicacaoPrescrita";

class MedicacaoPrescrita extends ParseObject
    with DateUtils
    implements ParseCloneable {
  MedicacaoPrescrita(
      {Medicamento medicamento,
      DateTime dataInicial,
      DateTime dataFinal,
      String medicoPrescritor,
      String efeitosColaterais,
      String nome,
      num dosagem,
      num posologia,
      Paciente paciente})
      : super(kMedicacaoPrescritaTable) {
    this.medicamento = medicamento;
    this.nome = nome;
    this.efeitosColaterais = efeitosColaterais;
    this.medicoPrescritor = medicoPrescritor;
    this.dataFinal = dataFinal;
    this.dataInicial = dataInicial;
    this.dosagem = dosagem;
    this.posologia = posologia;
    this.paciente = paciente;
  }

  MedicacaoPrescrita.clone() : this();

  @override
  MedicacaoPrescrita clone(Map<String, dynamic> map) =>
      MedicacaoPrescrita.clone()..fromJson(map);

  @override
  MedicacaoPrescrita fromJson(Map<String, dynamic> objectData) {
    super.fromJson(objectData);
    return this;
  }

  Medicamento get medicamento =>
      Medicamento.clone()..fromJson(get<ParseObject>(kMedicamento)?.toJson());
  set medicamento(Medicamento medicamento) => set(kMedicamento, medicamento);

  DateTime get dataFinal => get<DateTime>(kDataFinal);
  set dataFinal(DateTime dataFinal) => set<DateTime>(kDataFinal, dataFinal);

  DateTime get dataInicial => get<DateTime>(kDataInicial);
  set dataInicial(DateTime dataInicial) =>
      set<DateTime>(kDataInicial, dataInicial);

  String get medicoPrescritor => get<String>(kMedicoPrescritor);
  set medicoPrescritor(String medicoPrescritor) =>
      set<String>(kMedicoPrescritor, medicoPrescritor);

  String get efeitosColaterais => get<String>(kEfeitosColaterais);
  set efeitosColaterais(String efeitosColaterais) =>
      set<String>(kEfeitosColaterais, efeitosColaterais);

  String get nome => get<String>(kNome);
  set nome(String nome) => set<String>(kNome, nome);

  num get dosagem => get<num>(kDosagem);
  set dosagem(num dosagem) => set<num>(kDosagem, dosagem);

  num get posologia => get<num>(kPosologia);
  set posologia(num posologia) => set<num>(kPosologia, posologia);

  Paciente get paciente =>
      Paciente.clone()..fromJson(get<ParseObject>(keyPaciente)?.toJson());
  set paciente(Paciente paciente) => set(keyPaciente, paciente);

  Map<String, dynamic> toMap() => <String, dynamic>{
        'Nome Substância': medicamento?.get(kNomeSubstancia) ?? "",
        'Nome Comercial': medicamento?.get(kNomeComercial) ?? nome,
        'Data Inicial':
            dataInicial != null ? getDataBrFromDate(dataInicial) : "",
        'Data Final': dataFinal != null ? getDataBrFromDate(dataFinal) : "",
        'Posologia': posologia?.toString() ?? "",
        'Dosagem': dosagem?.toString() ?? "",
        'Efeitos Colaterais': efeitosColaterais ?? "",
        'Medico Prescritor': medicoPrescritor ?? "",
      };
}
