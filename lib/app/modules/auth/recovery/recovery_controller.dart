import 'package:dia_vision/app/repositories/user_repository.dart';
import 'package:dia_vision/app/shared/utils/utils.dart';
import 'package:dia_vision/app/model/user.dart';

import 'package:mobx/mobx.dart';

part 'recovery_controller.g.dart';

class RecoveryController = _RecoveryControllerBase with _$RecoveryController;

abstract class _RecoveryControllerBase with Store {
  final IUserRepository _userRepository;
  final Utils _utils;

  _RecoveryControllerBase(this._userRepository, this._utils);

  @observable
  String email;
  @observable
  bool isLoading = false;

  @computed
  String get emailError => _utils.isValidEmail(email) ? null : "Email inválido";

  @computed
  bool get isValid => email != null && emailError == null;

  @action
  void setEmail(String newEmail) => email = newEmail;

  Future<void> recovery(
      Function(String) onError, void Function() onSuccess) async {
    if (!isValid) return;
    isLoading = true;

    try {
      final result = await _userRepository.requestPasswordReset(User(email, email: email));
      result.fold((l) => onError(l.message), (r) => onSuccess());
    } catch (e) {
      onError(e.toString());
    }

    isLoading = false;
  }
}
