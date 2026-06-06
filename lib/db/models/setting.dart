import 'package:cubelab/db/models/model.dart';

enum SettingValueType { number, string, boolean }

class Setting extends Model<Setting> {
  Setting({super.settingsProvider});

  String name = "";
  String? value;
  SettingValueType valueType = SettingValueType.string;

  @override
  Map<String, Object?> getValuesMap() {
    return {"name": name, "value": value, "value_type": valueType.name};
  }

  @override
  Setting fillFromValues(Map<String, Object?> values) {
    if (values["id"] != null) {
      id = values["id"] as int;
    }
    if (values["name"] != null) {
      name = values["name"] as String;
    }
    value = values["value"] == "null" ? null : values["value"] as String;
    if (values["valueType"] != null) {
      switch (values["valueType"]) {
        case "string":
          valueType = SettingValueType.string;
        case "number":
          valueType = SettingValueType.number;
        case "boolean":
          valueType = SettingValueType.boolean;
        default:
          valueType = SettingValueType.string;
      }
    }
    return this;
  }
}
