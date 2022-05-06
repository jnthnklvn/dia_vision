import 'package:dia_vision/app/shared/utils/date_utils.dart';
import 'package:dia_vision/app/repositories/model/paciente.dart';

import 'package:parse_server_sdk/parse_server_sdk.dart';

const kValor = "valor";
const kHorario = "horario";
const kHorarioFixo = "horarioFixo";
const keyPaciente = 'paciente';
const kGlicemiaTable = "Glicemia";

enum HorarioType { jejum, preRefeicao, posRefeicao, aoDeitar, madrugada, outro }

extension HorarioTypeExtension on HorarioType {
  String get name => toString().replaceAll('HorarioType.', '');

  String? get displayTitle {
    switch (this) {
      case HorarioType.jejum:
        return 'Em jejum';
      case HorarioType.posRefeicao:
        return '2h pós refeição';
      case HorarioType.preRefeicao:
        return 'Pré refeição';
      case HorarioType.aoDeitar:
        return 'Ao deitar';
      case HorarioType.madrugada:
        return 'Madrugada';
      case HorarioType.outro:
        return 'Outro';
      default:
        return null;
    }
  }
}

class Glicemia extends ParseObject with DateUtil implements ParseCloneable {
  Glicemia(
      {String? nivel, HorarioType? horario, num? valor, Paciente? paciente})
      : super(kGlicemiaTable) {
    this.horario = horario;
    this.valor = valor;
    this.paciente = paciente;
  }

  Glicemia.clone() : this();

  @override
  Glicemia clone(Map<String, dynamic> map) => Glicemia.clone()..fromJson(map);

  @override
  Glicemia fromJson(Map<String, dynamic> objectData) {
    super.fromJson(objectData);
    return this;
  }

  set createdAt(DateTime? data) => set<DateTime?>("createdAt", data);

  num? get valor => get<num?>(kValor);
  set valor(num? valor) => set<num?>(kValor, valor);

  HorarioType? get horario => HorarioType.values.firstWhere(
      (e) => e.displayTitle == get<String?>(kHorario),
      orElse: () => HorarioType.outro);
  set horario(HorarioType? horario) =>
      set<String?>(kHorario, horario?.displayTitle);

  String? get horarioFixo => get<String?>(kHorarioFixo);
  set horarioFixo(String? horarioFixo) =>
      set<String?>(kHorarioFixo, horarioFixo);

  Paciente? get paciente {
    final pacienteAux = get<ParseObject?>(keyPaciente)?.toJson();
    return pacienteAux != null
        ? (Paciente.clone()..fromJson(pacienteAux))
        : null;
  }

  set paciente(Paciente? paciente) => set(keyPaciente, paciente);

  Map<String, dynamic> toMap() => <String, dynamic>{
        'Data de registro': getDataBrFromDate(createdAt) ?? "",
        'Valor': valor ?? "",
        'Horário': horario?.displayTitle ?? "",
      };
}
