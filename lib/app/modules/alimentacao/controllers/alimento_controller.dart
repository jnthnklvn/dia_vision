import 'package:dia_vision/app/repositories/alimento_api_repository.dart';
import 'package:dia_vision/app/repositories/alimento_repository.dart';
import 'package:dia_vision/app/repositories/model/alimentacao.dart';
import 'package:dia_vision/app/repositories/model/alimento.dart';
import 'package:dia_vision/app/repositories/model/user.dart';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'alimento_controller.g.dart';

class AlimentoController = _AlimentoControllerBase with _$AlimentoController;

abstract class _AlimentoControllerBase with Store {
  final AlimentoAPIRepository _alimentoAPIRepository;
  final AlimentoRepository _alimentoRepository;

  @observable
  var nomeController = TextEditingController();
  @observable
  var marcaController = TextEditingController();
  @observable
  var caloriasController = TextEditingController();
  @observable
  var porcaoConsumidaController = TextEditingController();
  @observable
  var medidaController = TextEditingController();

  _AlimentoControllerBase(
    this._alimentoAPIRepository,
    this._alimentoRepository,
  );

  @observable
  String? nome;
  @observable
  String? marca;
  @observable
  String? medida;
  @observable
  String? calorias;
  @observable
  String? porcaoConsumida;

  num count = 0;

  @action
  void setNome(String? newValue) => nome = newValue;
  @action
  void setMarca(String? newValue) => marca = newValue;
  @action
  void setMedida(String? newValue) => medida = newValue;
  @action
  void setCalorias(String? newValue) => calorias = newValue;
  @action
  void setPorcaoConsumida(String? newValue) => porcaoConsumida = newValue;

  List<Alimento> alimentosToRemove = <Alimento>[];

  @observable
  bool isLoading = false;
  @observable
  bool isDataReady = true;
  @observable
  ObservableList<Alimento> alimentos = ObservableList<Alimento>();
  @observable
  ObservableList<Alimento> alimentosAPI = ObservableList<Alimento>();

  void init(Alimento? alimento) {
    if (alimento != null) {
      setNome(alimento.nome);
      setMarca(alimento.marca);
      setMedida(alimento.medida);
      setCalorias(alimento.calorias?.toString());
      setPorcaoConsumida(alimento.porcaoConsumida?.toString());
      nomeController = TextEditingController(text: nome);
      marcaController = TextEditingController(text: marca);
      medidaController = TextEditingController(text: medida);
      caloriasController = TextEditingController(text: calorias);
      porcaoConsumidaController = TextEditingController(text: porcaoConsumida);
    }
  }

  String? getFirtString(String? str) {
    final list = str?.split(' ');
    return list?.isNotEmpty == true ? list![0] : null;
  }

  bool addAlimento(Function(String) onError) {
    if (nome != null && calorias != null) {
      final caloriasNum = num.tryParse(calorias!.replaceAll(',', '.'));
      final porcaoConsumidaNum = porcaoConsumida != null
          ? num.tryParse(porcaoConsumida!.replaceAll(',', '.'))
          : null;
      final porcao = num.tryParse(getFirtString(medida) ?? '');
      num? caloriasConsumidas;
      if (caloriasNum != null && porcaoConsumidaNum != null && porcao != null) {
        caloriasConsumidas = (porcaoConsumidaNum * caloriasNum) / porcao;
      }
      caloriasConsumidas ??= caloriasNum;
      alimentos.add(Alimento(
        calorias: caloriasNum,
        nome: nome,
        marca: marca,
        medida: medida,
        porcaoConsumida: porcaoConsumidaNum,
        caloriasConsumidas: caloriasConsumidas,
      ));
      init(Alimento());
      return true;
    } else {
      onError("Nome e calorias são obrigatórios");
      return false;
    }
  }

  Future<void> removerAlimentos() async {
    for (var alimento in alimentosToRemove) {
      await alimento.delete();
    }
    alimentosToRemove = <Alimento>[];
  }

  void salvarAlimentos(Alimentacao alimentacao, User user) {
    for (var alimento in alimentos) {
      alimento.alimentacao = alimentacao;
      _alimentoRepository.save(alimento, user);
    }

    alimentos = ObservableList<Alimento>();
  }

  void removerAlimento(String nome, String marca) {
    final alimentosToRemoveAux = alimentos.where(
      (e) => e.nome == nome && e.marca == marca,
    );
    if (alimentosToRemoveAux.isNotEmpty) {
      alimentosToRemove.add(alimentosToRemoveAux.first);
      alimentos.remove(alimentosToRemoveAux.first);
    }
  }

  Future<void> getData(
      Function(String) onError, Alimentacao alimentacao) async {
    isDataReady = false;
    try {
      final result = await _alimentoRepository.getAllByAlimentacao(alimentacao);
      result.fold((l) => onError(l.message), (r) {
        alimentos = (r).asObservable();
      });
    } catch (e) {
      onError(e.toString());
      isDataReady = true;
    }
    isDataReady = true;
  }

  Future<void> searchAPI(Function(String) onError, String search) async {
    isLoading = true;
    try {
      final result = await _alimentoAPIRepository.getAlimentos(search);
      result.fold((l) => onError(l.message), (r) {
        r.removeWhere((e) => e.codigoPais != "BR");
        alimentosAPI = (r).asObservable();
      });
      isLoading = false;
    } catch (e) {
      onError(e.toString());
      isLoading = false;
    }
  }
}
