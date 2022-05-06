import 'package:dia_vision/app/repositories/medicacao_prescrita_repository.dart';
import 'package:dia_vision/app/repositories/medication_repository.dart';
import 'package:dia_vision/app/repositories/model/medicacao_prescrita.dart';
import 'package:dia_vision/app/shared/utils/date_utils.dart';
import 'package:dia_vision/app/repositories/model/medicamento.dart';
import 'package:dia_vision/app/app_controller.dart';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:dartz/dartz.dart';
import 'package:mobx/mobx.dart';

import 'medications_controller.dart';

part 'medication_register_controller.g.dart';

class MedicationRegisterController = _MedicationRegisterControllerBase
    with _$MedicationRegisterController;

abstract class _MedicationRegisterControllerBase with Store, DateUtil {
  final IMedicacaoPrescritaRepository _medicacaoPrescritaRepository;
  final IMedicamentoRepository _medicamentoRepository;
  final MedicationsController _medicationsController;
  final AppController _appController;

  _MedicationRegisterControllerBase(
    this._medicacaoPrescritaRepository,
    this._medicationsController,
    this._medicamentoRepository,
    this._appController,
  );

  @observable
  String? medicoPrescritor;
  @observable
  String? nome;
  @observable
  String? dataFinal;
  @observable
  String? dataInicial;
  @observable
  Tuple2<String, int>? posologia;
  @observable
  String? dosagem;
  @observable
  String? medidaDosagem;
  @observable
  String? efeitosColaterais;
  @observable
  String? horarioInicial;
  @observable
  ObservableList<String> horarios = ObservableList<String>();
  String? horario;

  @observable
  bool isSearching = false;
  @observable
  bool isLoading = false;
  @observable
  List<Medicamento> medicamentos = [];

  List<String> nomesMedicamentos = [];
  Medicamento? medicamentoSelecionado;
  MedicacaoPrescrita? _medicacaoPrescrita;
  List<Medicamento> medicamentosBase = [];

  final List<Tuple2<String, int>> horariosList = [
    const Tuple2("1 em 1 hora", 1),
    const Tuple2("2 em 2 horas", 2),
    const Tuple2("4 em 4 horas", 4),
    const Tuple2("6 em 6 horas", 6),
    const Tuple2("8 em 8 horas", 8),
    const Tuple2("12 em 12 horas", 12),
    const Tuple2("24 em 24 horas", 24),
    const Tuple2("Personalizado", 0),
  ];

  final List<String> medidas = [
    "mg",
    "g",
    "ml",
    "comprimidos",
    "gotas",
  ];

  @computed
  bool get isNomeValid => nome != null && nome!.length > 3;
  @computed
  bool get isEdicao => _medicacaoPrescrita != null;

  @action
  void setNome(String? newNome) => nome = newNome;
  @action
  void setMedicoPrescritor(String? newMedicoPrescritor) =>
      medicoPrescritor = newMedicoPrescritor;
  @action
  void setEfeitosColaterais(String? newEfeitosColaterais) =>
      efeitosColaterais = newEfeitosColaterais;
  @action
  void setHorarioInicial(String? newHorarioInicial) =>
      horarioInicial = newHorarioInicial;
  @action
  void setHorario(String? newHorario) => horario = newHorario;

  @action
  void addHorario() {
    if (horario != null) horarios.add(horario!);
    horarios = horarios.asObservable();
  }

  @action
  void removeHorario(String h) {
    horarios.remove(h);
    horarios = horarios.asObservable();
  }

  @action
  void setDataInicial(String newDataInicial) => dataInicial = newDataInicial;
  @action
  void setDataFinal(String newDataFinal) => dataFinal = newDataFinal;
  @action
  void setPosologia(String? newPosologia) {
    for (var element in horariosList) {
      if (element.value1 == newPosologia) {
        posologia = element;
        return;
      }
    }
  }

  @action
  void setDosagem(String? newDosagem) => dosagem = newDosagem;
  void setMedidaDosagem(String? newMedidaDosagem) =>
      medidaDosagem = newMedidaDosagem;

  void init(MedicacaoPrescrita? medicacao) {
    _medicacaoPrescrita = medicacao;
    if (medicacao != null) {
      setNome(medicacao.nome);
      if (medicacao.dataFinal != null) {
        setDataFinal(UtilData.obterDataDDMMAAAA(medicacao.dataFinal!));
      }
      if (medicacao.dataInicial != null) {
        setDataInicial(UtilData.obterDataDDMMAAAA(medicacao.dataInicial!));
      }
      setHorarioInicial(medicacao.horarioInicial);
      if (medicacao.horarios?.isNotEmpty == true) {
        horarios.addAll(medicacao.horarios!.split(', '));
      }
      for (var element in horariosList) {
        if (element.value2 == medicacao.posologia) {
          posologia = element;
          return;
        }
      }
      setMedicoPrescritor(medicacao.medicoPrescritor);
      setDosagem(medicacao.dosagem?.toString());
      setMedidaDosagem(medicacao.medidaDosagem);
      setEfeitosColaterais(medicacao.efeitosColaterais);
    }
  }

  Future<void> getData(Function(String) onError) async {
    isSearching = true;
    try {
      if (nome != null) {
        final result =
            await _medicamentoRepository.getByText(nome!, limit: 200);
        result.fold((l) => onError(l.message), (r) {
          medicamentos = r;
          medicamentosBase = r;
        });
      }
    } catch (e) {
      onError(e.toString());
      isSearching = false;
    }
    isSearching = false;
  }

  Future<List<Medicamento>> getSuggestions(Function(String) onError) async {
    if (isNomeValid && (nome?.length == 4 || medicamentosBase.length == 200)) {
      await getData(onError);
    }

    if (medicamentosBase.isNotEmpty == true) {
      nomesMedicamentos = medicamentosBase
          .map((e) =>
              (e.nomeComercial ?? '') + " -- " + (e.nomeSubstancia ?? ''))
          .toList();

      final fuse = Fuzzy(nomesMedicamentos);
      final result = fuse.search(nome ?? '',
          medicamentosBase.length < 5 ? medicamentosBase.length : 5);

      medicamentos = result
          .map((r) => medicamentosBase.firstWhere(
              (element) => (element.nomeComercial == r.item.split(" -- ")[0])))
          .toList();
    }

    return medicamentos;
  }

  Future<void> save(Function(String) onError, void Function() onSuccess) async {
    isLoading = true;

    try {
      if (isNomeValid) {
        final medicacaoPrescrita = MedicacaoPrescrita(
          nome: nome,
          medicoPrescritor: medicoPrescritor,
          medicamento: medicamentoSelecionado,
          efeitosColaterais: efeitosColaterais,
          medidaDosagem: medidaDosagem,
        );

        final user = await _appController.currentUser();
        medicacaoPrescrita.paciente = user!.paciente;
        medicacaoPrescrita.objectId = _medicacaoPrescrita?.objectId;
        medicacaoPrescrita.horarioInicial = horarioInicial;

        final dDosagem = dosagem != null ? double.tryParse(dosagem!) : null;
        final dDataInicial =
            dataInicial != null ? getDateTime(dataInicial) : null;
        final dDataFinal = dataFinal != null ? getDateTime(dataFinal) : null;
        if (dDosagem != null) medicacaoPrescrita.dosagem = dDosagem;
        if (posologia != null) medicacaoPrescrita.posologia = posologia!.value2;
        if (dataInicial != null) medicacaoPrescrita.dataInicial = dDataInicial;
        if (dataFinal != null) medicacaoPrescrita.dataFinal = dDataFinal;
        if (horarios.isNotEmpty) {
          medicacaoPrescrita.horarios =
              horarios.toString().replaceAll('[', '').replaceAll(']', '');
        }

        final result =
            await _medicacaoPrescritaRepository.save(medicacaoPrescrita, user);
        result.fold((l) => onError(l.message), (r) {
          final idx = _medicationsController.medicacoes
              .indexWhere((e) => e.objectId == r.objectId);
          idx == -1
              ? _medicationsController.medicacoes.insert(0, r)
              : _medicationsController.medicacoes[idx] = r;
          onSuccess();
        });
      }
    } catch (e) {
      onError(e.toString());
    }

    isLoading = false;
  }
}
