import 'package:dia_vision/app/shared/utils/string_utils.dart';
import 'package:dia_vision/app/shared/utils/date_utils.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'paciente.dart';

const kTipo = "tipo";
const kDuracao = "duracao";
const kDistancia = "distancia";
const keyPaciente = 'paciente';

const kAtividadeFisicaTable = "AtividadeFisica";

enum ExerciseType {
  caminhada,
  corrida,
  outro,
}

extension ExerciseTypeExtension on ExerciseType {
  String get name => capitalize(toString().replaceAll('ExerciseType.', ''));
}

class AtividadeFisica extends ParseObject
    with DateUtil
    implements ParseCloneable {
  AtividadeFisica({
    num? distancia,
    num? duracao,
    String? tipo,
    Paciente? paciente,
  }) : super(kAtividadeFisicaTable) {
    this.distancia = distancia;
    this.paciente = paciente;
    this.duracao = duracao;
    this.tipo = tipo;
  }

  AtividadeFisica.clone() : this();

  @override
  AtividadeFisica clone(Map<String, dynamic> map) =>
      AtividadeFisica.clone()..fromJson(map);

  @override
  AtividadeFisica fromJson(Map<String, dynamic> objectData) {
    super.fromJson(objectData);
    return this;
  }

  Paciente? get paciente {
    final pacienteAux = get<ParseObject?>(keyPaciente)?.toJson();
    return pacienteAux != null
        ? (Paciente.clone()..fromJson(pacienteAux))
        : null;
  }

  set paciente(Paciente? paciente) => set(keyPaciente, paciente);

  set createdAt(DateTime? data) => set<DateTime?>("createdAt", data);

  num? get duracao => get<num?>(kDuracao);
  set duracao(num? duracao) => set<num?>(kDuracao, duracao);

  num? get distancia => get<num?>(kDistancia);
  set distancia(num? distancia) => set<num?>(kDistancia, distancia);

  String? get tipo => get<String?>(kTipo);
  set tipo(String? tipo) => set<String?>(kTipo, tipo);

  Map<String, dynamic> toMap() => <String, dynamic>{
        'Data de registro': getDataBrFromDate(createdAt) ?? "",
        'Tipo': tipo ?? "",
        'Duração (min)': duracao?.toString() ?? "",
        'Distância (km)': distancia?.toString() ?? "",
      };
}
