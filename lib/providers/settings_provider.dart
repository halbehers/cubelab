import 'package:cubelab/db/models/setting.dart';
import 'package:cubelab/db/services/settings_service.dart';
import 'package:cubelab/l10n/general/general_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SettingsProvider extends ChangeNotifier {
  late final service = SettingsService(settingsProvider: this);

  bool _initialized = false;
  bool get initialized => _initialized;

  SettingsProvider() {
    _init();
  }

  static SettingsProvider of(BuildContext context, {bool listen = true}) =>
      Provider.of<SettingsProvider>(context, listen: listen);

  void _init() async {
    {
      Setting? setting = await service.findByName(
        SettingsService.selectedLocaleId,
      );

      if (setting != null) {
        setSettingLocale(
          setting.value != null
              ? SettingLocale.fromLanguageCode(setting.value!)
              : SettingLocale.empty,
          persistChange: false,
        );
      }
    }
    {
      Setting? setting = await service.findByName(
        SettingsService.displayMenuCaptionsId,
      );

      if (setting != null) {
        setDisplayMenuCaptions(setting.value == "true", persistChange: false);
      }
    }
    {
      Setting? setting = await service.findByName(
        SettingsService.selectedThemeModeId,
      );

      if (setting != null) {
        setThemeMode(
          ThemeMode.values.singleWhere((mode) => mode.name == setting.value),
          persistChange: false,
        );
      }
    }
    {
      Setting? setting = await service.findByName(
        SettingsService.hapticsEnabledId,
      );

      if (setting != null) {
        setHapticEnabled(setting.value == "true", persistChange: false);
      }
    }

    _initialized = true;
    notifyListeners();
  }

  static final SettingLocale settingLocaleDefaultValue = SettingLocale.empty;

  SettingLocale _settingLocale = settingLocaleDefaultValue;

  SettingLocale get settingLocale => _settingLocale;

  void setSettingLocale(SettingLocale locale, {bool persistChange = true}) {
    if (locale.isEmpty() ||
        !GeneralLocalizations.supportedLocales.contains(locale.locale)) {
      _settingLocale = SettingLocale.empty;
    }

    _settingLocale = locale;
    notifyListeners();
    if (persistChange) {
      service.setupByName(
        SettingsService.selectedLocaleId,
        locale.locale.toString(),
      );
    }
  }

  void resetSettingLocale({bool persistChange = true}) {
    _settingLocale = settingLocaleDefaultValue;
    notifyListeners();

    if (persistChange) {
      service.deleteByName(SettingsService.selectedLocaleId);
    }
  }

  static const bool displayMenuCaptionsDefaultValue = false;

  bool _displayMenuCaptions = displayMenuCaptionsDefaultValue;

  bool get displayMenuCaptions => _displayMenuCaptions;

  void setDisplayMenuCaptions(
    bool displayMenuCaptions, {
    bool persistChange = true,
  }) {
    _displayMenuCaptions = displayMenuCaptions;
    notifyListeners();
    if (persistChange) {
      service.setupByName(
        SettingsService.displayMenuCaptionsId,
        displayMenuCaptions ? "true" : "false",
        valueType: SettingValueType.boolean,
      );
    }
  }

  void resetDisplayMenuCaptions({bool persistChange = true}) {
    _displayMenuCaptions = displayMenuCaptionsDefaultValue;
    notifyListeners();

    if (persistChange) {
      service.deleteByName(SettingsService.displayMenuCaptionsId);
    }
  }

  static const ThemeMode themeModeDefaultValue = ThemeMode.system;

  List<int> generateFibonacci(int n) {
    List<int> fib = [0, 1];
    for (int i = 2; i < n; i++) {
      fib.add(fib[i - 1] + fib[i - 2]);
    }
    return fib;
  }

  ThemeMode _themeMode = themeModeDefaultValue;

  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode themeMode, {bool persistChange = true}) {
    _themeMode = themeMode;

    // FIXME
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: themeMode == ThemeMode.dark
            ? Brightness.light
            : Brightness.dark,
        statusBarBrightness: themeMode == ThemeMode.dark
            ? Brightness.dark
            : Brightness.light,
      ),
    );

    notifyListeners();
    if (persistChange) {
      service.setupByName(SettingsService.selectedThemeModeId, themeMode.name);
    }
  }

  void resetThemeMode({bool persistChange = true}) {
    _themeMode = themeModeDefaultValue;
    notifyListeners();

    if (persistChange) {
      service.deleteByName(SettingsService.selectedThemeModeId);
    }
  }

  static const bool hapticEnabledDefaultValue = true;

  bool _hapticEnabled = hapticEnabledDefaultValue;

  bool get hapticEnabled => _hapticEnabled;

  void setHapticEnabled(bool isEnabled, {bool persistChange = true}) {
    _hapticEnabled = isEnabled;
    notifyListeners();
    if (persistChange) {
      service.setupByName(
        SettingsService.hapticsEnabledId,
        _hapticEnabled,
        valueType: SettingValueType.boolean,
      );
    }
  }

  void resetHapticEnabled({bool persistChange = true}) {
    _hapticEnabled = hapticEnabledDefaultValue;
    notifyListeners();

    if (persistChange) {
      service.deleteByName(SettingsService.hapticsEnabledId);
    }
  }

  void resetSettings() {
    resetSettingLocale();
    resetDisplayMenuCaptions();
    resetThemeMode();
    resetHapticEnabled();
  }
}

class SettingLocale {
  SettingLocale(this.locale);

  final Locale? locale;

  bool isEmpty() {
    return locale == null;
  }

  bool isNotEmpty() {
    return locale != null;
  }

  static SettingLocale get empty {
    return SettingLocale(null);
  }

  static SettingLocale of(Locale locale) {
    return SettingLocale(locale);
  }

  static SettingLocale fromLanguageCode(String languageCode) {
    return SettingLocale(Locale(languageCode));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! SettingLocale) {
      return false;
    }
    if (locale == null && other.locale == null) {
      return true;
    }

    return locale == other.locale;
  }

  @override
  int get hashCode => locale.hashCode;

  @override
  String toString() {
    if (locale == null) return '[SettingLocale] empty';
    return '[SettingLocale] $locale';
  }
}
