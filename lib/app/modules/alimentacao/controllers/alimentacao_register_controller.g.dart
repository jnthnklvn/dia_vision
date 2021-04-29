// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alimentacao_register_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AlimentacaoRegisterController
    on _AlimentacaoRegisterControllerBase, Store {
  Computed<bool> _$isEdicaoComputed;

  @override
  bool get isEdicao =>
      (_$isEdicaoComputed ??= Computed<bool>(() => super.isEdicao,
              name: '_AlimentacaoRegisterControllerBase.isEdicao'))
          .value;

  final _$tipoAtom = Atom(name: '_AlimentacaoRegisterControllerBase.tipo');

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

  final _$caloriasAtom =
      Atom(name: '_AlimentacaoRegisterControllerBase.calorias');

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

  final _$isLoadingAtom =
      Atom(name: '_AlimentacaoRegisterControllerBase.isLoading');

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

  final _$_AlimentacaoRegisterControllerBaseActionController =
      ActionController(name: '_AlimentacaoRegisterControllerBase');

  @override
  void setTipo(String newValue) {
    final _$actionInfo = _$_AlimentacaoRegisterControllerBaseActionController
        .startAction(name: '_AlimentacaoRegisterControllerBase.setTipo');
    try {
      return super.setTipo(newValue);
    } finally {
      _$_AlimentacaoRegisterControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setCalorias(String newValue) {
    final _$actionInfo = _$_AlimentacaoRegisterControllerBaseActionController
        .startAction(name: '_AlimentacaoRegisterControllerBase.setCalorias');
    try {
      return super.setCalorias(newValue);
    } finally {
      _$_AlimentacaoRegisterControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
tipo: ${tipo},
calorias: ${calorias},
isLoading: ${isLoading},
isEdicao: ${isEdicao}
    ''';
  }
}
