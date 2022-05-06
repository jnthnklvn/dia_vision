import 'package:dia_vision/app/repositories/avaliacao_pes_repository.dart';
import 'package:dia_vision/app/shared/utils/file_utils.dart';
import 'package:dia_vision/app/shared/utils/csv_utils.dart';
import 'package:dia_vision/app/repositories/model/avaliacao_pes.dart';
import 'package:dia_vision/app/app_controller.dart';

import 'package:mobx/mobx.dart';
import 'dart:io';

part 'avaliacao_pes_controller.g.dart';

class AvaliacaoPesController = _AvaliacaoPesControllerBase
    with _$AvaliacaoPesController;

abstract class _AvaliacaoPesControllerBase with Store, CsvUtils, FileUtils {
  final IAvaliacaoPesRepository _avaliacaoPesRepository;
  final AppController _appController;

  _AvaliacaoPesControllerBase(
    this._avaliacaoPesRepository,
    this._appController,
  );

  @observable
  bool isLoading = false;
  @observable
  ObservableList<AvaliacaoPes> avaliacoes = ObservableList<AvaliacaoPes>();

  Future<void> getData(Function(String) onError) async {
    isLoading = true;
    try {
      final result = await _avaliacaoPesRepository
          .getAllByPaciente(_appController.user!.paciente!);
      result.fold((l) => onError(l.message), (r) {
        avaliacoes = (r).asObservable();
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
      String? csv = mapListToCsv(avaliacoes.map((e) => e.toMap()).toList());
      if (csv != null) {
        return await save(csv, path);
      }
    } catch (e) {
      onError(e.toString());
    }
    return null;
  }
}
