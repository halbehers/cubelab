import 'dart:ui';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  Locale get asLocale {
    final parts = split('_');
    return Locale(parts[0], parts.length > 1 ? parts[1] : null);
  }
}
