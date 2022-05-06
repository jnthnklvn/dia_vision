import 'package:dia_vision/app/repositories/centro_saude_repository.dart';
import 'package:dia_vision/app/repositories/model/centro_saude.dart';

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
  @observable
  ObservableSet<String?> tipos = ObservableSet<String>();
  @observable
  String? tipo;

  List<CentroSaude> _centros = <CentroSaude>[];

  Future<void> getData(Function(String) onError) async {
    isLoading = true;
    try {
      final result = await _avaliacaoPesRepository.getAll();
      result.fold((l) => onError(l.message), (r) {
        _centros = r;
        tipos = r.map((e) => e.tipo).toSet().asObservable();
        centros = (r).asObservable();
      });
    } catch (e) {
      onError(e.toString());
      isLoading = false;
    }
    isLoading = false;
  }

  void filterData(String tipo) {
    this.tipo = tipo;
    if (_centros.isNotEmpty) {
      centros = _centros.where((e) => e.tipo == tipo).toList().asObservable();
      if (centros.isEmpty) {
        centros = _centros.asObservable();
      }
    }
  }
}
