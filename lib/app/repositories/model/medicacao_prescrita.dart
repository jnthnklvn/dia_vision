import 'package:dia_vision/app/modules/medications/utils/medication_utils.dart';
import 'package:dia_vision/app/shared/utils/date_utils.dart';
import 'package:dia_vision/app/repositories/model/paciente.dart';

import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'medicamento.dart';

const kMedicamento = "medicamento";
const kNome = "nome";
const kDosagem = "dosagem";
const kMedidaDosagem = "medidaDosagem";
const keyPaciente = 'paciente';
const kPosologia = "posologia";
const kMedicoPrescritor = "medicoPrescritor";
const kEfeitosColaterais = "efeitosColaterais";
const kDataFinal = "dataFinal";
const kDataInicial = "dataInicial";
const kHorarioInicial = "horarioInicial";
const kHorarios = "horarios";
const kMedicacaoPrescritaTable = "MedicacaoPrescrita";

class MedicacaoPrescrita extends ParseObject
    with DateUtil, MedicationUtils
    implements ParseCloneable {
  MedicacaoPrescrita(
      {Medicamento? medicamento,
      String? horarioInicial,
      String? horarios,
      DateTime? dataInicial,
      DateTime? dataFinal,
      String? medicoPrescritor,
      String? efeitosColaterais,
      String? nome,
      num? dosagem,
      String? medidaDosagem,
      num? posologia,
      Paciente? paciente})
      : super(kMedicacaoPrescritaTable) {
    this.medicamento = medicamento;
    this.nome = nome;
    this.efeitosColaterais = efeitosColaterais;
    this.medicoPrescritor = medicoPrescritor;
    this.horarios = horarios;
    this.horarioInicial = horarioInicial;
    this.dataFinal = dataFinal;
    this.dataInicial = dataInicial;
    this.dosagem = dosagem;
    this.medidaDosagem = medidaDosagem;
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

  Medicamento? get medicamento {
    final medicamentoAux = get<ParseObject?>(keyPaciente)?.toJson();
    return medicamentoAux != null
        ? (Medicamento.clone()..fromJson(medicamentoAux))
        : null;
  }

  set medicamento(Medicamento? medicamento) => set(kMedicamento, medicamento);

  DateTime? get dataFinal => get<DateTime?>(kDataFinal);
  set dataFinal(DateTime? dataFinal) => set<DateTime?>(kDataFinal, dataFinal);

  DateTime? get dataInicial => get<DateTime?>(kDataInicial);
  set dataInicial(DateTime? dataInicial) =>
      set<DateTime?>(kDataInicial, dataInicial);

  String? get medicoPrescritor => get<String?>(kMedicoPrescritor);
  set medicoPrescritor(String? medicoPrescritor) =>
      set<String?>(kMedicoPrescritor, medicoPrescritor);

  String? get horarioInicial => get<String?>(kHorarioInicial);
  set horarioInicial(String? horarioInicial) =>
      set<String?>(kHorarioInicial, horarioInicial);

  String? get horarios => get<String?>(kHorarios);
  set horarios(String? horarios) => set<String?>(kHorarios, horarios);

  String? get efeitosColaterais => get<String?>(kEfeitosColaterais);
  set efeitosColaterais(String? efeitosColaterais) =>
      set<String?>(kEfeitosColaterais, efeitosColaterais);

  String? get nome => get<String?>(kNome);
  set nome(String? nome) => set<String?>(kNome, nome);

  num? get dosagem => get<num?>(kDosagem);
  set dosagem(num? dosagem) => set<num?>(kDosagem, dosagem);

  String? get medidaDosagem => get<String?>(kMedidaDosagem);
  set medidaDosagem(String? medidaDosagem) =>
      set<String?>(kMedidaDosagem, medidaDosagem);

  num? get posologia => get<num?>(kPosologia);
  set posologia(num? posologia) => set<num?>(kPosologia, posologia);

  Paciente? get paciente {
    final pacienteAux = get<ParseObject?>(keyPaciente)?.toJson();
    return pacienteAux != null
        ? (Paciente.clone()..fromJson(pacienteAux))
        : null;
  }

  set paciente(Paciente? paciente) => set(keyPaciente, paciente);

  List<String>? getHorarios() {
    if (posologia == 0 && horarios?.isNotEmpty == true) {
      return horarios!.split(', ');
    } else if (horarioInicial != null && posologia != null && posologia! > 0) {
      final listHorarioInicial = horarioInicial!.split(':');
      final times = 24 ~/ posologia!;
      return List<String>.generate(
        times,
        (i) =>
            "${((num.tryParse(listHorarioInicial[0]) ?? 0) + posologia! * i)}:${listHorarioInicial[1]}",
      );
    }
    return null;
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        'Data de registro': getDataBrFromDate(createdAt) ?? "",
        'Nome Substância': medicamento?.get(kNomeSubstancia) ?? "",
        'Nome Comercial': medicamento?.get(kNomeComercial) ?? nome ?? "",
        'Horário Inicial': horarioInicial ?? "",
        'Horários': horarios?.replaceAll(',', ' -') ?? "",
        'Data Inicial':
            dataInicial != null ? getDataBrFromDate(dataInicial) : "",
        'Data Final': dataFinal != null ? getDataBrFromDate(dataFinal) : "",
        'Posologia': getPosologia(posologia) ?? "",
        'Dosagem': dosagem?.toString() ?? "",
        'Medida de dosagem': medidaDosagem ?? "",
        'Efeitos Colaterais': efeitosColaterais ?? "",
        'Medico Prescritor': medicoPrescritor ?? "",
      };
}
