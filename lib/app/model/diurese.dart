import 'package:dia_vision/app/shared/utils/date_utils.dart';
import 'package:dia_vision/app/model/paciente.dart';

import 'package:parse_server_sdk/parse_server_sdk.dart';

const kVolume = "volume";
const kColoracao = "coloracao";
const keyPaciente = 'paciente';
const kArdor = "ardor";
const kDiureseTable = "Diurese";

class Diurese extends ParseObject with DateUtils implements ParseCloneable {
  Diurese({num volume, String coloracao, Paciente paciente, bool ardor})
      : super(kDiureseTable) {
    this.volume = volume;
    this.coloracao = coloracao;
    this.paciente = paciente;
    this.ardor = ardor;
  }

  Diurese.clone() : this();

  @override
  Diurese clone(Map<String, dynamic> map) => Diurese.clone()..fromJson(map);

  @override
  Diurese fromJson(Map<String, dynamic> objectData) {
    super.fromJson(objectData);
    return this;
  }

  set createdAt(DateTime data) => set<DateTime>("createdAt", data);

  bool get ardor => get<bool>(kArdor);
  set ardor(bool ardor) => set<bool>(kArdor, ardor);

  String get coloracao => get<String>(kColoracao);
  set coloracao(String coloracao) => set<String>(kColoracao, coloracao);

  num get volume => get<num>(kVolume);
  set volume(num volume) => set<num>(kVolume, volume);

  Paciente get paciente =>
      Paciente.clone()..fromJson(get<ParseObject>(keyPaciente)?.toJson());
  set paciente(Paciente paciente) => set(keyPaciente, paciente);

  Map<String, dynamic> toMap() => <String, dynamic>{
        'Volume': volume ?? "",
        'Coloração': coloracao ?? "",
        'Ardor': ardor != null ? (ardor ? "Sim" : "Não") : "",
      };
}
