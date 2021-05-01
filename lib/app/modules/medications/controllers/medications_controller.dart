import 'package:dia_vision/app/repositories/medicacao_prescrita_repository.dart';
import 'package:dia_vision/app/model/medicacao_prescrita.dart';
import 'package:dia_vision/app/shared/utils/date_utils.dart';
import 'package:dia_vision/app/shared/utils/file_utils.dart';
import 'package:dia_vision/app/shared/utils/csv_utils.dart';
import 'package:dia_vision/app/app_controller.dart';

import 'package:mobx/mobx.dart';
import 'dart:io';

part 'medications_controller.g.dart';

class MedicationsController = _MedicationsControllerBase
    with _$MedicationsController;

abstract class _MedicationsControllerBase
    with Store, DateUtils, CsvUtils, FileUtils {
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

  Future<File> getRelatorioCsvFile(
      Function(String) onError, String path) async {
    try {
      String csv = mapListToCsv(medicacoes.map((e) => e.toMap()).toList());
      return await save(csv, path);
    } catch (e) {
      onError(e.toString());
    }
    return null;
  }
}
