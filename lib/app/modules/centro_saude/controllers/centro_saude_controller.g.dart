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

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
centros: ${centros}
    ''';
  }
}
