import 'package:dia_vision/app/repositories/diurese_repository.dart';
import 'package:dia_vision/app/shared/utils/file_utils.dart';
import 'package:dia_vision/app/shared/utils/csv_utils.dart';
import 'package:dia_vision/app/app_controller.dart';
import 'package:dia_vision/app/repositories/model/diurese.dart';

import 'package:mobx/mobx.dart';
import 'dart:io';

part 'diurese_controller.g.dart';

class DiureseController = _DiureseControllerBase with _$DiureseController;

abstract class _DiureseControllerBase with Store, CsvUtils, FileUtils {
  final IDiureseRepository _diureseRepository;
  final AppController _appController;

  _DiureseControllerBase(
    this._diureseRepository,
    this._appController,
  );

  @observable
  bool isLoading = false;
  @observable
  ObservableList<Diurese> diureses = ObservableList<Diurese>();

  Future<void> getData(Function(String) onError) async {
    isLoading = true;
    try {
      final result = await _diureseRepository
          .getAllByPaciente(_appController.user!.paciente!);
      result.fold((l) => onError(l.message), (r) {
        diureses = (r).asObservable();
      });
    } catch (e) {
      onError(e.toString());
      isLoading = false;
    }
    isLoading = false;
  }

  Future<File?> getRelatorioCsvFile(
      Function(String) onError, String path) async {
    try {
      String? csv = mapListToCsv(diureses.map((e) => e.toMap()).toList());
      if (csv != null) {
        return await save(csv, path);
      }
    } catch (e) {
      onError(e.toString());
    }
    return null;
  }
}
