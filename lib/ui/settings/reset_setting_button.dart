import 'package:cubelab/l10n/settings/settings_localizations.dart';
import 'package:flutter/material.dart';
import 'package:cubelab/main.dart';
import 'package:cubelab/providers/settings_provider.dart';
import 'package:cubelab/theme/app_theme.dart';
import 'package:cubelab/ui/settings/button_setting.dart';

class ResetSettingButton extends StatelessWidget {
  const ResetSettingButton({super.key, this.label});

  final String? label;

  @override
  Widget build(BuildContext context) {
    AppTheme appTheme = context.appTheme;
    final t = SettingsLocalizations.of(context)!;
    final settingsProvider = SettingsProvider.of(context);

    return ButtonSetting(
      label: label ?? t.reset_button,
      backgroundColor: appTheme.dangerBackgroundColor,
      textStyle: appTheme.dangerBody,
      onTap: () => settingsProvider.resetSettings(),
      withConfirm: ButtonSettingConfirm(
        content: t.reset_button_confirm_content,
        confirmText: t.reset_button_confirm_action,
        cancelText: t.reset_button_confirm_cancel,
      ),
    );
  }
}
