import 'package:dia_vision/app/repositories/paciente_repository.dart';
import 'package:dia_vision/app/repositories/user_repository.dart';
import 'package:dia_vision/app/shared/utils/date_utils.dart';
import 'package:dia_vision/app/shared/utils/utils.dart';
import 'package:dia_vision/app/app_controller.dart';
import 'package:dia_vision/app/model/paciente.dart';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:mobx/mobx.dart';

part 'my_data_controller.g.dart';

class MyDataController = _MyDataControllerBase with _$MyDataController;

abstract class _MyDataControllerBase with Store, DateUtils {
  final Utils _utils;
  final AppController _appController;
  final IUserRepository _userRepository;
  final IPacienteRepository _pacienteRepository;

  _MyDataControllerBase(
    this._userRepository,
    this._pacienteRepository,
    this._utils,
    this._appController,
  );

  @observable
  String email;
  @observable
  String nome;
  @observable
  String telefone;
  @observable
  String dataNascimento;
  @observable
  String peso;
  @observable
  String altura;
  @observable
  bool isLoading = false;
  @observable
  bool isDataReady = false;

  @computed
  String get emailError => _utils.isValidEmail(email) ? null : "Email inválido";

  @computed
  bool get isValidEmail => email != null && emailError == null;

  @computed
  bool get isValidData =>
      nome != null ||
      telefone != null ||
      dataNascimento != null ||
      peso != null ||
      altura != null;

  @action
  void setEmail(String newEmail) => email = newEmail;
  @action
  void setNome(String newNome) => nome = newNome;
  @action
  void setTelefone(String newTelefone) => telefone = newTelefone;
  @action
  void setDataNascimento(String newDataNascimento) =>
      dataNascimento = newDataNascimento;
  @action
  void setPeso(String newPeso) => peso = newPeso;
  @action
  void setAltura(String newAltura) => altura = newAltura;

  Paciente _paciente;

  Future<void> getData(
      Function(String) onError, void Function() onFinish) async {
    if (await _appController.isLogged()) {
      setEmail(_appController.user.email);
      try {
        final result = await _pacienteRepository.getByUser(_appController.user);
        result.fold((l) => onError(l.message), (r) {
          _paciente = r;

          setPeso(_paciente.peso?.toString());
          setAltura(_paciente.altura?.toString());
          if (_paciente.dataNascimento != null)
            setDataNascimento(
                UtilData.obterDataDDMMAAAA(_paciente.dataNascimento));
          setNome(_paciente.nome);
          setTelefone(_paciente.telefone);
        });
      } catch (e) {
        print(e.toString());
      }
      onFinish();
    }
    isDataReady = true;
  }

  Future<void> save(Function(String) onError, void Function() onSuccess) async {
    isLoading = true;

    try {
      if (isValidEmail && _appController.user.email != email) {
        _appController.user.username = email;
        _appController.user.email = email;

        final result = await _userRepository.save(_appController.user);
        result.fold((l) => onError(l.message), (_) => {});

        _appController.user = null;
      }
      if (isValidData) {
        final paciente = Paciente(
          telefone: telefone,
          nome: nome,
        );
        paciente.user = await _appController.currentUser();
        paciente.objectId = _paciente?.objectId;

        final dAltura = altura != null
            ? double.tryParse(altura.replaceAll(',', '.'))
            : null;
        final dPeso =
            peso != null ? double.tryParse(peso.replaceAll(',', '.')) : null;
        final dData =
            dataNascimento != null ? getDateTime(dataNascimento) : null;
        if (dAltura != null) paciente.altura = dAltura;
        if (dataNascimento != null) paciente.dataNascimento = dData;
        if (dPeso != null) paciente.peso = dPeso;

        final result = await _pacienteRepository.savePaciente(paciente);
        result.fold((l) => onError(l.message), (r) async {
          final user = await _appController.currentUser();
          _paciente = r;
          user.paciente = _paciente;
          await user.save();
          onSuccess();
        });
      }
    } catch (e) {
      onError(e.toString());
    }

    isLoading = false;
  }
}
