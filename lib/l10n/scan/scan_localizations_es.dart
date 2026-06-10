// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'scan_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class ScanLocalizationsEs extends ScanLocalizations {
  ScanLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get menu_caption => 'Escanear';

  @override
  String get enter_manually => 'Introducir manualmente';

  @override
  String get new_cube_state => 'Nuevo estado del cubo';

  @override
  String get new_cube_state_description =>
      'Seleccione un color de la paleta en la parte inferior y toque las pegatinas del cubo para establecer su color. La cara se determina por el color central.';

  @override
  String get next_face => 'Siguiente cara';

  @override
  String get previous_face => 'Face anterior';

  @override
  String get save_state => 'Empezar';

  @override
  String get review => 'Revisar';
}
