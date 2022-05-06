import 'package:dia_vision/app/shared/preferences/preferencias_preferences.dart';
import 'package:dia_vision/app/shared/local_storage/local_storage_shared.dart';
import 'package:dia_vision/app/shared/local_storage/i_local_storage.dart';
import 'package:dia_vision/app/shared/preferences/theme_preferences.dart';
import 'package:dia_vision/app/repositories/user_repository.dart';
import 'package:dia_vision/app/shared/utils/route_enum.dart';
import 'package:dia_vision/app/repositories/model/theme_params.dart';
import 'package:dia_vision/app/repositories/model/user.dart';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import 'dart:async';

part 'app_controller.g.dart';

const isVoiceFeedbackActiveKey = 'isVoiceFeedbackActive';
const isAccBttnVisibleKey = 'isAccBttnVisible';
final defaultThemeParams = ThemeParams(false, 1.0);

class AppController = _RegisterControllerBase with _$AppController;

abstract class _RegisterControllerBase with Store {
  final ILocalStorage _storage;
  final IUserRepository _userRepository;
  final PreferenciasPreferences _preferences;
  final ThemeParmasPreferences _themePreferences;
  final AwesomeNotifications _awesomeNotifications;
  final _themeSwitch = ValueNotifier<ThemeParams>(defaultThemeParams);
  final _voiceFeedbackSwitch = ValueNotifier<bool>(true);
  final _accBttnVisibilitySwitch = ValueNotifier<bool>(true);

  bool get isDarkMode => _themeSwitch.value.isDarkMode;
  bool get isVoiceFeedbackActive => _voiceFeedbackSwitch.value;
  bool get isAccBttnVisible => _accBttnVisibilitySwitch.value;
  double get fontScale => _themeSwitch.value.fontScale;

  ValueNotifier<ThemeParams> get themeSwitch => _themeSwitch;
  ValueNotifier<bool> get voiceFeedbackSwitch => _voiceFeedbackSwitch;
  ValueNotifier<bool> get accBttnVisibilitySwitch => _accBttnVisibilitySwitch;

  StreamSubscription<ReceivedAction>? receivedNotificationAction;

  @observable
  String? error;
  @observable
  User? user;

  _RegisterControllerBase(
    this._userRepository,
    this._awesomeNotifications,
    this._themePreferences,
    this._preferences,
    this._storage,
  ) {
    init();
  }

  Future init() async {
    await _themePreferences
        .getThemeParams()
        .then((value) => _themeSwitch.value = value ?? defaultThemeParams);
    await _storage
        .getBool(isVoiceFeedbackActiveKey)
        .then((value) => _voiceFeedbackSwitch.value = value ?? true);
    await _storage
        .getBool(isAccBttnVisibleKey)
        .then((value) => _accBttnVisibilitySwitch.value = value ?? true);
  }

  Future<bool?> toggleTheme(ThemeParams value) {
    _themeSwitch.value = value;
    return _themePreferences.setThemeParams(value);
  }

  Future<bool?> toggleVoiceFeedback(bool value) {
    _voiceFeedbackSwitch.value = value;
    return _storage.setBool(isVoiceFeedbackActiveKey, value);
  }

  Future<bool?> toggleAccBttnVisibility() {
    _accBttnVisibilitySwitch.value = !_accBttnVisibilitySwitch.value;
    return _storage.setBool(
        isAccBttnVisibleKey, _accBttnVisibilitySwitch.value);
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
