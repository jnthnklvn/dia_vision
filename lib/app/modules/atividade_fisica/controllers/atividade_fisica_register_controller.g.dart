// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'atividade_fisica_register_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AtividadeFisicaRegisterController
    on _AtividadeFisicaRegisterControllerBase, Store {
  Computed<bool> _$isEdicaoComputed;

  @override
  bool get isEdicao =>
      (_$isEdicaoComputed ??= Computed<bool>(() => super.isEdicao,
              name: '_AtividadeFisicaRegisterControllerBase.isEdicao'))
          .value;

  final _$tipoAtom = Atom(name: '_AtividadeFisicaRegisterControllerBase.tipo');

  @override
  String get tipo {
    _$tipoAtom.reportRead();
    return super.tipo;
  }

  @override
  set tipo(String value) {
    _$tipoAtom.reportWrite(value, super.tipo, () {
      super.tipo = value;
    });
  }

  final _$tipo2Atom =
      Atom(name: '_AtividadeFisicaRegisterControllerBase.tipo2');

  @override
  String get tipo2 {
    _$tipo2Atom.reportRead();
    return super.tipo2;
  }

  @override
  set tipo2(String value) {
    _$tipo2Atom.reportWrite(value, super.tipo2, () {
      super.tipo2 = value;
    });
  }

  final _$duracaoAtom =
      Atom(name: '_AtividadeFisicaRegisterControllerBase.duracao');

  @override
  String get duracao {
    _$duracaoAtom.reportRead();
    return super.duracao;
  }

  @override
  set duracao(String value) {
    _$duracaoAtom.reportWrite(value, super.duracao, () {
      super.duracao = value;
    });
  }

  final _$distanciaAtom =
      Atom(name: '_AtividadeFisicaRegisterControllerBase.distancia');

  @override
  String get distancia {
    _$distanciaAtom.reportRead();
    return super.distancia;
  }

  @override
  set distancia(String value) {
    _$distanciaAtom.reportWrite(value, super.distancia, () {
      super.distancia = value;
    });
  }

  final _$isLoadingAtom =
      Atom(name: '_AtividadeFisicaRegisterControllerBase.isLoading');

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

  final _$_AtividadeFisicaRegisterControllerBaseActionController =
      ActionController(name: '_AtividadeFisicaRegisterControllerBase');

  @override
  void setTipo(String newValue) {
    final _$actionInfo =
        _$_AtividadeFisicaRegisterControllerBaseActionController.startAction(
            name: '_AtividadeFisicaRegisterControllerBase.setTipo');
    try {
      return super.setTipo(newValue);
    } finally {
      _$_AtividadeFisicaRegisterControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setTipo2(String newValue) {
    final _$actionInfo =
        _$_AtividadeFisicaRegisterControllerBaseActionController.startAction(
            name: '_AtividadeFisicaRegisterControllerBase.setTipo2');
    try {
      return super.setTipo2(newValue);
    } finally {
      _$_AtividadeFisicaRegisterControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setDuracao(String newValue) {
    final _$actionInfo =
        _$_AtividadeFisicaRegisterControllerBaseActionController.startAction(
            name: '_AtividadeFisicaRegisterControllerBase.setDuracao');
    try {
      return super.setDuracao(newValue);
    } finally {
      _$_AtividadeFisicaRegisterControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setDistancia(String newValue) {
    final _$actionInfo =
        _$_AtividadeFisicaRegisterControllerBaseActionController.startAction(
            name: '_AtividadeFisicaRegisterControllerBase.setDistancia');
    try {
      return super.setDistancia(newValue);
    } finally {
      _$_AtividadeFisicaRegisterControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
tipo: ${tipo},
tipo2: ${tipo2},
duracao: ${duracao},
distancia: ${distancia},
isLoading: ${isLoading},
isEdicao: ${isEdicao}
    ''';
  }
}
