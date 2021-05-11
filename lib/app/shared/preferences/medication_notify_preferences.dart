import 'package:dia_vision/app/shared/local_storage/i_local_storage.dart';
import 'package:dia_vision/app/model/medication_notify.dart';

class MedicationNotifyPreferences {
  final ILocalStorage _preferences;

  MedicationNotifyPreferences(this._preferences);

  Future<bool> setMedicationNotify(
      String objectId, MedicationNotify medicationNotify) async {
    if (medicationNotify == null) return false;
    return _preferences.setString(objectId, medicationNotify.toJson());
  }

  Future<bool> removeMedicationNotify(String objectId) {
    return _preferences.remove(objectId);
  }

  Future<MedicationNotify> getMedicationNotify(String objectId) async {
    String jsonPref = await _preferences.getString(objectId) ?? null;
    if (jsonPref != null) return MedicationNotify.fromJson(jsonPref);
    return null;
  }
}
