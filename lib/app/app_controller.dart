import 'package:dia_vision/app/repositories/user_repository.dart';
import 'package:dia_vision/app/model/user.dart';

import 'package:mobx/mobx.dart';

part 'app_controller.g.dart';

class AppController = _RegisterControllerBase with _$AppController;

abstract class _RegisterControllerBase with Store {
  final IUserRepository _userRepository;

  _RegisterControllerBase(this._userRepository);

  @observable
  String error;
  @observable
  User user;

  Future<bool> isLogged() async {
    try {
      final result = await _userRepository.currentUser();
      return result.fold((l) => false, (r) {
        if (r == null) return false;
        user = r;
        return true;
      });
    } catch (e) {
      return false;
    }
  }

  Future<void> logout() async {
    try {
      await _userRepository.logout();
    } catch (e) {}
  }
}
