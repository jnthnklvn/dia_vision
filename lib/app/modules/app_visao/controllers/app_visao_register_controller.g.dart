// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_visao_register_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppVisaoRegisterController on _AppVisaoRegisterControllerBase, Store {
  final _$descricaoAtom =
      Atom(name: '_AppVisaoRegisterControllerBase.descricao');

  @override
  String? get descricao {
    _$descricaoAtom.reportRead();
    return super.descricao;
  }

  @override
  set descricao(String? value) {
    _$descricaoAtom.reportWrite(value, super.descricao, () {
      super.descricao = value;
    });
  }

  final _$tituloAtom = Atom(name: '_AppVisaoRegisterControllerBase.titulo');

  @override
  String? get titulo {
    _$tituloAtom.reportRead();
    return super.titulo;
  }

  @override
  set titulo(String? value) {
    _$tituloAtom.reportWrite(value, super.titulo, () {
      super.titulo = value;
    });
  }

  final _$linkGooglePlayAtom =
      Atom(name: '_AppVisaoRegisterControllerBase.linkGooglePlay');

  @override
  String? get linkGooglePlay {
    _$linkGooglePlayAtom.reportRead();
    return super.linkGooglePlay;
  }

  @override
  set linkGooglePlay(String? value) {
    _$linkGooglePlayAtom.reportWrite(value, super.linkGooglePlay, () {
      super.linkGooglePlay = value;
    });
  }

  final _$linkAppleStoreAtom =
      Atom(name: '_AppVisaoRegisterControllerBase.linkAppleStore');

  @override
  String? get linkAppleStore {
    _$linkAppleStoreAtom.reportRead();
    return super.linkAppleStore;
  }

  @override
  set linkAppleStore(String? value) {
    _$linkAppleStoreAtom.reportWrite(value, super.linkAppleStore, () {
      super.linkAppleStore = value;
    });
  }

  final _$isLoadingAtom =
      Atom(name: '_AppVisaoRegisterControllerBase.isLoading');

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

  final _$_AppVisaoRegisterControllerBaseActionController =
      ActionController(name: '_AppVisaoRegisterControllerBase');

  @override
  void setDescricao(String? newValue) {
    final _$actionInfo = _$_AppVisaoRegisterControllerBaseActionController
        .startAction(name: '_AppVisaoRegisterControllerBase.setDescricao');
    try {
      return super.setDescricao(newValue);
    } finally {
      _$_AppVisaoRegisterControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLinkAppleStore(String? newValue) {
    final _$actionInfo = _$_AppVisaoRegisterControllerBaseActionController
        .startAction(name: '_AppVisaoRegisterControllerBase.setLinkAppleStore');
    try {
      return super.setLinkAppleStore(newValue);
    } finally {
      _$_AppVisaoRegisterControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTitulo(String? newValue) {
    final _$actionInfo = _$_AppVisaoRegisterControllerBaseActionController
        .startAction(name: '_AppVisaoRegisterControllerBase.setTitulo');
    try {
      return super.setTitulo(newValue);
    } finally {
      _$_AppVisaoRegisterControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLinkGooglePlay(String? newValue) {
    final _$actionInfo = _$_AppVisaoRegisterControllerBaseActionController
        .startAction(name: '_AppVisaoRegisterControllerBase.setLinkGooglePlay');
    try {
      return super.setLinkGooglePlay(newValue);
    } finally {
      _$_AppVisaoRegisterControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
descricao: ${descricao},
titulo: ${titulo},
linkGooglePlay: ${linkGooglePlay},
linkAppleStore: ${linkAppleStore},
isLoading: ${isLoading}
    ''';
  }
}
