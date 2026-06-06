// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'settings_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class SettingsLocalizationsEn extends SettingsLocalizations {
  SettingsLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get menu_caption => 'Settings';

  @override
  String get title => 'Settings';

  @override
  String get display => 'Display';

  @override
  String get display_menu_caption => 'Display menu caption';

  @override
  String get language => 'Language';

  @override
  String get language_system => 'System';

  @override
  String get theme_mode => 'Theme Mode';

  @override
  String get theme_mode_dark => 'Dark';

  @override
  String get theme_mode_light => 'Light';

  @override
  String get theme_mode_system => 'System';

  @override
  String get effects => 'Effects';

  @override
  String get haptics_enabled => 'Haptics enabled';

  @override
  String get reset_button => 'Reset settings';

  @override
  String get reset_button_confirm_content =>
      'Are you sure to reset all settings?';

  @override
  String get reset_button_confirm_action => 'Reset settings';

  @override
  String get reset_button_confirm_cancel => 'Cancel';
}
