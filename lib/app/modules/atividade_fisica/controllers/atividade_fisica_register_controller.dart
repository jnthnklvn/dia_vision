import 'package:dia_vision/app/repositories/atividade_fisica_repository.dart';
import 'package:dia_vision/app/model/atividade_fisica.dart';
import 'package:dia_vision/app/app_controller.dart';

import 'package:mobx/mobx.dart';

import 'atividade_fisica_controller.dart';

part 'atividade_fisica_register_controller.g.dart';

class AtividadeFisicaRegisterController = _AtividadeFisicaRegisterControllerBase
    with _$AtividadeFisicaRegisterController;

abstract class _AtividadeFisicaRegisterControllerBase with Store {
  final IAtividadeFisicaRepository _atividadeFisicaRepository;
  final AtividadeFisicaController _atividadeFisicaController;
  final AppController _appController;

  _AtividadeFisicaRegisterControllerBase(
    this._atividadeFisicaRepository,
    this._atividadeFisicaController,
    this._appController,
  );

  @observable
  String tipo;
  @observable
  String tipo2;
  @observable
  String duracao;
  @observable
  String distancia;

  AtividadeFisica _atividadeFisica;

  @computed
  bool get isEdicao => _atividadeFisica != null;

  @observable
  bool isLoading = false;

  @action
  void setTipo(String newValue) => tipo = newValue;
  @action
  void setTipo2(String newValue) => tipo2 = newValue;
  @action
  void setDuracao(String newValue) => duracao = newValue;
  @action
  void setDistancia(String newValue) => distancia = newValue;

  void init(AtividadeFisica atividadeFisica) {
    _atividadeFisica = atividadeFisica;
    if (atividadeFisica != null) {
      setTipo(ExerciseType.values
          .firstWhere(
            (e) => e.name == atividadeFisica.tipo,
            orElse: () => ExerciseType.Outro,
          )
          ?.name);
      setTipo2(atividadeFisica.tipo);
      setDuracao(atividadeFisica.duracao?.toString());
      setDistancia(atividadeFisica.distancia?.toString());
    }
  }

  Future<void> save(Function(String) onError, void Function() onSuccess) async {
    isLoading = true;

    try {
      final atividadeFisica = AtividadeFisica(
        tipo: tipo == ExerciseType.Outro.name && tipo2?.isNotEmpty == true
            ? tipo2
            : tipo,
      );
      atividadeFisica.objectId = _atividadeFisica?.objectId;
      final user = await _appController.currentUser();
      atividadeFisica.paciente = user.paciente;

      if (this.distancia != null && tipo != ExerciseType.Outro.name)
        atividadeFisica.distancia =
            num.tryParse(distancia.replaceAll(',', '.'));
      if (this.duracao != null)
        atividadeFisica.duracao = num.tryParse(duracao.replaceAll(',', '.'));

      final result =
          await _atividadeFisicaRepository.save(atividadeFisica, user);
      result.fold((l) => onError(l.message), (r) {
        final idx = _atividadeFisicaController.atividades
            .indexWhere((e) => e.objectId == r.objectId);
        if (idx == -1) {
          _atividadeFisicaController.atividades.insert(0, r);
        } else {
          r.createdAt = _atividadeFisicaController.atividades[idx].createdAt;
          _atividadeFisicaController.atividades[idx] = r;
        }
        onSuccess();
      });
    } catch (e) {
      onError(e.toString());
    }

    isLoading = false;
  }
}
