// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'autocuidado_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AutocuidadoController on _AutocuidadoControllerBase, Store {
  final _$isLoadingAtom = Atom(name: '_AutocuidadoControllerBase.isLoading');

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

  final _$autocuidadosAtom =
      Atom(name: '_AutocuidadoControllerBase.autocuidados');

  @override
  ObservableList<Autocuidado> get autocuidados {
    _$autocuidadosAtom.reportRead();
    return super.autocuidados;
  }

  @override
  set autocuidados(ObservableList<Autocuidado> value) {
    _$autocuidadosAtom.reportWrite(value, super.autocuidados, () {
      super.autocuidados = value;
    });
  }

  final _$categoriasAtom = Atom(name: '_AutocuidadoControllerBase.categorias');

  @override
  ObservableSet<String> get categorias {
    _$categoriasAtom.reportRead();
    return super.categorias;
  }

  @override
  set categorias(ObservableSet<String> value) {
    _$categoriasAtom.reportWrite(value, super.categorias, () {
      super.categorias = value;
    });
  }

  final _$categoriaAtom = Atom(name: '_AutocuidadoControllerBase.categoria');

  @override
  String get categoria {
    _$categoriaAtom.reportRead();
    return super.categoria;
  }

  @override
  set categoria(String value) {
    _$categoriaAtom.reportWrite(value, super.categoria, () {
      super.categoria = value;
    });
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
autocuidados: ${autocuidados},
categorias: ${categorias},
categoria: ${categoria}
    ''';
  }
}
