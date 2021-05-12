import 'package:dia_vision/app/shared/local_storage/local_storage_shared.dart';
import 'package:dia_vision/app/repositories/user_repository.dart';
import 'package:dia_vision/app/shared/utils/route_enum.dart';
import 'package:dia_vision/app/model/user.dart';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'dart:async';

part 'app_controller.g.dart';

class AppController = _RegisterControllerBase with _$AppController;

abstract class _RegisterControllerBase with Store {
  final IUserRepository _userRepository;

  _RegisterControllerBase(this._userRepository);

  @observable
  String error;
  @observable
  User user;

  StreamSubscription<ReceivedAction> receivedNotificationAction;

  Future<bool> isLogged() async {
    user = user ?? await currentUser();
    return user != null;
  }

  Future<User> currentUser() async {
    try {
      final result = await _userRepository.currentUser();
      return result?.fold((l) => null, (r) {
        user = r;
        return user;
      });
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  void startListenNotifications() {
    try {
      receivedNotificationAction = Modular.get<AwesomeNotifications>()
          .actionStream
          .listen((receivedNotification) {
        Modular.to.pushReplacementNamed(RouteEnum.medications.name);
      });
    } catch (e) {}
  }

  Future<void> logout() async {
    user = null;
    try {
      Modular.get<LocalStorageShared>().clear();
      Modular.get<AwesomeNotifications>().cancelAllSchedules();
      receivedNotificationAction?.cancel();
      await _userRepository.logout();
    } catch (e) {
      print(e.toString());
    }
  }
}
