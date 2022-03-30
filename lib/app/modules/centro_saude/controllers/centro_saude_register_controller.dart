import 'package:dia_vision/app/repositories/centro_saude_repository.dart';
import 'package:dia_vision/app/repositories/endereco_repository.dart';
import 'package:dia_vision/app/model/centro_saude.dart';
import 'package:dia_vision/app/model/endereco.dart';

import 'package:mobx/mobx.dart';

part 'centro_saude_register_controller.g.dart';

class CentroSaudeRegisterController = _CentroSaudeRegisterControllerBase
    with _$CentroSaudeRegisterController;

abstract class _CentroSaudeRegisterControllerBase with Store {
  final ICentroSaudeRepository _centroSaudeRepository;
  final IEnderecoRepository _enderecoRepository;

  _CentroSaudeRegisterControllerBase(
    this._centroSaudeRepository,
    this._enderecoRepository,
  );

  @observable
  String? nome;
  @observable
  String? descricao;
  @observable
  String? telefone;
  @observable
  String? tipo;
  @observable
  String? linkMaps;

  @observable
  String? cidade;
  @observable
  String? estado;
  @observable
  String? numero;
  @observable
  String? rua;
  @observable
  String? bairro;

  @observable
  bool isLoading = false;
  @observable
  bool adcEndereco = false;

  @action
  void setAdcEndereco(bool newValue) => adcEndereco = newValue;
  @action
  void setDescricao(String? newValue) => descricao = newValue;
  @action
  void setTelefone(String? newValue) => telefone = newValue;
  @action
  void setTipo(String? newValue) => tipo = newValue;
  @action
  void setLinkMaps(String? newValue) => linkMaps = newValue;
  @action
  void setNome(String? newValue) => nome = newValue;

  @action
  void setCidade(String? newValue) => cidade = newValue;
  @action
  void setBairro(String? newValue) => bairro = newValue;
  @action
  void setEstado(String? newValue) => estado = newValue;
  @action
  void setNumero(String? newValue) => numero = newValue;
  @action
  void setRua(String? newValue) => rua = newValue;

  Future<void> save(Function(String) onError, void Function() onSuccess) async {
    isLoading = true;

    Endereco? endereco;

    try {
      if (adcEndereco &&
          rua != null &&
          (bairro != null ||
              cidade != null ||
              estado != null ||
              numero != null)) {
        final enderecoAux = Endereco(
          bairro: bairro,
          cidade: cidade,
          estado: estado,
          rua: rua,
        );
        if (numero != null) enderecoAux.numero = num.tryParse(numero!);
        final result = await _enderecoRepository.save(enderecoAux);
        result.fold((l) => onError(l.message), (r) => endereco = r);
      }

      final centroSaude = CentroSaude(
        descricao: descricao,
        tipo: tipo,
        telefone: telefone,
        linkMaps: linkMaps,
        nome: nome,
      );

      if (endereco != null) centroSaude.endereco = endereco;

      final result = await _centroSaudeRepository.save(centroSaude);
      result.fold((l) => onError(l.message), (r) => onSuccess());
    } catch (e) {
      onError(e.toString());
    }

    isLoading = false;
  }
}
