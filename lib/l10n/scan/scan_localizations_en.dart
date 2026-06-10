// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'scan_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class ScanLocalizationsEn extends ScanLocalizations {
  ScanLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get menu_caption => 'Scan';

  @override
  String get enter_manually => 'Enter manually';

  @override
  String get new_cube_state => 'New cube state';

  @override
  String get new_cube_state_description =>
      'Select a color from the palette at the bottom and tap on the cube stickers to set their color. The face is determined by the centered color.';

  @override
  String get next_face => 'Next face';

  @override
  String get previous_face => 'Previous face';

  @override
  String get save_state => 'Get started';

  @override
  String get review => 'Review';
}
