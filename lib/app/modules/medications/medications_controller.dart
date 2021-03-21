import 'package:dia_vision/app/repositories/medicacao_prescrita_repository.dart';
import 'package:dia_vision/app/model/medicacao_prescrita.dart';
import 'package:dia_vision/app/shared/utils/date_utils.dart';
import 'package:dia_vision/app/app_controller.dart';

import 'package:mobx/mobx.dart';

part 'medications_controller.g.dart';

class MedicationsController = _MedicationsControllerBase
    with _$MedicationsController;

abstract class _MedicationsControllerBase with Store, DateUtils {
  final IMedicacaoPrescritaRepository _medicacaoPrescritaRepository;
  final AppController _appController;

  _MedicationsControllerBase(
    this._medicacaoPrescritaRepository,
    this._appController,
  );

  @observable
  bool isLoading = false;
  @observable
  ObservableList<MedicacaoPrescrita> medicacoes =
      ObservableList<MedicacaoPrescrita>();

  Future<void> getData(Function(String) onError) async {
    isLoading = true;
    try {
      final result = await _medicacaoPrescritaRepository
          .getAllByPaciente(_appController.user.paciente);
      result.fold((l) => onError(l.message), (r) {
        medicacoes = (r ?? List<MedicacaoPrescrita>()).asObservable();
      });
    } catch (e) {
      onError(e.toString());
      isLoading = false;
    }
    isLoading = false;
  }
}
