// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'glicemia_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GlicemiaController on _GlicemiaControllerBase, Store {
  final _$isLoadingAtom = Atom(name: '_GlicemiaControllerBase.isLoading');

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

  final _$isValorPadraoGlicemiaAtom =
      Atom(name: '_GlicemiaControllerBase.isValorPadraoGlicemia');

  @override
  bool? get isValorPadraoGlicemia {
    _$isValorPadraoGlicemiaAtom.reportRead();
    return super.isValorPadraoGlicemia;
  }

  @override
  set isValorPadraoGlicemia(bool? value) {
    _$isValorPadraoGlicemiaAtom.reportWrite(value, super.isValorPadraoGlicemia,
        () {
      super.isValorPadraoGlicemia = value;
    });
  }

  final _$glicemiasAtom = Atom(name: '_GlicemiaControllerBase.glicemias');

  @override
  ObservableList<Glicemia> get glicemias {
    _$glicemiasAtom.reportRead();
    return super.glicemias;
  }

  @override
  set glicemias(ObservableList<Glicemia> value) {
    _$glicemiasAtom.reportWrite(value, super.glicemias, () {
      super.glicemias = value;
    });
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
isValorPadraoGlicemia: ${isValorPadraoGlicemia},
glicemias: ${glicemias}
    ''';
  }
}
