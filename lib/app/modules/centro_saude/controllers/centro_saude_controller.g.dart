// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'centro_saude_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CentroSaudeController on _CentroSaudeControllerBase, Store {
  final _$isLoadingAtom = Atom(name: '_CentroSaudeControllerBase.isLoading');

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

  final _$centrosAtom = Atom(name: '_CentroSaudeControllerBase.centros');

  @override
  ObservableList<CentroSaude> get centros {
    _$centrosAtom.reportRead();
    return super.centros;
  }

  @override
  set centros(ObservableList<CentroSaude> value) {
    _$centrosAtom.reportWrite(value, super.centros, () {
      super.centros = value;
    });
  }

  final _$tiposAtom = Atom(name: '_CentroSaudeControllerBase.tipos');

  @override
  ObservableSet<String?> get tipos {
    _$tiposAtom.reportRead();
    return super.tipos;
  }

  @override
  set tipos(ObservableSet<String?> value) {
    _$tiposAtom.reportWrite(value, super.tipos, () {
      super.tipos = value;
    });
  }

  final _$tipoAtom = Atom(name: '_CentroSaudeControllerBase.tipo');

  @override
  String? get tipo {
    _$tipoAtom.reportRead();
    return super.tipo;
  }

  @override
  set tipo(String? value) {
    _$tipoAtom.reportWrite(value, super.tipo, () {
      super.tipo = value;
    });
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
centros: ${centros},
tipos: ${tipos},
tipo: ${tipo}
    ''';
  }
}
