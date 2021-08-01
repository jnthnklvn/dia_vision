import 'package:dia_vision/app/shared/preferences/preferencias_preferences.dart';
import 'package:dia_vision/app/repositories/glicemia_repository.dart';
import 'package:dia_vision/app/shared/utils/file_utils.dart';
import 'package:dia_vision/app/shared/utils/csv_utils.dart';
import 'package:dia_vision/app/app_controller.dart';
import 'package:dia_vision/app/model/glicemia.dart';

import 'package:mobx/mobx.dart';
import 'dart:io';

part 'glicemia_controller.g.dart';

class GlicemiaController = _GlicemiaControllerBase with _$GlicemiaController;

abstract class _GlicemiaControllerBase with Store, CsvUtils, FileUtils {
  final IGlicemiaRepository _glicemiaRepository;
  final PreferenciasPreferences _preferences;
  final AppController _appController;

  _GlicemiaControllerBase(
    this._glicemiaRepository,
    this._appController,
    this._preferences,
  );

  @observable
  bool isLoading = false;
  @observable
  bool isValorPadraoGlicemia;

  @observable
  ObservableList<Glicemia> glicemias = ObservableList<Glicemia>();

  Future<void> checkValoresGlicemia() async {
    final valorMaxGlic = await _preferences.getValorMaximoGlicemia();
    final valorMinGlic = await _preferences.getValorMinimoGlicemia();
    isValorPadraoGlicemia =
        (await _preferences.getIsValorPadraoGlicemia()) ?? true;

    if (valorMinGlic == null || valorMaxGlic == null)
      isValorPadraoGlicemia = true;
  }

  Future<bool> setIsValorPadraoGlicemia(bool newValue) async {
    isValorPadraoGlicemia = newValue;
    return _preferences.setIsValorPadraoGlicemia(newValue);
  }

  Future<void> getData(Function(String) onError) async {
    isLoading = true;
    try {
      checkValoresGlicemia();
      final result = await _glicemiaRepository
          .getAllByPaciente(_appController.user.paciente);
      result.fold((l) => onError(l.message), (r) {
        glicemias = (r ?? List<Glicemia>()).asObservable();
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
      String csv = mapListToCsv(glicemias.map((e) => e.toMap()).toList());
      return await save(csv, path);
    } catch (e) {
      onError(e.toString());
    }
    return null;
  }
}
