import 'package:dia_vision/app/repositories/centro_saude_repository.dart';
import 'package:dia_vision/app/model/centro_saude.dart';

import 'package:mobx/mobx.dart';

part 'centro_saude_controller.g.dart';

class CentroSaudeController = _CentroSaudeControllerBase
    with _$CentroSaudeController;

abstract class _CentroSaudeControllerBase with Store {
  final ICentroSaudeRepository _avaliacaoPesRepository;

  _CentroSaudeControllerBase(this._avaliacaoPesRepository);

  @observable
  bool isLoading = false;
  @observable
  ObservableList<CentroSaude> centros = ObservableList<CentroSaude>();

  Future<void> getData(Function(String) onError) async {
    isLoading = true;
    try {
      final result = await _avaliacaoPesRepository.getAll();
      result.fold((l) => onError(l.message), (r) {
        centros = (r ?? List<CentroSaude>()).asObservable();
      });
    } catch (e) {
      onError(e.toString());
      isLoading = false;
    }
    isLoading = false;
  }
}
