// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_visao_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppVisaoController on _AppVisaoControllerBase, Store {
  final _$isLoadingAtom = Atom(name: '_AppVisaoControllerBase.isLoading');

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

  final _$appsAtom = Atom(name: '_AppVisaoControllerBase.apps');

  @override
  ObservableList<AppVisao> get apps {
    _$appsAtom.reportRead();
    return super.apps;
  }

  @override
  set apps(ObservableList<AppVisao> value) {
    _$appsAtom.reportWrite(value, super.apps, () {
      super.apps = value;
    });
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
apps: ${apps}
    ''';
  }
}
