import 'package:dia_vision/app/repositories/app_visao_repository.dart';
import 'package:dia_vision/app/shared/utils/string_utils.dart';
import 'package:dia_vision/app/repositories/model/app_visao.dart';

import 'package:mobx/mobx.dart';
import 'dart:io';

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
        r.removeWhere(
          (element) => Platform.isIOS
              ? isNullOrEmpty(element.linkAppleStore)
              : isNullOrEmpty(element.linkGooglePlay),
        );
        apps = (r).asObservable();
      });
    } catch (e) {
      onError(e.toString());
      isLoading = false;
    }
    isLoading = false;
  }
}
