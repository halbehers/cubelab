import 'package:cubelab/l10n/settings/settings_localizations.dart';
import 'package:cubelab/pages/main_page.dart';
import 'package:cubelab/providers/settings_provider.dart';
import 'package:cubelab/ui/form/fields/locale_select_field.dart';
import 'package:cubelab/ui/form/fields/switch_field.dart';
import 'package:cubelab/ui/form/fields/theme_mode_toggle_switch_field.dart';
import 'package:cubelab/ui/settings/reset_setting_button.dart';
import 'package:cubelab/ui/settings/setting_section.dart';
import 'package:flutter/material.dart';

class SettingsPage extends MainPage {
  const SettingsPage({super.key});

  @override
  PageID getID() => PageID.settings;

  @override
  Widget buildPage(BuildContext context) {
    final t = SettingsLocalizations.of(context)!;
    final settingsProvider = SettingsProvider.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsetsDirectional.fromSTEB(32, 16, 32, 86),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SettingSection(
            title: t.display,
            items: [
              const ThemeModeToggleSwitchField(),
              SwitchField(
                label: t.display_menu_caption,
                initialValue: settingsProvider.displayMenuCaptions,
                onValueChanged: settingsProvider.setDisplayMenuCaptions,
              ),
              const LocaleSelectField(),
            ],
          ),

          SettingSection(
            title: t.effects,
            items: [
              SwitchField(
                label: t.haptics_enabled,
                initialValue: settingsProvider.hapticEnabled,
                onValueChanged: settingsProvider.setHapticEnabled,
              ),
            ],
          ),
          const ResetSettingButton(),
          // TODO: About
        ],
      ),
    );
  }
}
