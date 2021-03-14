import 'package:dia_vision/app/repositories/user_repository.dart';
import 'package:dia_vision/app/shared/utils/utils.dart';
import 'package:dia_vision/app/model/user.dart';

import 'package:mobx/mobx.dart';

part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final IUserRepository _userRepository;
  final Utils _utils;

  _LoginControllerBase(this._userRepository, this._utils);

  @observable
  String email;
  @observable
  String password;
  @observable
  bool isPasswordHide = true;
  @observable
  bool isLoading = false;

  @computed
  String get emailError => _utils.isValidEmail(email) ? null : "Email inválido";

  @computed
  String get passwordError => password != null && password.length < 4
      ? "Deve ter pelo menos 4 digitos"
      : null;

  @computed
  bool get isValid =>
      email != null &&
      password != null &&
      emailError == null &&
      passwordError == null;

  @action
  void setEmail(String newEmail) => email = newEmail;

  @action
  void setPassword(String newPassword) => password = newPassword;

  @action
  void setIsPasswordHide() => isPasswordHide = !isPasswordHide;

  Future<void> login(
      Function(String) onError, void Function() onSuccess) async {
    if (!isValid) return;
    isLoading = true;

    try {
      final result = await _userRepository.login(User(email, password: password, email: email));
      result.fold((l) => onError(l.message), (r) => onSuccess());
    } catch (e) {
      onError(e.toString());
    }

    isLoading = false;
  }
}
