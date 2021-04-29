// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alimentacao_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AlimentacaoController on _AlimentacaoControllerBase, Store {
  final _$isLoadingAtom = Atom(name: '_AlimentacaoControllerBase.isLoading');

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

  final _$alimentacoesAtom =
      Atom(name: '_AlimentacaoControllerBase.alimentacoes');

  @override
  ObservableList<Alimentacao> get alimentacoes {
    _$alimentacoesAtom.reportRead();
    return super.alimentacoes;
  }

  @override
  set alimentacoes(ObservableList<Alimentacao> value) {
    _$alimentacoesAtom.reportWrite(value, super.alimentacoes, () {
      super.alimentacoes = value;
    });
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
alimentacoes: ${alimentacoes}
    ''';
  }
}
