import 'package:dia_vision/app/repositories/diurese_repository.dart';
import 'package:dia_vision/app/shared/utils/date_utils.dart';
import 'package:dia_vision/app/app_controller.dart';
import 'package:dia_vision/app/repositories/model/diurese.dart';

import 'package:mobx/mobx.dart';

import 'diurese_controller.dart';

part 'diurese_register_controller.g.dart';

class DiureseRegisterController = _DiureseRegisterControllerBase
    with _$DiureseRegisterController;

abstract class _DiureseRegisterControllerBase with Store, DateUtil {
  final IDiureseRepository _diureseRepository;
  final DiureseController _diureseController;
  final AppController _appController;

  _DiureseRegisterControllerBase(
    this._diureseRepository,
    this._diureseController,
    this._appController,
  );

  @observable
  String? coloracao;
  @observable
  String? volume;
  @observable
  bool ardor = false;

  @observable
  bool isLoading = false;
  @observable
  List<Diurese> diureses = [];

  Diurese? _diurese;

  @computed
  bool get isEdicao => _diurese != null;

  @action
  void setColoracao(String? newValue) => coloracao = newValue;
  @action
  void setVolume(String? newValue) => volume = newValue;
  @action
  void setArdor(bool newValue) => ardor = newValue;

  void init(Diurese? diurese) {
    _diurese = diurese;
    if (diurese != null) {
      setVolume(diurese.volume?.toString());
      setColoracao(diurese.coloracao);
      setArdor(diurese.ardor ?? ardor);
    }
  }

  Future<void> save(Function(String) onError, void Function() onSuccess) async {
    isLoading = true;

    try {
      final diurese = Diurese(ardor: ardor, coloracao: coloracao);

      final user = await _appController.currentUser();
      diurese.paciente = user!.paciente;
      diurese.objectId = _diurese?.objectId;

      final dVolume =
          volume != null ? num.tryParse(volume!.replaceAll(',', '.')) : null;
      if (dVolume != null) diurese.volume = dVolume;

      final result = await _diureseRepository.save(diurese, user);
      result.fold((l) => onError(l.message), (r) {
        final idx = _diureseController.diureses
            .indexWhere((e) => e.objectId == r.objectId);
        if (idx == -1) {
          _diureseController.diureses.insert(0, r);
        } else {
          r.createdAt = _diureseController.diureses[idx].createdAt;
          _diureseController.diureses[idx] = r;
        }
        onSuccess();
      });
    } catch (e) {
      onError(e.toString());
    }

    isLoading = false;
  }
}
