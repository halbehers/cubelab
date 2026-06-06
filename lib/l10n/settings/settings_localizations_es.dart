// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'settings_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class SettingsLocalizationsEs extends SettingsLocalizations {
  SettingsLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get menu_caption => 'Configuración';

  @override
  String get title => 'Configuración';

  @override
  String get display => 'Pantalla';

  @override
  String get display_menu_caption => 'Mostrar las etiquetas del menú';

  @override
  String get language => 'Idioma';

  @override
  String get language_system => 'Sistema';

  @override
  String get theme_mode => 'Tema';

  @override
  String get theme_mode_dark => 'Oscuro';

  @override
  String get theme_mode_light => 'Claro';

  @override
  String get theme_mode_system => 'Sistema';

  @override
  String get effects => 'Efectos';

  @override
  String get haptics_enabled => 'Haptics habilitado';

  @override
  String get reset_button => 'Restablecer configuración';

  @override
  String get reset_button_confirm_content =>
      '¿Está seguro de que desea restablecer todos los ajustes?';

  @override
  String get reset_button_confirm_action => 'Restablecer configuración';

  @override
  String get reset_button_confirm_cancel => 'Cancelar';
}
