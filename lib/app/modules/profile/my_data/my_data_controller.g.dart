// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_data_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MyDataController on _MyDataControllerBase, Store {
  Computed<String> _$emailErrorComputed;

  @override
  String get emailError =>
      (_$emailErrorComputed ??= Computed<String>(() => super.emailError,
              name: '_MyDataControllerBase.emailError'))
          .value;
  Computed<bool> _$isValidEmailComputed;

  @override
  bool get isValidEmail =>
      (_$isValidEmailComputed ??= Computed<bool>(() => super.isValidEmail,
              name: '_MyDataControllerBase.isValidEmail'))
          .value;
  Computed<bool> _$isValidDataComputed;

  @override
  bool get isValidData =>
      (_$isValidDataComputed ??= Computed<bool>(() => super.isValidData,
              name: '_MyDataControllerBase.isValidData'))
          .value;

  final _$emailAtom = Atom(name: '_MyDataControllerBase.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$nomeAtom = Atom(name: '_MyDataControllerBase.nome');

  @override
  String get nome {
    _$nomeAtom.reportRead();
    return super.nome;
  }

  @override
  set nome(String value) {
    _$nomeAtom.reportWrite(value, super.nome, () {
      super.nome = value;
    });
  }

  final _$telefoneAtom = Atom(name: '_MyDataControllerBase.telefone');

  @override
  String get telefone {
    _$telefoneAtom.reportRead();
    return super.telefone;
  }

  @override
  set telefone(String value) {
    _$telefoneAtom.reportWrite(value, super.telefone, () {
      super.telefone = value;
    });
  }

  final _$dataNascimentoAtom =
      Atom(name: '_MyDataControllerBase.dataNascimento');

  @override
  String get dataNascimento {
    _$dataNascimentoAtom.reportRead();
    return super.dataNascimento;
  }

  @override
  set dataNascimento(String value) {
    _$dataNascimentoAtom.reportWrite(value, super.dataNascimento, () {
      super.dataNascimento = value;
    });
  }

  final _$pesoAtom = Atom(name: '_MyDataControllerBase.peso');

  @override
  String get peso {
    _$pesoAtom.reportRead();
    return super.peso;
  }

  @override
  set peso(String value) {
    _$pesoAtom.reportWrite(value, super.peso, () {
      super.peso = value;
    });
  }

  final _$alturaAtom = Atom(name: '_MyDataControllerBase.altura');

  @override
  String get altura {
    _$alturaAtom.reportRead();
    return super.altura;
  }

  @override
  set altura(String value) {
    _$alturaAtom.reportWrite(value, super.altura, () {
      super.altura = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_MyDataControllerBase.isLoading');

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

  final _$isDataReadyAtom = Atom(name: '_MyDataControllerBase.isDataReady');

  @override
  bool get isDataReady {
    _$isDataReadyAtom.reportRead();
    return super.isDataReady;
  }

  @override
  set isDataReady(bool value) {
    _$isDataReadyAtom.reportWrite(value, super.isDataReady, () {
      super.isDataReady = value;
    });
  }

  final _$_MyDataControllerBaseActionController =
      ActionController(name: '_MyDataControllerBase');

  @override
  void setEmail(String newEmail) {
    final _$actionInfo = _$_MyDataControllerBaseActionController.startAction(
        name: '_MyDataControllerBase.setEmail');
    try {
      return super.setEmail(newEmail);
    } finally {
      _$_MyDataControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNome(String newNome) {
    final _$actionInfo = _$_MyDataControllerBaseActionController.startAction(
        name: '_MyDataControllerBase.setNome');
    try {
      return super.setNome(newNome);
    } finally {
      _$_MyDataControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTelefone(String newTelefone) {
    final _$actionInfo = _$_MyDataControllerBaseActionController.startAction(
        name: '_MyDataControllerBase.setTelefone');
    try {
      return super.setTelefone(newTelefone);
    } finally {
      _$_MyDataControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDataNascimento(String newDataNascimento) {
    final _$actionInfo = _$_MyDataControllerBaseActionController.startAction(
        name: '_MyDataControllerBase.setDataNascimento');
    try {
      return super.setDataNascimento(newDataNascimento);
    } finally {
      _$_MyDataControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPeso(String newPeso) {
    final _$actionInfo = _$_MyDataControllerBaseActionController.startAction(
        name: '_MyDataControllerBase.setPeso');
    try {
      return super.setPeso(newPeso);
    } finally {
      _$_MyDataControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAltura(String newAltura) {
    final _$actionInfo = _$_MyDataControllerBaseActionController.startAction(
        name: '_MyDataControllerBase.setAltura');
    try {
      return super.setAltura(newAltura);
    } finally {
      _$_MyDataControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
email: ${email},
nome: ${nome},
telefone: ${telefone},
dataNascimento: ${dataNascimento},
peso: ${peso},
altura: ${altura},
isLoading: ${isLoading},
isDataReady: ${isDataReady},
emailError: ${emailError},
isValidEmail: ${isValidEmail},
isValidData: ${isValidData}
    ''';
  }
}
