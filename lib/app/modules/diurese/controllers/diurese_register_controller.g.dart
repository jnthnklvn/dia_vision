// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diurese_register_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DiureseRegisterController on _DiureseRegisterControllerBase, Store {
  Computed<bool>? _$isEdicaoComputed;

  @override
  bool get isEdicao =>
      (_$isEdicaoComputed ??= Computed<bool>(() => super.isEdicao,
              name: '_DiureseRegisterControllerBase.isEdicao'))
          .value;

  final _$coloracaoAtom =
      Atom(name: '_DiureseRegisterControllerBase.coloracao');

  @override
  String? get coloracao {
    _$coloracaoAtom.reportRead();
    return super.coloracao;
  }

  @override
  set coloracao(String? value) {
    _$coloracaoAtom.reportWrite(value, super.coloracao, () {
      super.coloracao = value;
    });
  }

  final _$volumeAtom = Atom(name: '_DiureseRegisterControllerBase.volume');

  @override
  String? get volume {
    _$volumeAtom.reportRead();
    return super.volume;
  }

  @override
  set volume(String? value) {
    _$volumeAtom.reportWrite(value, super.volume, () {
      super.volume = value;
    });
  }

  final _$ardorAtom = Atom(name: '_DiureseRegisterControllerBase.ardor');

  @override
  bool get ardor {
    _$ardorAtom.reportRead();
    return super.ardor;
  }

  @override
  set ardor(bool value) {
    _$ardorAtom.reportWrite(value, super.ardor, () {
      super.ardor = value;
    });
  }

  final _$isLoadingAtom =
      Atom(name: '_DiureseRegisterControllerBase.isLoading');

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

  final _$diuresesAtom = Atom(name: '_DiureseRegisterControllerBase.diureses');

  @override
  List<Diurese> get diureses {
    _$diuresesAtom.reportRead();
    return super.diureses;
  }

  @override
  set diureses(List<Diurese> value) {
    _$diuresesAtom.reportWrite(value, super.diureses, () {
      super.diureses = value;
    });
  }

  final _$_DiureseRegisterControllerBaseActionController =
      ActionController(name: '_DiureseRegisterControllerBase');

  @override
  void setColoracao(String? newValue) {
    final _$actionInfo = _$_DiureseRegisterControllerBaseActionController
        .startAction(name: '_DiureseRegisterControllerBase.setColoracao');
    try {
      return super.setColoracao(newValue);
    } finally {
      _$_DiureseRegisterControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setVolume(String? newValue) {
    final _$actionInfo = _$_DiureseRegisterControllerBaseActionController
        .startAction(name: '_DiureseRegisterControllerBase.setVolume');
    try {
      return super.setVolume(newValue);
    } finally {
      _$_DiureseRegisterControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setArdor(bool newValue) {
    final _$actionInfo = _$_DiureseRegisterControllerBaseActionController
        .startAction(name: '_DiureseRegisterControllerBase.setArdor');
    try {
      return super.setArdor(newValue);
    } finally {
      _$_DiureseRegisterControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
coloracao: ${coloracao},
volume: ${volume},
ardor: ${ardor},
isLoading: ${isLoading},
diureses: ${diureses},
isEdicao: ${isEdicao}
    ''';
  }
}
