import 'package:flutter/material.dart';

class ThemeColors {
  static const MaterialColor blue =
      MaterialColor(_bluePrimaryValue, <int, Color>{
        100: Color(0xFFC2E3FD),
        200: Color(0xFF78A8CE),
        300: Color(0xFF517EA1),
        400: Color(0xFF3A607E),
        500: Color(_bluePrimaryValue),
        600: Color(0xFF283F51),
      });

  static const int _bluePrimaryValue = 0xFF334E63;

  static const MaterialColor grey =
      MaterialColor(_greyPrimaryValue, <int, Color>{
        50: white,
        100: Color(_grey100Value),
        200: Color(0xFFD8D6D7),
        300: Color(0xFFAEAEAE),
        400: Color(0xFF6C6C6C),
        500: Color(_greyPrimaryValue),
        600: Color(0xFF2C2C2C),
        700: Color(0xFF1B1B1B),
      });

  static const int _grey100Value = 0xFFF6F4F7;
  static const int _greyPrimaryValue = 0xFF4A4446;
  static const Color background = Color(_grey100Value);
  static const Color white = Color(0xFFFFFCFC);
  static const Color pureWhite = Color(0xFFFFFFFF);
  static const Color pureBlack = Color(0xFF000000);

  static const MaterialColor turquoise =
      MaterialColor(_turquoisePrimaryValue, <int, Color>{
        100: Color(0xFFCCFDFF),
        200: Color(0xFF9EFBFF),
        300: Color(0xFF53F4FB),
        400: Color(0xFF39B0C1),
        500: Color(_turquoisePrimaryValue),
        600: Color(0xFF0C7280),
      });

  static const int _turquoisePrimaryValue = 0xFF1897A9;

  static const MaterialColor purple =
      MaterialColor(_purplePrimaryValue, <int, Color>{
        100: Color(0xFFF2E3F1),
        200: Color(0xFFEAC4E6),
        300: Color(0xFFDE8AD6),
        400: Color(0xFFBD3FB1),
        500: Color(_purplePrimaryValue),
        600: Color(0xFF52284E),
      });

  static const int _purplePrimaryValue = 0xFF802F78;

  static const MaterialColor yellow =
      MaterialColor(_yellowPrimaryValue, <int, Color>{
        100: Color(0xFFFFF2DF),
        200: Color(0xFFFFE5BD),
        300: Color(0xFFFCD8A2),
        400: Color(0xFFFFC772),
        500: Color(_yellowPrimaryValue),
        600: Color(0xFFE48900),
      });

  static const int _yellowPrimaryValue = 0xFFFFB547;

  static const MaterialColor red = MaterialColor(_redPrimaryValue, <int, Color>{
    100: Color(0xFFFFE2E1),
    200: Color(0xFFFAC9C8),
    300: Color(0xFFDDA2A1),
    400: Color(0xFFC86C6A),
    500: Color(_redPrimaryValue),
    600: Color(0xFF8F0805),
  });

  static const int _redPrimaryValue = 0xFFB7413E;
}
