// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medications_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MedicationsController on _MedicationsControllerBase, Store {
  final _$isLoadingAtom = Atom(name: '_MedicationsControllerBase.isLoading');

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

  final _$medicacoesAtom = Atom(name: '_MedicationsControllerBase.medicacoes');

  @override
  ObservableList<MedicacaoPrescrita> get medicacoes {
    _$medicacoesAtom.reportRead();
    return super.medicacoes;
  }

  @override
  set medicacoes(ObservableList<MedicacaoPrescrita> value) {
    _$medicacoesAtom.reportWrite(value, super.medicacoes, () {
      super.medicacoes = value;
    });
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
medicacoes: ${medicacoes}
    ''';
  }
}
