import 'package:dia_vision/app/repositories/user_repository.dart';
import 'package:dia_vision/app/shared/utils/utils.dart';
import 'package:dia_vision/app/model/user.dart';

import 'package:mobx/mobx.dart';

part 'register_controller.g.dart';

class RegisterController = _RegisterControllerBase with _$RegisterController;

abstract class _RegisterControllerBase with Store {
  final IUserRepository _userRepository;
  final Utils _utils;

  _RegisterControllerBase(this._userRepository, this._utils);

  @observable
  String? email;
  @observable
  String? password;
  @observable
  bool isPasswordHide = true;
  @observable
  bool isLoading = false;

  @computed
  String? get emailError =>
      _utils.isValidEmail(email) ? null : "Email inválido";

  @computed
  String? get passwordError => password != null && password!.length < 4
      ? "Deve ter pelo menos 4 digitos"
      : null;

  @computed
  bool get isValid =>
      email != null &&
      password != null &&
      emailError == null &&
      passwordError == null;

  @action
  void setEmail(String? newEmail) => email = newEmail;

  @action
  void setPassword(String? newPassword) => password = newPassword;

  @action
  void setIsPasswordHide() => isPasswordHide = !isPasswordHide;

  Future<void> register(
      Function(String) onError, void Function() onSuccess) async {
    if (!isValid) return;
    isLoading = true;

    try {
      final result = await _userRepository
          .signUp(User(username: email, password: password, email: email));
      result.fold((l) => onError(l.message), (r) => onSuccess());
    } catch (e) {
      onError(e.toString());
    }

    isLoading = false;
  }
}
