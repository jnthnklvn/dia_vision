import 'package:dia_vision/app/shared/preferences/preferencias_preferences.dart';
import 'package:dia_vision/app/shared/local_storage/local_storage_shared.dart';
import 'package:dia_vision/app/shared/local_storage/i_local_storage.dart';
import 'package:dia_vision/app/repositories/user_repository.dart';
import 'package:dia_vision/app/shared/utils/route_enum.dart';
import 'package:dia_vision/app/model/user.dart';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import 'dart:async';

part 'app_controller.g.dart';

class AppController = _RegisterControllerBase with _$AppController;

abstract class _RegisterControllerBase with Store {
  final ILocalStorage _storage;
  final IUserRepository _userRepository;
  final PreferenciasPreferences _preferences;
  final AwesomeNotifications _awesomeNotifications;
  final _themeSwitch = ValueNotifier<bool>(false);

  bool get isDarkMode => _themeSwitch.value;
  ValueNotifier<bool> get themeSwitch => _themeSwitch;
  StreamSubscription<ReceivedAction>? receivedNotificationAction;

  @observable
  String? error;
  @observable
  User? user;

  _RegisterControllerBase(
    this._userRepository,
    this._awesomeNotifications,
    this._preferences,
    this._storage,
  ) {
    init();
  }

  Future init() async {
    await _storage.getBool('isDarkMode').then((value) {
      if (value != null) _themeSwitch.value = value;
    });
  }

  Future<bool?> toggleTheme(bool value) {
    _themeSwitch.value = value;
    return _storage.setBool('isDarkMode', value);
  }

  Future<bool> isLogged() async {
    user = user ?? await currentUser();
    return user != null;
  }

  Future<bool> hasPatient() async {
    user = user ?? await currentUser();
    return user?.paciente?.objectId != null;
  }

  Future<User?> currentUser() async {
    try {
      final result = await _userRepository.currentUser();
      return result.fold((l) => null, (r) {
        user = r;
        return user;
      });
    } catch (_) {
      return null;
    }
  }

  void startListenNotifications() {
    try {
      receivedNotificationAction = Modular.get<AwesomeNotifications>()
          .actionStream
          .listen((receivedNotification) async {
        if (receivedNotification.buttonKeyPressed.isNotEmpty == true) {
          final tempoLembrete =
              await _preferences.getTempoLembrete() ?? '10 min';
          final intTempoLembrete =
              int.tryParse(tempoLembrete.split(' ').elementAt(0)) ?? 10;
          await createNotification(
            (receivedNotification.id ?? 0) + 1001,
            title: receivedNotification.body,
            body: receivedNotification.body,
            notificationSchedule: NotificationAndroidCrontab(
              allowWhileIdle: true,
              preciseSchedules: [
                DateTime.now().toUtc().add(Duration(minutes: intTempoLembrete))
              ],
            ),
            tempoLembrete: tempoLembrete,
          );
          return;
        }
        await Modular.to.pushReplacementNamed('${RouteEnum.home.name}/');
        if (receivedNotification.title?.contains('glicemia') == true) {
          Modular.to.pushReplacementNamed('${RouteEnum.glicemy.name}/');
        } else {
          Modular.to.pushReplacementNamed('${RouteEnum.medications.name}/');
        }
      });
    } catch (_) {}
  }

  Future<bool> createNotification(
    int id, {
    String? title,
    String? body,
    NotificationSchedule? notificationSchedule,
    String? tempoLembrete,
  }) {
    return _awesomeNotifications.createNotification(
      actionButtons: [
        NotificationActionButton(
          label: "Adiar ${tempoLembrete ?? ''}",
          buttonType: ActionButtonType.KeepOnTop,
          key: title ?? '',
        ),
      ],
      schedule: notificationSchedule,
      content: NotificationContent(
        id: id,
        channelKey: 'basic_channel',
        title: title,
        body: body,
      ),
    );
  }

  Future<void> logout() async {
    user = null;
    try {
      Modular.get<LocalStorageShared>().clear();
      Modular.get<AwesomeNotifications>().cancelAllSchedules();
      receivedNotificationAction?.cancel();
      await _userRepository.logout();
    } catch (_) {}
  }
}
