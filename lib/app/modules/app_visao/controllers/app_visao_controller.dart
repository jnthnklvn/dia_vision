import 'package:dia_vision/app/repositories/app_visao_repository.dart';
import 'package:dia_vision/app/model/app_visao.dart';

import 'package:mobx/mobx.dart';

part 'app_visao_controller.g.dart';

class AppVisaoController = _AppVisaoControllerBase with _$AppVisaoController;

abstract class _AppVisaoControllerBase with Store {
  final IAppVisaoRepository _avaliacaoPesRepository;

  _AppVisaoControllerBase(this._avaliacaoPesRepository);

  @observable
  bool isLoading = false;
  @observable
  ObservableList<AppVisao> apps = ObservableList<AppVisao>();

  Future<void> getData(Function(String) onError) async {
    isLoading = true;
    try {
      final result = await _avaliacaoPesRepository.getAll();
      result.fold((l) => onError(l.message), (r) {
        apps = (r ?? List<AppVisao>()).asObservable();
      });
    } catch (e) {
      onError(e.toString());
      isLoading = false;
    }
    isLoading = false;
  }
}
