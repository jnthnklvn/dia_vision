import 'package:brasil_fields/brasil_fields.dart';
import 'package:dia_vision/app/modules/medications/medications_controller.dart';
import 'package:dia_vision/app/repositories/medicacao_prescrita_repository.dart';
import 'package:dia_vision/app/repositories/medication_repository.dart';
import 'package:dia_vision/app/model/medicacao_prescrita.dart';
import 'package:dia_vision/app/shared/utils/date_utils.dart';
import 'package:dia_vision/app/model/medicamento.dart';
import 'package:dia_vision/app/app_controller.dart';

import 'package:fuzzy/fuzzy.dart';
import 'package:mobx/mobx.dart';

part 'medication_register_controller.g.dart';

class MedicationRegisterController = _MedicationRegisterControllerBase
    with _$MedicationRegisterController;

abstract class _MedicationRegisterControllerBase with Store, DateUtils {
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
  String medicoPrescritor;
  @observable
  String nome;
  @observable
  String dataFinal;
  @observable
  String dataInicial;
  @observable
  String posologia;
  @observable
  String dosagem;
  @observable
  String efeitosColaterais;

  @observable
  bool isSearching = false;
  @observable
  bool isLoading = false;
  @observable
  List<Medicamento> medicamentos = [];

  List<String> nomesMedicamentos = [];
  Medicamento medicamentoSelecionado;
  MedicacaoPrescrita _medicacaoPrescrita;
  List<Medicamento> medicamentosBase = [];

  @computed
  bool get isNomeValid => nome != null && nome.length > 3;
  @computed
  bool get isEdicao => _medicacaoPrescrita != null;

  @action
  void setNome(String newNome) => nome = newNome;
  @action
  void setMedicoPrescritor(String newMedicoPrescritor) =>
      medicoPrescritor = newMedicoPrescritor;
  @action
  void setEfeitosColaterais(String newEfeitosColaterais) =>
      efeitosColaterais = newEfeitosColaterais;
  @action
  void setDataInicial(String newDataInicial) => dataInicial = newDataInicial;
  @action
  void setDataFinal(String newDataFinal) => dataFinal = newDataFinal;
  @action
  void setPosologia(String newPosologia) => posologia = newPosologia;
  @action
  void setDosagem(String newDosagem) => dosagem = newDosagem;

  void init(MedicacaoPrescrita medicacao) {
    _medicacaoPrescrita = medicacao;
    if (medicacao != null) {
      setNome(medicacao.nome);
      if (medicacao.dataFinal != null)
        setDataFinal(UtilData.obterDataDDMMAAAA(medicacao.dataFinal));
      if (medicacao.dataInicial != null)
        setDataInicial(UtilData.obterDataDDMMAAAA(medicacao.dataInicial));
      setPosologia(medicacao.posologia?.toString());
      setMedicoPrescritor(medicacao.medicoPrescritor);
      setDosagem(medicacao.dosagem?.toString());
      setEfeitosColaterais(medicacao.efeitosColaterais);
    }
  }

  Future<void> getData(Function(String) onError) async {
    isSearching = true;
    try {
      final result = await _medicamentoRepository.getByText(nome, limit: 200);
      result.fold((l) => onError(l.message), (r) {
        medicamentos = r;
        medicamentosBase = r;
      });
    } catch (e) {
      onError(e.toString());
      isSearching = false;
    }
    isSearching = false;
  }

  Future<List<Medicamento>> getSuggestions(Function(String) onError) async {
    if (isNomeValid && (nome.length == 4 || medicamentosBase?.length == 200))
      await getData(onError);

    if (medicamentosBase?.isNotEmpty == true) {
      nomesMedicamentos = medicamentosBase
          .map((e) => e.nomeComercial + " -- " + e.nomeSubstancia)
          .toList();

      final fuse = Fuzzy(nomesMedicamentos);
      final result = fuse.search(
          nome, medicamentosBase.length < 5 ? medicamentosBase.length : 5);

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
        );

        final user = await _appController.currentUser();
        medicacaoPrescrita.paciente = user.paciente;
        medicacaoPrescrita.objectId = _medicacaoPrescrita?.objectId;

        final dPosologia =
            posologia != null ? double.tryParse(posologia) : null;
        final dDosagem = dosagem != null ? double.tryParse(dosagem) : null;
        final dDataInicial =
            dataInicial != null ? getDateTime(dataInicial) : null;
        final dDataFinal = dataFinal != null ? getDateTime(dataFinal) : null;
        if (dDosagem != null) medicacaoPrescrita.dosagem = dDosagem;
        if (dPosologia != null) medicacaoPrescrita.posologia = dPosologia;
        if (dataInicial != null) medicacaoPrescrita.dataInicial = dDataInicial;
        if (dataFinal != null) medicacaoPrescrita.dataFinal = dDataFinal;

        final result =
            await _medicacaoPrescritaRepository.save(medicacaoPrescrita, user);
        result.fold((l) => onError(l.message), (r) {
          final idx = _medicationsController.medicacoes
              .indexWhere((e) => e.objectId == r.objectId);
          idx == -1
              ? _medicationsController.medicacoes.add(r)
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
