import 'package:dia_vision/app/shared/utils/string_utils.dart';
import 'package:dia_vision/app/shared/utils/date_utils.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'paciente.dart';

const kTipo = "tipo";
const kCalorias = "calorias";
const keyPaciente = 'paciente';

const kAlimentacaoTable = "Alimentacao";

enum MealType { cafe, almoco, jantar, lanche }

extension MealTypeExtension on MealType {
  String get name => capitalize(toString().replaceAll('MealType.', ''));

  String? get displayTitle {
    switch (this) {
      case MealType.cafe:
        return 'Café da manhã';
      case MealType.almoco:
        return 'Almoço';
      case MealType.jantar:
        return 'Jantar';
      case MealType.lanche:
        return 'Lanche';
      default:
        return null;
    }
  }
}

class Alimentacao extends ParseObject with DateUtil implements ParseCloneable {
  Alimentacao({
    String? tipo,
    num? calorias,
    Paciente? paciente,
  }) : super(kAlimentacaoTable) {
    this.paciente = paciente;
    this.calorias = calorias;
    this.tipo = tipo;
  }

  Alimentacao.clone() : this();

  @override
  Alimentacao clone(Map<String, dynamic> map) =>
      Alimentacao.clone()..fromJson(map);

  @override
  Alimentacao fromJson(Map<String, dynamic> objectData) {
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

  String? get tipo => get<String?>(kTipo);
  set tipo(String? tipo) => set<String?>(kTipo, tipo);

  num? get calorias => get<num?>(kCalorias);
  set calorias(num? calorias) => set<num?>(kCalorias, calorias);

  Map<String, dynamic> toMap() => <String, dynamic>{
        'Data de registro': getDataBrFromDate(createdAt) ?? "",
        'Calorias': calorias ?? "",
        'Tipo': tipo ?? "",
      };
}
