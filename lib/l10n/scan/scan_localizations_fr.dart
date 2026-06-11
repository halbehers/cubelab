// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'scan_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class ScanLocalizationsFr extends ScanLocalizations {
  ScanLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get menu_caption => 'Scan';

  @override
  String get enter_manually => 'Entrer manuellement';

  @override
  String get new_cube_state => 'Nouvel état du cube';

  @override
  String get new_cube_state_description =>
      'Sélectionnez une couleur dans la palette en bas et touchez les autocollants du cube pour définir leur couleur. La face est déterminée par la couleur centrée.';

  @override
  String get next_face => 'Face suivante';

  @override
  String get previous_face => 'Face précédente';

  @override
  String get save_state => 'Commencer';

  @override
  String get review => 'Vérifier';

  @override
  String get error_invalid_color_count =>
      'Chaque couleur doit apparaître exactement 9 fois.';

  @override
  String get error_invalid_geometry =>
      'Cette combinaison n\'est pas un état de cube valide.';
}
