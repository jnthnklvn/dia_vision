// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'glicemia_register_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GlicemiaRegisterController on _GlicemiaRegisterControllerBase, Store {
  Computed<bool>? _$isEdicaoComputed;

  @override
  bool get isEdicao =>
      (_$isEdicaoComputed ??= Computed<bool>(() => super.isEdicao,
              name: '_GlicemiaRegisterControllerBase.isEdicao'))
          .value;

  final _$valorAtom = Atom(name: '_GlicemiaRegisterControllerBase.valor');

  @override
  String? get valor {
    _$valorAtom.reportRead();
    return super.valor;
  }

  @override
  set valor(String? value) {
    _$valorAtom.reportWrite(value, super.valor, () {
      super.valor = value;
    });
  }

  final _$horarioAtom = Atom(name: '_GlicemiaRegisterControllerBase.horario');

  @override
  String? get horario {
    _$horarioAtom.reportRead();
    return super.horario;
  }

  @override
  set horario(String? value) {
    _$horarioAtom.reportWrite(value, super.horario, () {
      super.horario = value;
    });
  }

  final _$horarioFixoAtom =
      Atom(name: '_GlicemiaRegisterControllerBase.horarioFixo');

  @override
  String? get horarioFixo {
    _$horarioFixoAtom.reportRead();
    return super.horarioFixo;
  }

  @override
  set horarioFixo(String? value) {
    _$horarioFixoAtom.reportWrite(value, super.horarioFixo, () {
      super.horarioFixo = value;
    });
  }

  final _$isLoadingAtom =
      Atom(name: '_GlicemiaRegisterControllerBase.isLoading');

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

  final _$isHipoGlicemiaAtom =
      Atom(name: '_GlicemiaRegisterControllerBase.isHipoGlicemia');

  @override
  bool get isHipoGlicemia {
    _$isHipoGlicemiaAtom.reportRead();
    return super.isHipoGlicemia;
  }

  @override
  set isHipoGlicemia(bool value) {
    _$isHipoGlicemiaAtom.reportWrite(value, super.isHipoGlicemia, () {
      super.isHipoGlicemia = value;
    });
  }

  final _$isHiperGlicemiaAtom =
      Atom(name: '_GlicemiaRegisterControllerBase.isHiperGlicemia');

  @override
  bool get isHiperGlicemia {
    _$isHiperGlicemiaAtom.reportRead();
    return super.isHiperGlicemia;
  }

  @override
  set isHiperGlicemia(bool value) {
    _$isHiperGlicemiaAtom.reportWrite(value, super.isHiperGlicemia, () {
      super.isHiperGlicemia = value;
    });
  }

  final _$glicemiasAtom =
      Atom(name: '_GlicemiaRegisterControllerBase.glicemias');

  @override
  List<Glicemia> get glicemias {
    _$glicemiasAtom.reportRead();
    return super.glicemias;
  }

  @override
  set glicemias(List<Glicemia> value) {
    _$glicemiasAtom.reportWrite(value, super.glicemias, () {
      super.glicemias = value;
    });
  }

  final _$_GlicemiaRegisterControllerBaseActionController =
      ActionController(name: '_GlicemiaRegisterControllerBase');

  @override
  void setValor(String? newValue) {
    final _$actionInfo = _$_GlicemiaRegisterControllerBaseActionController
        .startAction(name: '_GlicemiaRegisterControllerBase.setValor');
    try {
      return super.setValor(newValue);
    } finally {
      _$_GlicemiaRegisterControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHorario(String? newValue) {
    final _$actionInfo = _$_GlicemiaRegisterControllerBaseActionController
        .startAction(name: '_GlicemiaRegisterControllerBase.setHorario');
    try {
      return super.setHorario(newValue);
    } finally {
      _$_GlicemiaRegisterControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHorarioFixo(String? newValue) {
    final _$actionInfo = _$_GlicemiaRegisterControllerBaseActionController
        .startAction(name: '_GlicemiaRegisterControllerBase.setHorarioFixo');
    try {
      return super.setHorarioFixo(newValue);
    } finally {
      _$_GlicemiaRegisterControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
valor: ${valor},
horario: ${horario},
horarioFixo: ${horarioFixo},
isLoading: ${isLoading},
isHipoGlicemia: ${isHipoGlicemia},
isHiperGlicemia: ${isHiperGlicemia},
glicemias: ${glicemias},
isEdicao: ${isEdicao}
    ''';
  }
}
