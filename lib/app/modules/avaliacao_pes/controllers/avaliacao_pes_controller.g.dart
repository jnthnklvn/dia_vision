// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avaliacao_pes_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AvaliacaoPesController on _AvaliacaoPesControllerBase, Store {
  final _$isLoadingAtom = Atom(name: '_AvaliacaoPesControllerBase.isLoading');

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

  final _$avaliacoesAtom = Atom(name: '_AvaliacaoPesControllerBase.avaliacoes');

  @override
  ObservableList<AvaliacaoPes> get avaliacoes {
    _$avaliacoesAtom.reportRead();
    return super.avaliacoes;
  }

  @override
  set avaliacoes(ObservableList<AvaliacaoPes> value) {
    _$avaliacoesAtom.reportWrite(value, super.avaliacoes, () {
      super.avaliacoes = value;
    });
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
avaliacoes: ${avaliacoes}
    ''';
  }
}
