import 'package:cubelab/db/models/setting.dart';
import 'package:cubelab/db/repositories/repository.dart';
import 'package:cubelab/db/services/database_service.dart';

class SettingsRepository extends Repository<Setting> {
  SettingsRepository({super.settingsProvider});

  @override
  String getTable() {
    return DatabaseTable.settings;
  }

  @override
  Setting newEntity() {
    return Setting(settingsProvider: settingsProvider);
  }
}
