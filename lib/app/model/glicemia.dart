import 'package:dia_vision/app/model/paciente.dart';

import 'package:parse_server_sdk/parse_server_sdk.dart';

const kValor = "valor";
const kHorario = "horario";
const keyPaciente = 'paciente';
const kGlicemiaTable = "Glicemia";

enum HorarioType { JEJUM, POS_REFEICAO, AO_DEITAR, MADRUGADA }

extension HorarioTypeExtension on HorarioType {
  String get name => this.toString().replaceAll('HorarioType.', '');

  String get displayTitle {
    switch (this) {
      case HorarioType.JEJUM:
        return 'Em jejum';
      case HorarioType.POS_REFEICAO:
        return '2h pós refeição';
      case HorarioType.AO_DEITAR:
        return 'Ao deitar';
      case HorarioType.MADRUGADA:
        return 'Madrugada';
      default:
        return null;
    }
  }
}

class Glicemia extends ParseObject implements ParseCloneable {
  Glicemia({String nivel, HorarioType horario, num valor, Paciente paciente})
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

  set createdAt(DateTime data) => set<DateTime>("createdAt", data);

  num get valor => get<num>(kValor);
  set valor(num valor) => set<num>(kValor, valor);

  HorarioType get horario => HorarioType.values.firstWhere(
      (e) => e.displayTitle == get<String>(kHorario),
      orElse: () => null);
  set horario(HorarioType horario) =>
      set<String>(kHorario, horario?.displayTitle);

  Paciente get paciente =>
      Paciente.clone()..fromJson(get<ParseObject>(keyPaciente)?.toJson());
  set paciente(Paciente paciente) => set(keyPaciente, paciente);

  Map<String, dynamic> toMap() => <String, dynamic>{
        'Valor': valor ?? "",
        'Horário': horario?.displayTitle ?? "",
      };
}
