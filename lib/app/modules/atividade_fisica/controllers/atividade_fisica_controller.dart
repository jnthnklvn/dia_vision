import 'package:dia_vision/app/repositories/atividade_fisica_repository.dart';
import 'package:dia_vision/app/model/atividade_fisica.dart';
import 'package:dia_vision/app/app_controller.dart';

import 'package:mobx/mobx.dart';

part 'atividade_fisica_controller.g.dart';

class AtividadeFisicaController = _AtividadeFisicaControllerBase
    with _$AtividadeFisicaController;

abstract class _AtividadeFisicaControllerBase with Store {
  final IAtividadeFisicaRepository _atividadeFisicaRepository;
  final AppController _appController;

  _AtividadeFisicaControllerBase(
    this._atividadeFisicaRepository,
    this._appController,
  );

  @observable
  bool isLoading = false;
  @observable
  ObservableList<AtividadeFisica> atividades =
      ObservableList<AtividadeFisica>();

  Future<void> getData(Function(String) onError) async {
    isLoading = true;
    try {
      final result =
          await _atividadeFisicaRepository.getAll(_appController.user.paciente);
      result.fold((l) => onError(l.message), (r) {
        atividades = (r ?? List<AtividadeFisica>()).asObservable();
      });
    } catch (e) {
      onError(e.toString());
      isLoading = false;
    }
    isLoading = false;
  }
}
