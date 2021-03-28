import 'package:dia_vision/app/shared/utils/date_utils.dart';
import 'package:dia_vision/app/model/paciente.dart';

import 'package:parse_server_sdk/parse_server_sdk.dart';

const kUsaProtetorSolarPes = "usaProtetorSolarPes";
const kDataUltimaConsulta = "dataUltimaConsulta";
const kTemperaturaLavagem = "temperaturaLavagem";
const kChecaAntesCalcar = "checaAntesCalcar";
const kPontosVermelhos = 'pontosVermelhos';
const kRachaduras = "rachaduras";
const kHidratados = "hidratados";
const kCortaUnhas = "cortaUnhas";
const keyPaciente = 'paciente';
const kCalos = "calos";
const kSecou = "secou";
const kLavou = "lavou";
const kAvaliacaoPesTable = "AvaliacaoPes";

class AvaliacaoPes extends ParseObject
    with DateUtils
    implements ParseCloneable {
  AvaliacaoPes(
      {bool usaProtetorSolarPes,
      DateTime dataUltimaConsulta,
      String temperaturaLavagem,
      bool checaAntesCalcar,
      bool pontosVermelhos,
      bool rachaduras,
      bool hidratados,
      bool cortaUnhas,
      Paciente paciente,
      bool calos,
      bool lavou,
      bool secou})
      : super(kAvaliacaoPesTable) {
    this.usaProtetorSolarPes = usaProtetorSolarPes;
    this.dataUltimaConsulta = dataUltimaConsulta;
    this.temperaturaLavagem = temperaturaLavagem;
    this.checaAntesCalcar = checaAntesCalcar;
    this.pontosVermelhos = pontosVermelhos;
    this.rachaduras = rachaduras;
    this.hidratados = hidratados;
    this.cortaUnhas = cortaUnhas;
    this.paciente = paciente;
    this.calos = calos;
    this.lavou = lavou;
    this.secou = secou;
  }

  AvaliacaoPes.clone() : this();

  @override
  AvaliacaoPes clone(Map<String, dynamic> map) =>
      AvaliacaoPes.clone()..fromJson(map);

  @override
  AvaliacaoPes fromJson(Map<String, dynamic> objectData) {
    super.fromJson(objectData);
    return this;
  }

  DateTime get dataUltimaConsulta => get<DateTime>(kDataUltimaConsulta);
  set dataUltimaConsulta(DateTime dataUltimaConsulta) =>
      set<DateTime>(kDataUltimaConsulta, dataUltimaConsulta);

  set createdAt(DateTime data) => set<DateTime>("createdAt", data);

  bool get cortaUnhas => get<bool>(kCortaUnhas);
  set cortaUnhas(bool cortaUnhas) => set<bool>(kCortaUnhas, cortaUnhas);

  bool get usaProtetorSolarPes => get<bool>(kUsaProtetorSolarPes);
  set usaProtetorSolarPes(bool usaProtetorSolarPes) =>
      set<bool>(kUsaProtetorSolarPes, usaProtetorSolarPes);

  bool get checaAntesCalcar => get<bool>(kChecaAntesCalcar);
  set checaAntesCalcar(bool checaAntesCalcar) =>
      set<bool>(kChecaAntesCalcar, checaAntesCalcar);

  bool get pontosVermelhos => get<bool>(kPontosVermelhos);
  set pontosVermelhos(bool pontosVermelhos) =>
      set<bool>(kPontosVermelhos, pontosVermelhos);

  bool get lavou => get<bool>(kLavou);
  set lavou(bool lavou) => set<bool>(kLavou, lavou);

  bool get secou => get<bool>(kSecou);
  set secou(bool secou) => set<bool>(kSecou, secou);

  bool get calos => get<bool>(kCalos);
  set calos(bool calos) => set<bool>(kCalos, calos);

  bool get hidratados => get<bool>(kHidratados);
  set hidratados(bool hidratados) => set<bool>(kHidratados, hidratados);

  String get temperaturaLavagem => get<String>(kTemperaturaLavagem);
  set temperaturaLavagem(String temperaturaLavagem) =>
      set<String>(kTemperaturaLavagem, temperaturaLavagem);

  bool get rachaduras => get<bool>(kRachaduras);
  set rachaduras(bool rachaduras) => set<bool>(kRachaduras, rachaduras);

  Paciente get paciente =>
      Paciente.clone()..fromJson(get<ParseObject>(keyPaciente)?.toJson());
  set paciente(Paciente paciente) => set(keyPaciente, paciente);

  Map<String, dynamic> toMap() => <String, dynamic>{
        'Data de registro': getDataBrFromDate(createdAt) ?? "",
        'Usa protetor solar nos pes': usaProtetorSolarPes != null
            ? (usaProtetorSolarPes ? "Sim" : "Não")
            : "",
        'Data última consulta': dataUltimaConsulta != null
            ? getDataBrFromDate(dataUltimaConsulta)
            : "",
        'Temperatura lavagem': temperaturaLavagem ?? "",
        'Checa sapatos antes de calçar':
            checaAntesCalcar != null ? (checaAntesCalcar ? "Sim" : "Não") : "",
        'Pontos vermelhos':
            pontosVermelhos != null ? (pontosVermelhos ? "Sim" : "Não") : "",
        'Rachaduras': rachaduras != null ? (rachaduras ? "Sim" : "Não") : "",
        'Hidratados': hidratados != null ? (hidratados ? "Sim" : "Não") : "",
        'Corta unhas': cortaUnhas != null ? (cortaUnhas ? "Sim" : "Não") : "",
        'Calos': calos != null ? (calos ? "Sim" : "Não") : "",
        'Secou': secou != null ? (secou ? "Sim" : "Não") : "",
        'Lavou': lavou != null ? (lavou ? "Sim" : "Não") : "",
      };
}
