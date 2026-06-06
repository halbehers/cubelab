import 'package:cubelab/l10n/settings/settings_localizations.dart';
import 'package:flutter/material.dart';
import 'package:cubelab/providers/settings_provider.dart';
import 'package:cubelab/ui/form/fields/toggle_switch_setting.dart';

class ThemeModeToggleSwitchField extends StatelessWidget {
  const ThemeModeToggleSwitchField({super.key, this.label});

  final String? label;

  @override
  Widget build(BuildContext context) {
    final t = SettingsLocalizations.of(context)!;
    final settingsProvider = SettingsProvider.of(context);

    Map<ThemeMode, String> labelByThemeModes = {
      ThemeMode.light: t.theme_mode_light,
      ThemeMode.dark: t.theme_mode_dark,
      ThemeMode.system: t.theme_mode_system,
    };

    return ToggleSwitchField(
      label: label ?? t.theme_mode,
      initialValue: settingsProvider.themeMode,
      onValueChanged: settingsProvider.setThemeMode,
      items: ThemeMode.values
          .map(
            (mode) =>
                ToggleSwitchItem(label: labelByThemeModes[mode]!, value: mode),
          )
          .toList(),
    );
  }
}
