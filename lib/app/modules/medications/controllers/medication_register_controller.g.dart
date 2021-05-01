// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medication_register_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MedicationRegisterController
    on _MedicationRegisterControllerBase, Store {
  Computed<bool> _$isNomeValidComputed;

  @override
  bool get isNomeValid =>
      (_$isNomeValidComputed ??= Computed<bool>(() => super.isNomeValid,
              name: '_MedicationRegisterControllerBase.isNomeValid'))
          .value;
  Computed<bool> _$isEdicaoComputed;

  @override
  bool get isEdicao =>
      (_$isEdicaoComputed ??= Computed<bool>(() => super.isEdicao,
              name: '_MedicationRegisterControllerBase.isEdicao'))
          .value;

  final _$medicoPrescritorAtom =
      Atom(name: '_MedicationRegisterControllerBase.medicoPrescritor');

  @override
  String get medicoPrescritor {
    _$medicoPrescritorAtom.reportRead();
    return super.medicoPrescritor;
  }

  @override
  set medicoPrescritor(String value) {
    _$medicoPrescritorAtom.reportWrite(value, super.medicoPrescritor, () {
      super.medicoPrescritor = value;
    });
  }

  final _$nomeAtom = Atom(name: '_MedicationRegisterControllerBase.nome');

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

  final _$dataFinalAtom =
      Atom(name: '_MedicationRegisterControllerBase.dataFinal');

  @override
  String get dataFinal {
    _$dataFinalAtom.reportRead();
    return super.dataFinal;
  }

  @override
  set dataFinal(String value) {
    _$dataFinalAtom.reportWrite(value, super.dataFinal, () {
      super.dataFinal = value;
    });
  }

  final _$dataInicialAtom =
      Atom(name: '_MedicationRegisterControllerBase.dataInicial');

  @override
  String get dataInicial {
    _$dataInicialAtom.reportRead();
    return super.dataInicial;
  }

  @override
  set dataInicial(String value) {
    _$dataInicialAtom.reportWrite(value, super.dataInicial, () {
      super.dataInicial = value;
    });
  }

  final _$posologiaAtom =
      Atom(name: '_MedicationRegisterControllerBase.posologia');

  @override
  Tuple2<String, int> get posologia {
    _$posologiaAtom.reportRead();
    return super.posologia;
  }

  @override
  set posologia(Tuple2<String, int> value) {
    _$posologiaAtom.reportWrite(value, super.posologia, () {
      super.posologia = value;
    });
  }

  final _$dosagemAtom = Atom(name: '_MedicationRegisterControllerBase.dosagem');

  @override
  String get dosagem {
    _$dosagemAtom.reportRead();
    return super.dosagem;
  }

  @override
  set dosagem(String value) {
    _$dosagemAtom.reportWrite(value, super.dosagem, () {
      super.dosagem = value;
    });
  }

  final _$efeitosColateraisAtom =
      Atom(name: '_MedicationRegisterControllerBase.efeitosColaterais');

  @override
  String get efeitosColaterais {
    _$efeitosColateraisAtom.reportRead();
    return super.efeitosColaterais;
  }

  @override
  set efeitosColaterais(String value) {
    _$efeitosColateraisAtom.reportWrite(value, super.efeitosColaterais, () {
      super.efeitosColaterais = value;
    });
  }

  final _$horarioInicialAtom =
      Atom(name: '_MedicationRegisterControllerBase.horarioInicial');

  @override
  String get horarioInicial {
    _$horarioInicialAtom.reportRead();
    return super.horarioInicial;
  }

  @override
  set horarioInicial(String value) {
    _$horarioInicialAtom.reportWrite(value, super.horarioInicial, () {
      super.horarioInicial = value;
    });
  }

  final _$horariosAtom =
      Atom(name: '_MedicationRegisterControllerBase.horarios');

  @override
  ObservableList<String> get horarios {
    _$horariosAtom.reportRead();
    return super.horarios;
  }

  @override
  set horarios(ObservableList<String> value) {
    _$horariosAtom.reportWrite(value, super.horarios, () {
      super.horarios = value;
    });
  }

  final _$isSearchingAtom =
      Atom(name: '_MedicationRegisterControllerBase.isSearching');

  @override
  bool get isSearching {
    _$isSearchingAtom.reportRead();
    return super.isSearching;
  }

  @override
  set isSearching(bool value) {
    _$isSearchingAtom.reportWrite(value, super.isSearching, () {
      super.isSearching = value;
    });
  }

  final _$isLoadingAtom =
      Atom(name: '_MedicationRegisterControllerBase.isLoading');

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

  final _$medicamentosAtom =
      Atom(name: '_MedicationRegisterControllerBase.medicamentos');

  @override
  List<Medicamento> get medicamentos {
    _$medicamentosAtom.reportRead();
    return super.medicamentos;
  }

  @override
  set medicamentos(List<Medicamento> value) {
    _$medicamentosAtom.reportWrite(value, super.medicamentos, () {
      super.medicamentos = value;
    });
  }

  final _$_MedicationRegisterControllerBaseActionController =
      ActionController(name: '_MedicationRegisterControllerBase');

  @override
  void setNome(String newNome) {
    final _$actionInfo = _$_MedicationRegisterControllerBaseActionController
        .startAction(name: '_MedicationRegisterControllerBase.setNome');
    try {
      return super.setNome(newNome);
    } finally {
      _$_MedicationRegisterControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setMedicoPrescritor(String newMedicoPrescritor) {
    final _$actionInfo =
        _$_MedicationRegisterControllerBaseActionController.startAction(
            name: '_MedicationRegisterControllerBase.setMedicoPrescritor');
    try {
      return super.setMedicoPrescritor(newMedicoPrescritor);
    } finally {
      _$_MedicationRegisterControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setEfeitosColaterais(String newEfeitosColaterais) {
    final _$actionInfo =
        _$_MedicationRegisterControllerBaseActionController.startAction(
            name: '_MedicationRegisterControllerBase.setEfeitosColaterais');
    try {
      return super.setEfeitosColaterais(newEfeitosColaterais);
    } finally {
      _$_MedicationRegisterControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setHorarioInicial(String newHorarioInicial) {
    final _$actionInfo =
        _$_MedicationRegisterControllerBaseActionController.startAction(
            name: '_MedicationRegisterControllerBase.setHorarioInicial');
    try {
      return super.setHorarioInicial(newHorarioInicial);
    } finally {
      _$_MedicationRegisterControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setDataInicial(String newDataInicial) {
    final _$actionInfo = _$_MedicationRegisterControllerBaseActionController
        .startAction(name: '_MedicationRegisterControllerBase.setDataInicial');
    try {
      return super.setDataInicial(newDataInicial);
    } finally {
      _$_MedicationRegisterControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setDataFinal(String newDataFinal) {
    final _$actionInfo = _$_MedicationRegisterControllerBaseActionController
        .startAction(name: '_MedicationRegisterControllerBase.setDataFinal');
    try {
      return super.setDataFinal(newDataFinal);
    } finally {
      _$_MedicationRegisterControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setPosologia(String newPosologia) {
    final _$actionInfo = _$_MedicationRegisterControllerBaseActionController
        .startAction(name: '_MedicationRegisterControllerBase.setPosologia');
    try {
      return super.setPosologia(newPosologia);
    } finally {
      _$_MedicationRegisterControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setDosagem(String newDosagem) {
    final _$actionInfo = _$_MedicationRegisterControllerBaseActionController
        .startAction(name: '_MedicationRegisterControllerBase.setDosagem');
    try {
      return super.setDosagem(newDosagem);
    } finally {
      _$_MedicationRegisterControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
medicoPrescritor: ${medicoPrescritor},
nome: ${nome},
dataFinal: ${dataFinal},
dataInicial: ${dataInicial},
posologia: ${posologia},
dosagem: ${dosagem},
efeitosColaterais: ${efeitosColaterais},
horarioInicial: ${horarioInicial},
horarios: ${horarios},
isSearching: ${isSearching},
isLoading: ${isLoading},
medicamentos: ${medicamentos},
isNomeValid: ${isNomeValid},
isEdicao: ${isEdicao}
    ''';
  }
}
