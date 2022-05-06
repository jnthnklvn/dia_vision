import 'package:dia_vision/app/repositories/alimentacao_repository.dart';
import 'package:dia_vision/app/shared/utils/file_utils.dart';
import 'package:dia_vision/app/shared/utils/csv_utils.dart';
import 'package:dia_vision/app/repositories/model/alimentacao.dart';
import 'package:dia_vision/app/app_controller.dart';

import 'package:mobx/mobx.dart';
import 'dart:io';

part 'alimentacao_controller.g.dart';

class AlimentacaoController = _AlimentacaoControllerBase
    with _$AlimentacaoController;

abstract class _AlimentacaoControllerBase with Store, CsvUtils, FileUtils {
  final IAlimentacaoRepository _alimentacaoRepository;
  final AppController _appController;

  _AlimentacaoControllerBase(
    this._alimentacaoRepository,
    this._appController,
  );

  @observable
  bool isLoading = false;
  @observable
  ObservableList<Alimentacao> alimentacoes = ObservableList<Alimentacao>();

  Future<void> getData(Function(String) onError) async {
    isLoading = true;
    try {
      final result = await _alimentacaoRepository
          .getAllByPaciente(_appController.user!.paciente!);
      result.fold((l) => onError(l.message), (r) {
        alimentacoes = (r).asObservable();
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
      String? csv = mapListToCsv(alimentacoes.map((e) => e.toMap()).toList());
      if (csv != null) {
        return await save(csv, path);
      }
    } catch (e) {
      onError(e.toString());
    }
    return null;
  }
}
