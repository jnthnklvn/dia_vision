import 'package:dia_vision/app/repositories/avaliacao_pes_repository.dart';
import 'package:dia_vision/app/shared/utils/date_utils.dart';
import 'package:dia_vision/app/model/avaliacao_pes.dart';
import 'package:dia_vision/app/app_controller.dart';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:mobx/mobx.dart';

import 'avaliacao_pes_controller.dart';

part 'avaliacao_pes_register_controller.g.dart';

class AvaliacaoPesRegisterController = _AvaliacaoPesRegisterControllerBase
    with _$AvaliacaoPesRegisterController;

abstract class _AvaliacaoPesRegisterControllerBase with Store, DateUtils {
  final IAvaliacaoPesRepository _avaliacaoPesRepository;
  final AvaliacaoPesController _pesController;
  final AppController _appController;

  _AvaliacaoPesRegisterControllerBase(
    this._avaliacaoPesRepository,
    this._pesController,
    this._appController,
  );

  @observable
  bool usaProtetorSolarPes = false;
  @observable
  String dataUltimaConsulta;
  @observable
  String temperaturaLavagem;
  @observable
  bool checaAntesCalcar = false;
  @observable
  bool pontosVermelhos = false;
  @observable
  bool rachaduras = false;
  @observable
  bool hidratados = false;
  @observable
  bool cortaUnhas = false;
  @observable
  bool calos = false;
  @observable
  bool lavou = false;
  @observable
  bool secou = false;

  @observable
  bool isLoading = false;
  @observable
  List<AvaliacaoPes> avaliacoes = [];

  AvaliacaoPes _avaliacaoPes;

  @computed
  bool get isEdicao => _avaliacaoPes != null;

  @action
  void setUsaProtetorSolarPes(bool newValue) => usaProtetorSolarPes = newValue;
  @action
  void setDataUltimaConsulta(String newValue) => dataUltimaConsulta = newValue;
  @action
  void setTemperaturaLavagem(String newValue) => temperaturaLavagem = newValue;
  @action
  void setChecaAntesCalcar(bool newValue) => checaAntesCalcar = newValue;
  @action
  void setPontosVermelhos(bool newValue) => pontosVermelhos = newValue;
  @action
  void setRachaduras(bool newValue) => rachaduras = newValue;
  @action
  void setHidratados(bool newValue) => hidratados = newValue;
  @action
  void setCortaUnhas(bool newValue) => cortaUnhas = newValue;
  @action
  void setCalos(bool newValue) => calos = newValue;
  @action
  void setLavou(bool newValue) => lavou = newValue;
  @action
  void setSecou(bool newValue) => secou = newValue;

  void init(AvaliacaoPes avaliacao) {
    _avaliacaoPes = avaliacao;
    if (avaliacao != null) {
      setUsaProtetorSolarPes(avaliacao.usaProtetorSolarPes);
      setTemperaturaLavagem(avaliacao.temperaturaLavagem);
      setChecaAntesCalcar(avaliacao.checaAntesCalcar);
      setPontosVermelhos(avaliacao.pontosVermelhos);
      setRachaduras(avaliacao.rachaduras);
      setHidratados(avaliacao.hidratados);
      setCortaUnhas(avaliacao.cortaUnhas);
      setCalos(avaliacao.calos);
      setLavou(avaliacao.lavou);
      setSecou(avaliacao.secou);

      if (avaliacao.dataUltimaConsulta != null)
        setDataUltimaConsulta(
            UtilData.obterDataDDMMAAAA(avaliacao.dataUltimaConsulta));
    }
  }

  Future<void> save(Function(String) onError, void Function() onSuccess) async {
    isLoading = true;

    try {
      final avaliacaoPes = AvaliacaoPes(
        usaProtetorSolarPes: usaProtetorSolarPes,
        checaAntesCalcar: checaAntesCalcar,
        pontosVermelhos: pontosVermelhos,
        rachaduras: rachaduras,
        hidratados: hidratados,
        cortaUnhas: cortaUnhas,
        calos: calos,
        lavou: lavou,
        secou: secou,
      );

      final user = await _appController.currentUser();
      avaliacaoPes.paciente = user.paciente;
      avaliacaoPes.objectId = _avaliacaoPes?.objectId;
      avaliacaoPes.temperaturaLavagem = temperaturaLavagem;

      final dDataUltimaConsulta =
          dataUltimaConsulta != null ? getDateTime(dataUltimaConsulta) : null;
      if (dataUltimaConsulta != null)
        avaliacaoPes.dataUltimaConsulta = dDataUltimaConsulta;

      final result = await _avaliacaoPesRepository.save(avaliacaoPes, user);
      result.fold((l) => onError(l.message), (r) {
        final idx = _pesController.avaliacoes
            .indexWhere((e) => e.objectId == r.objectId);
        if (idx == -1) {
          _pesController.avaliacoes.insert(0, r);
        } else {
          r.createdAt = _pesController.avaliacoes[idx].createdAt;
          _pesController.avaliacoes[idx] = r;
        }
        onSuccess();
      });
    } catch (e) {
      onError(e.toString());
    }

    isLoading = false;
  }
}
