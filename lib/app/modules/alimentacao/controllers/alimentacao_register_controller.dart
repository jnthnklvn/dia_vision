import 'package:dia_vision/app/model/alimento.dart';
import 'package:dia_vision/app/repositories/alimentacao_repository.dart';
import 'package:dia_vision/app/model/alimentacao.dart';
import 'package:dia_vision/app/app_controller.dart';

import 'package:mobx/mobx.dart';

import 'alimentacao_controller.dart';
import 'alimento_controller.dart';

part 'alimentacao_register_controller.g.dart';

class AlimentacaoRegisterController = _AlimentacaoRegisterControllerBase
    with _$AlimentacaoRegisterController;

abstract class _AlimentacaoRegisterControllerBase with Store {
  final IAlimentacaoRepository _alimentacaoRepository;
  final AlimentacaoController _alimentacaoController;
  final AlimentoController _alimentoController;
  final AppController _appController;

  _AlimentacaoRegisterControllerBase(
    this._alimentacaoRepository,
    this._alimentacaoController,
    this._alimentoController,
    this._appController,
  );

  @observable
  String tipo;
  @observable
  String calorias;

  Alimentacao _alimentacao;

  @computed
  bool get isEdicao => _alimentacao != null;

  @observable
  bool isLoading = false;

  @action
  void setTipo(String newValue) => tipo = newValue;
  @action
  void setCalorias(String newValue) => calorias = newValue;

  void init(Alimentacao alimentacao, Function(String) onError) {
    _alimentoController.alimentos = ObservableList<Alimento>();
    _alimentacao = alimentacao;
    if (alimentacao != null) {
      _alimentoController.getData(onError, alimentacao);
      setTipo(alimentacao.tipo);
      setCalorias(alimentacao.calorias?.toString());
    }
  }

  Future<void> save(Function(String) onError, void Function() onSuccess) async {
    isLoading = true;

    try {
      final alimentacao = Alimentacao(
        tipo: tipo,
      );
      alimentacao.objectId = _alimentacao?.objectId;
      final user = await _appController.currentUser();
      alimentacao.paciente = user.paciente;

      _alimentoController.removerAlimentos();

      if (this.calorias != null)
        alimentacao.calorias = num.tryParse(calorias.replaceAll(',', '.'));

      final result = await _alimentacaoRepository.save(alimentacao, user);
      result.fold((l) => onError(l.message), (r) {
        final idx = _alimentacaoController.alimentacoes
            .indexWhere((e) => e.objectId == r.objectId);
        if (idx == -1) {
          _alimentacaoController.alimentacoes.insert(0, r);
        } else {
          r.createdAt = _alimentacaoController.alimentacoes[idx].createdAt;
          _alimentacaoController.alimentacoes[idx] = r;
        }
        _alimentoController.salvarAlimentos(alimentacao, user);
        onSuccess();
      });
    } catch (e) {
      onError(e.toString());
    }

    isLoading = false;
  }
}
