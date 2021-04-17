import 'package:dia_vision/app/repositories/app_visao_repository.dart';
import 'package:dia_vision/app/model/app_visao.dart';

import 'package:mobx/mobx.dart';

part 'app_visao_register_controller.g.dart';

class AppVisaoRegisterController = _AppVisaoRegisterControllerBase
    with _$AppVisaoRegisterController;

abstract class _AppVisaoRegisterControllerBase with Store {
  final IAppVisaoRepository _appVisaoRepository;

  _AppVisaoRegisterControllerBase(this._appVisaoRepository);

  @observable
  String descricao;
  @observable
  String titulo;
  @observable
  String linkGooglePlay;
  @observable
  String linkAppleStore;

  @observable
  bool isLoading = false;

  @action
  void setDescricao(String newValue) => descricao = newValue;
  @action
  void setLinkAppleStore(String newValue) => linkAppleStore = newValue;
  @action
  void setTitulo(String newValue) => titulo = newValue;
  @action
  void setLinkGooglePlay(String newValue) => linkGooglePlay = newValue;

  Future<void> save(Function(String) onError, void Function() onSuccess) async {
    isLoading = true;

    try {
      final appVisao = AppVisao(
        descricao: descricao,
        titulo: titulo,
        linkAppleStore: linkAppleStore,
        linkGooglePlay: linkGooglePlay,
      );

      final result = await _appVisaoRepository.save(appVisao);
      result.fold((l) => onError(l.message), (r) => onSuccess());
    } catch (e) {
      onError(e.toString());
    }

    isLoading = false;
  }
}
