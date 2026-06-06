// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'settings_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class SettingsLocalizationsFr extends SettingsLocalizations {
  SettingsLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get menu_caption => 'Paramètres';

  @override
  String get title => 'Paramètres';

  @override
  String get display => 'Affichage';

  @override
  String get display_menu_caption => 'Afficher les labels du menu';

  @override
  String get language => 'Langue';

  @override
  String get language_system => 'Système';

  @override
  String get theme_mode => 'Thème';

  @override
  String get theme_mode_dark => 'Sombre';

  @override
  String get theme_mode_light => 'Clair';

  @override
  String get theme_mode_system => 'Système';

  @override
  String get effects => 'Effets';

  @override
  String get haptics_enabled => 'Haptiques activée';

  @override
  String get reset_button => 'Réinitialiser les paramètres';

  @override
  String get reset_button_confirm_content =>
      'Êtes-vous sûr de vouloir réinitialiser tous les paramètres ?';

  @override
  String get reset_button_confirm_action => 'Réinitialiser les paramètres';

  @override
  String get reset_button_confirm_cancel => 'Annuler';
}
