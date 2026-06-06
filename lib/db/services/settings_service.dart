import 'package:cubelab/db/models/setting.dart';
import 'package:cubelab/db/repositories/repository.dart';
import 'package:cubelab/db/repositories/settings_repository.dart';
import 'package:cubelab/db/services/service.dart';
import 'package:cubelab/providers/settings_provider.dart';

class SettingsService extends Service<Setting> {
  SettingsService({super.settingsProvider});

  static String selectedCalendarViewIndexId = "selected-calendar-view-index";
  static String displayMenuCaptionsId = "display-menu-caption";
  static String selectedThemeModeId = "selected-theme-mode";
  static String selectedLocaleId = "selected-locale";
  static String selectedCalendarId = "selected-calendar";
  static String hapticsEnabledId = "haptics-enabled";
  static String defaultEventDurationId = "default-event-duration";
  static String selectedTimezoneId = "selected-timezone";

  @override
  Repository<Setting> newRepository(SettingsProvider? settingsProvider) {
    return SettingsRepository(settingsProvider: settingsProvider);
  }

  void setupByName<T>(
    String name,
    T value, {
    SettingValueType? valueType,
  }) async {
    final List<Setting> existingSetting = await repository.findBy(
      where: "name = ?",
      whereArgs: [name],
    );
    if (existingSetting.isEmpty) {
      final Setting newEntity = repository.newEntity();
      newEntity.name = name;
      newEntity.value = value.toString();
      newEntity.valueType = valueType ?? SettingValueType.string;
      await create(newEntity);
    } else {
      final Setting entity = existingSetting.first;
      entity.value = value.toString();
      entity.valueType = valueType ?? SettingValueType.string;
      await update(entity);
    }
  }

  Future<Setting?> findByName(String name) async {
    return (await repository.findBy(
      where: "name = ?",
      whereArgs: [name],
    )).firstOrNull;
  }

  void deleteByName(String name) async {
    final List<Setting> existingSetting = await repository.findBy(
      where: "name = ?",
      whereArgs: [name],
    );
    if (existingSetting.isEmpty) return;

    await delete(existingSetting.first);
  }
}
