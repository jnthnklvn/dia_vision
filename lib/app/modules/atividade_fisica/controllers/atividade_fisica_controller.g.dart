// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'atividade_fisica_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AtividadeFisicaController on _AtividadeFisicaControllerBase, Store {
  final _$isLoadingAtom =
      Atom(name: '_AtividadeFisicaControllerBase.isLoading');

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

  final _$atividadesAtom =
      Atom(name: '_AtividadeFisicaControllerBase.atividades');

  @override
  ObservableList<AtividadeFisica> get atividades {
    _$atividadesAtom.reportRead();
    return super.atividades;
  }

  @override
  set atividades(ObservableList<AtividadeFisica> value) {
    _$atividadesAtom.reportWrite(value, super.atividades, () {
      super.atividades = value;
    });
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
atividades: ${atividades}
    ''';
  }
}
