import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'scan_localizations_en.dart';
import 'scan_localizations_es.dart';
import 'scan_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of ScanLocalizations
/// returned by `ScanLocalizations.of(context)`.
///
/// Applications need to include `ScanLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'scan/scan_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: ScanLocalizations.localizationsDelegates,
///   supportedLocales: ScanLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the ScanLocalizations.supportedLocales
/// property.
abstract class ScanLocalizations {
  ScanLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static ScanLocalizations? of(BuildContext context) {
    return Localizations.of<ScanLocalizations>(context, ScanLocalizations);
  }

  static const LocalizationsDelegate<ScanLocalizations> delegate =
      _ScanLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('fr'),
  ];

  /// Scan menu caption
  ///
  /// In en, this message translates to:
  /// **'Scan'**
  String get menu_caption;

  /// Button to enter cube state manually
  ///
  /// In en, this message translates to:
  /// **'Enter manually'**
  String get enter_manually;

  /// Title of the bottom sheet to enter cube state manually
  ///
  /// In en, this message translates to:
  /// **'New cube state'**
  String get new_cube_state;

  /// Description of how to enter cube state manually
  ///
  /// In en, this message translates to:
  /// **'Select a color from the palette at the bottom and tap on the cube stickers to set their color. The face is determined by the centered color.'**
  String get new_cube_state_description;

  /// Button to go to the next face when entering cube state manually
  ///
  /// In en, this message translates to:
  /// **'Next face'**
  String get next_face;

  /// Button to go to the previous face when entering cube state manually
  ///
  /// In en, this message translates to:
  /// **'Previous face'**
  String get previous_face;

  /// Button to save the entered cube state and start solving
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get save_state;

  /// Button to review the entered cube state before saving
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get review;

  /// Error message for invalid color count in cube scan
  ///
  /// In en, this message translates to:
  /// **'Each color must appear exactly 9 times.'**
  String get error_invalid_color_count;

  /// Error message for invalid geometry in cube scan
  ///
  /// In en, this message translates to:
  /// **'This combination is not a valid cube state.'**
  String get error_invalid_geometry;
}

class _ScanLocalizationsDelegate
    extends LocalizationsDelegate<ScanLocalizations> {
  const _ScanLocalizationsDelegate();

  @override
  Future<ScanLocalizations> load(Locale locale) {
    return SynchronousFuture<ScanLocalizations>(
      lookupScanLocalizations(locale),
    );
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_ScanLocalizationsDelegate old) => false;
}

ScanLocalizations lookupScanLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return ScanLocalizationsEn();
    case 'es':
      return ScanLocalizationsEs();
    case 'fr':
      return ScanLocalizationsFr();
  }

  throw FlutterError(
    'ScanLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
