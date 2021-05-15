// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alimento_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AlimentoController on _AlimentoControllerBase, Store {
  final _$nomeControllerAtom =
      Atom(name: '_AlimentoControllerBase.nomeController');

  @override
  TextEditingController get nomeController {
    _$nomeControllerAtom.reportRead();
    return super.nomeController;
  }

  @override
  set nomeController(TextEditingController value) {
    _$nomeControllerAtom.reportWrite(value, super.nomeController, () {
      super.nomeController = value;
    });
  }

  final _$marcaControllerAtom =
      Atom(name: '_AlimentoControllerBase.marcaController');

  @override
  TextEditingController get marcaController {
    _$marcaControllerAtom.reportRead();
    return super.marcaController;
  }

  @override
  set marcaController(TextEditingController value) {
    _$marcaControllerAtom.reportWrite(value, super.marcaController, () {
      super.marcaController = value;
    });
  }

  final _$caloriasControllerAtom =
      Atom(name: '_AlimentoControllerBase.caloriasController');

  @override
  TextEditingController get caloriasController {
    _$caloriasControllerAtom.reportRead();
    return super.caloriasController;
  }

  @override
  set caloriasController(TextEditingController value) {
    _$caloriasControllerAtom.reportWrite(value, super.caloriasController, () {
      super.caloriasController = value;
    });
  }

  final _$porcaoConsumidaControllerAtom =
      Atom(name: '_AlimentoControllerBase.porcaoConsumidaController');

  @override
  TextEditingController get porcaoConsumidaController {
    _$porcaoConsumidaControllerAtom.reportRead();
    return super.porcaoConsumidaController;
  }

  @override
  set porcaoConsumidaController(TextEditingController value) {
    _$porcaoConsumidaControllerAtom
        .reportWrite(value, super.porcaoConsumidaController, () {
      super.porcaoConsumidaController = value;
    });
  }

  final _$medidaControllerAtom =
      Atom(name: '_AlimentoControllerBase.medidaController');

  @override
  TextEditingController get medidaController {
    _$medidaControllerAtom.reportRead();
    return super.medidaController;
  }

  @override
  set medidaController(TextEditingController value) {
    _$medidaControllerAtom.reportWrite(value, super.medidaController, () {
      super.medidaController = value;
    });
  }

  final _$nomeAtom = Atom(name: '_AlimentoControllerBase.nome');

  @override
  String get nome {
    _$nomeAtom.reportRead();
    return super.nome;
  }

  @override
  set nome(String value) {
    _$nomeAtom.reportWrite(value, super.nome, () {
      super.nome = value;
    });
  }

  final _$marcaAtom = Atom(name: '_AlimentoControllerBase.marca');

  @override
  String get marca {
    _$marcaAtom.reportRead();
    return super.marca;
  }

  @override
  set marca(String value) {
    _$marcaAtom.reportWrite(value, super.marca, () {
      super.marca = value;
    });
  }

  final _$medidaAtom = Atom(name: '_AlimentoControllerBase.medida');

  @override
  String get medida {
    _$medidaAtom.reportRead();
    return super.medida;
  }

  @override
  set medida(String value) {
    _$medidaAtom.reportWrite(value, super.medida, () {
      super.medida = value;
    });
  }

  final _$caloriasAtom = Atom(name: '_AlimentoControllerBase.calorias');

  @override
  String get calorias {
    _$caloriasAtom.reportRead();
    return super.calorias;
  }

  @override
  set calorias(String value) {
    _$caloriasAtom.reportWrite(value, super.calorias, () {
      super.calorias = value;
    });
  }

  final _$porcaoConsumidaAtom =
      Atom(name: '_AlimentoControllerBase.porcaoConsumida');

  @override
  String get porcaoConsumida {
    _$porcaoConsumidaAtom.reportRead();
    return super.porcaoConsumida;
  }

  @override
  set porcaoConsumida(String value) {
    _$porcaoConsumidaAtom.reportWrite(value, super.porcaoConsumida, () {
      super.porcaoConsumida = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_AlimentoControllerBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$isDataReadyAtom = Atom(name: '_AlimentoControllerBase.isDataReady');

  @override
  bool get isDataReady {
    _$isDataReadyAtom.reportRead();
    return super.isDataReady;
  }

  @override
  set isDataReady(bool value) {
    _$isDataReadyAtom.reportWrite(value, super.isDataReady, () {
      super.isDataReady = value;
    });
  }

  final _$alimentosAtom = Atom(name: '_AlimentoControllerBase.alimentos');

  @override
  ObservableList<Alimento> get alimentos {
    _$alimentosAtom.reportRead();
    return super.alimentos;
  }

  @override
  set alimentos(ObservableList<Alimento> value) {
    _$alimentosAtom.reportWrite(value, super.alimentos, () {
      super.alimentos = value;
    });
  }

  final _$alimentosAPIAtom = Atom(name: '_AlimentoControllerBase.alimentosAPI');

  @override
  ObservableList<Alimento> get alimentosAPI {
    _$alimentosAPIAtom.reportRead();
    return super.alimentosAPI;
  }

  @override
  set alimentosAPI(ObservableList<Alimento> value) {
    _$alimentosAPIAtom.reportWrite(value, super.alimentosAPI, () {
      super.alimentosAPI = value;
    });
  }

  final _$_AlimentoControllerBaseActionController =
      ActionController(name: '_AlimentoControllerBase');

  @override
  void setNome(String newValue) {
    final _$actionInfo = _$_AlimentoControllerBaseActionController.startAction(
        name: '_AlimentoControllerBase.setNome');
    try {
      return super.setNome(newValue);
    } finally {
      _$_AlimentoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMarca(String newValue) {
    final _$actionInfo = _$_AlimentoControllerBaseActionController.startAction(
        name: '_AlimentoControllerBase.setMarca');
    try {
      return super.setMarca(newValue);
    } finally {
      _$_AlimentoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMedida(String newValue) {
    final _$actionInfo = _$_AlimentoControllerBaseActionController.startAction(
        name: '_AlimentoControllerBase.setMedida');
    try {
      return super.setMedida(newValue);
    } finally {
      _$_AlimentoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCalorias(String newValue) {
    final _$actionInfo = _$_AlimentoControllerBaseActionController.startAction(
        name: '_AlimentoControllerBase.setCalorias');
    try {
      return super.setCalorias(newValue);
    } finally {
      _$_AlimentoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPorcaoConsumida(String newValue) {
    final _$actionInfo = _$_AlimentoControllerBaseActionController.startAction(
        name: '_AlimentoControllerBase.setPorcaoConsumida');
    try {
      return super.setPorcaoConsumida(newValue);
    } finally {
      _$_AlimentoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
nomeController: ${nomeController},
marcaController: ${marcaController},
caloriasController: ${caloriasController},
porcaoConsumidaController: ${porcaoConsumidaController},
medidaController: ${medidaController},
nome: ${nome},
marca: ${marca},
medida: ${medida},
calorias: ${calorias},
porcaoConsumida: ${porcaoConsumida},
isLoading: ${isLoading},
isDataReady: ${isDataReady},
alimentos: ${alimentos},
alimentosAPI: ${alimentosAPI}
    ''';
  }
}
