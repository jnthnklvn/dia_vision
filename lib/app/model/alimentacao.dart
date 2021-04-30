import 'package:dia_vision/app/shared/utils/date_utils.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'paciente.dart';

const kTipo = "tipo";
const kCalorias = "calorias";
const keyPaciente = 'paciente';

const kAlimentacaoTable = "Alimentacao";

enum MealType { CAFE, ALMOCO, JANTAR, LANCHE }

extension MealTypeExtension on MealType {
  String get name => this.toString().replaceAll('MealType.', '');

  String get displayTitle {
    switch (this) {
      case MealType.CAFE:
        return 'Café da manhã';
      case MealType.ALMOCO:
        return 'Almoço';
      case MealType.JANTAR:
        return 'Jantar';
      case MealType.LANCHE:
        return 'Lanche';
      default:
        return null;
    }
  }
}

class Alimentacao extends ParseObject with DateUtils implements ParseCloneable {
  Alimentacao({
    String tipo,
    num calorias,
    Paciente paciente,
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

  Paciente get paciente =>
      Paciente.clone()..fromJson(get<ParseObject>(keyPaciente)?.toJson());
  set paciente(Paciente paciente) => set(keyPaciente, paciente);

  set createdAt(DateTime data) => set<DateTime>("createdAt", data);

  String get tipo => get<String>(kTipo);
  set tipo(String tipo) => set<String>(kTipo, tipo);

  num get calorias => get<num>(kCalorias);
  set calorias(num calorias) => set<num>(kCalorias, calorias);

  Map<String, dynamic> toMap() => <String, dynamic>{
        'Data de registro': getDataBrFromDate(createdAt) ?? "",
        'Calorias': calorias ?? "",
        'Tipo': tipo ?? "",
      };
}
