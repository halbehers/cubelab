import 'package:flutter/material.dart';

@immutable
class AppTheme extends ThemeExtension<AppTheme> {
  const AppTheme({
    required this.backgroundColor,
    required this.highlightedBackgroundColor,
    required this.textColor,
    required this.invertedTextColor,
    required this.subduedTextColor,
    required this.disabledTextColor,
    required this.iconColor,
    required this.iconActiveColor,
    required this.primaryColor,
    required this.primaryBackgroundColor,
    required this.secondaryColor,
    required this.secondaryBackgroundColor,
    required this.accentColor,
    required this.accentBackgroundColor,
    required this.secondaryAccentColor,
    required this.secondaryAccentBackgroundColor,
    required this.shadowColor,
    required this.borderColor,
    required this.startingWeekColor,
    required this.startingWeekBackgroundColor,
    required this.refinementWeekColor,
    required this.refinementWeekBackgroundColor,
    required this.transformationWeekColor,
    required this.transformationWeekBackgroundColor,
    required this.implementationWeekColor,
    required this.implementationWeekBackgroundColor,
    required this.pureHighlightColor,
    required this.dangerColor,
    required this.dangerBackgroundColor,
  });

  final Color backgroundColor;
  final Color highlightedBackgroundColor;
  final Color textColor;
  final Color invertedTextColor;
  final Color subduedTextColor;
  final Color disabledTextColor;
  final Color iconColor;
  final Color iconActiveColor;
  final Color primaryColor;
  final Color primaryBackgroundColor;
  final Color secondaryColor;
  final Color secondaryBackgroundColor;
  final Color accentColor;
  final Color accentBackgroundColor;
  final Color secondaryAccentColor;
  final Color secondaryAccentBackgroundColor;
  final Color shadowColor;
  final Color borderColor;
  final Color startingWeekColor;
  final Color startingWeekBackgroundColor;
  final Color refinementWeekColor;
  final Color refinementWeekBackgroundColor;
  final Color transformationWeekColor;
  final Color transformationWeekBackgroundColor;
  final Color implementationWeekColor;
  final Color implementationWeekBackgroundColor;
  final Color pureHighlightColor;
  final Color dangerColor;
  final Color dangerBackgroundColor;

  TextStyle get h1 =>
      TextStyle(color: textColor, fontSize: 28, fontWeight: FontWeight.w600);
  TextStyle get h2 =>
      TextStyle(color: textColor, fontSize: 24, fontWeight: FontWeight.w600);
  TextStyle get accentH2 =>
      TextStyle(color: accentColor, fontSize: 24, fontWeight: FontWeight.w600);
  TextStyle get h3 =>
      TextStyle(color: textColor, fontSize: 20, fontWeight: FontWeight.w600);
  TextStyle get invertedH3 => TextStyle(
    color: invertedTextColor,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );
  TextStyle get h4 =>
      TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.w500);
  TextStyle get subduedH4 => TextStyle(
    color: subduedTextColor,
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );
  TextStyle get secondaryH4 => TextStyle(
    color: secondaryColor,
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );
  TextStyle get h5 =>
      TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.w500);
  TextStyle get subduedH5 => TextStyle(
    color: subduedTextColor,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  TextStyle get secondaryH5 => TextStyle(
    color: secondaryColor,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  TextStyle get accentH5 =>
      TextStyle(color: accentColor, fontSize: 16, fontWeight: FontWeight.w500);
  TextStyle get body =>
      TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.w400);
  TextStyle get invertedBody => TextStyle(
    color: invertedTextColor,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
  TextStyle get subduedBody => TextStyle(
    color: subduedTextColor,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
  TextStyle get secondaryBody => TextStyle(
    color: secondaryColor,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
  TextStyle get dangerBody =>
      TextStyle(color: dangerColor, fontSize: 16, fontWeight: FontWeight.w400);
  TextStyle get invertedBoldBody => TextStyle(
    color: invertedTextColor,
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );
  TextStyle get smallText =>
      TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.w400);
  TextStyle get invertedSmallText => TextStyle(
    color: invertedTextColor,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
  TextStyle get accentSmallText =>
      TextStyle(color: accentColor, fontSize: 12, fontWeight: FontWeight.w400);
  TextStyle get secondarySmallText => TextStyle(
    color: secondaryColor,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
  TextStyle get boldSmallText =>
      TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.w700);
  TextStyle get invertedBoldSmallText => TextStyle(
    color: invertedTextColor,
    fontSize: 12,
    fontWeight: FontWeight.w700,
  );
  TextStyle get smallTextSecondary => TextStyle(
    color: secondaryColor,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
  TextStyle get extraSmallText =>
      TextStyle(color: textColor, fontSize: 10, fontWeight: FontWeight.w400);

  @override
  AppTheme copyWith({
    Color? background,
    Color? highlightedBackgroundColor,
    Color? textColor,
    Color? invertedTextColor,
    Color? subduedTextColor,
    Color? disabledTextColor,
    Color? iconColor,
    Color? iconActiveColor,
    Color? primaryColor,
    Color? primaryBackgroundColor,
    Color? secondaryColor,
    Color? secondaryBackgroundColor,
    Color? accentColor,
    Color? accentBackgroundColor,
    Color? secondaryAccentColor,
    Color? secondaryAccentBackgroundColor,
    Color? shadowColor,
    Color? borderColor,
    Color? startingWeekColor,
    Color? startingWeekBackgroundColor,
    Color? refinementWeekColor,
    Color? refinementWeekBackgroundColor,
    Color? transformationWeekColor,
    Color? transformationWeekBackgroundColor,
    Color? implementationWeekColor,
    Color? implementationWeekBackgroundColor,
    Color? pureHighlightColor,
    Color? dangerColor,
    Color? dangerBackgroundColor,
  }) {
    return AppTheme(
      backgroundColor: background ?? backgroundColor,
      highlightedBackgroundColor:
          highlightedBackgroundColor ?? this.highlightedBackgroundColor,
      textColor: textColor ?? this.textColor,
      invertedTextColor: invertedTextColor ?? this.invertedTextColor,
      subduedTextColor: subduedTextColor ?? this.subduedTextColor,
      disabledTextColor: disabledTextColor ?? this.disabledTextColor,
      iconColor: iconColor ?? this.iconColor,
      iconActiveColor: iconActiveColor ?? this.iconActiveColor,
      accentColor: accentColor ?? this.accentColor,
      primaryColor: primaryColor ?? this.primaryColor,
      primaryBackgroundColor:
          primaryBackgroundColor ?? this.primaryBackgroundColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      secondaryBackgroundColor:
          secondaryBackgroundColor ?? this.secondaryBackgroundColor,
      accentBackgroundColor:
          accentBackgroundColor ?? this.accentBackgroundColor,
      secondaryAccentColor: secondaryAccentColor ?? this.secondaryAccentColor,
      secondaryAccentBackgroundColor:
          secondaryAccentBackgroundColor ?? this.secondaryAccentBackgroundColor,
      shadowColor: shadowColor ?? this.shadowColor,
      borderColor: borderColor ?? this.borderColor,
      startingWeekColor: startingWeekColor ?? this.startingWeekColor,
      startingWeekBackgroundColor:
          startingWeekBackgroundColor ?? this.startingWeekBackgroundColor,
      refinementWeekColor: refinementWeekColor ?? this.refinementWeekColor,
      refinementWeekBackgroundColor:
          refinementWeekBackgroundColor ?? this.refinementWeekBackgroundColor,
      transformationWeekColor:
          transformationWeekColor ?? this.transformationWeekColor,
      transformationWeekBackgroundColor:
          transformationWeekBackgroundColor ??
          this.transformationWeekBackgroundColor,
      implementationWeekColor:
          implementationWeekColor ?? this.implementationWeekColor,
      implementationWeekBackgroundColor:
          implementationWeekBackgroundColor ??
          this.implementationWeekBackgroundColor,
      pureHighlightColor: pureHighlightColor ?? this.pureHighlightColor,
      dangerColor: dangerColor ?? this.dangerColor,
      dangerBackgroundColor:
          dangerBackgroundColor ?? this.dangerBackgroundColor,
    );
  }

  @override
  AppTheme lerp(ThemeExtension<AppTheme>? other, double t) {
    if (other is! AppTheme) {
      return this;
    }
    return AppTheme(
      backgroundColor:
          Color.lerp(backgroundColor, other.backgroundColor, t) ?? Colors.white,
      highlightedBackgroundColor:
          Color.lerp(
            highlightedBackgroundColor,
            other.highlightedBackgroundColor,
            t,
          ) ??
          Colors.white,
      textColor: Color.lerp(textColor, other.textColor, t) ?? Colors.black,
      invertedTextColor:
          Color.lerp(invertedTextColor, other.invertedTextColor, t) ??
          Colors.black,
      subduedTextColor:
          Color.lerp(subduedTextColor, other.subduedTextColor, t) ??
          Colors.black,
      disabledTextColor:
          Color.lerp(disabledTextColor, other.disabledTextColor, t) ??
          Colors.black,
      iconColor: Color.lerp(iconColor, other.iconColor, t) ?? Colors.black,
      iconActiveColor:
          Color.lerp(iconActiveColor, other.iconActiveColor, t) ?? Colors.black,
      primaryColor:
          Color.lerp(primaryColor, other.primaryColor, t) ?? Colors.black,
      primaryBackgroundColor:
          Color.lerp(primaryBackgroundColor, other.primaryBackgroundColor, t) ??
          Colors.black,
      secondaryColor:
          Color.lerp(secondaryColor, other.secondaryColor, t) ?? Colors.black,
      secondaryBackgroundColor:
          Color.lerp(
            secondaryBackgroundColor,
            other.secondaryBackgroundColor,
            t,
          ) ??
          Colors.black,
      accentColor:
          Color.lerp(accentColor, other.accentColor, t) ?? Colors.black,
      accentBackgroundColor:
          Color.lerp(accentBackgroundColor, other.accentBackgroundColor, t) ??
          Colors.black,
      secondaryAccentColor:
          Color.lerp(secondaryAccentColor, other.secondaryAccentColor, t) ??
          Colors.black,
      secondaryAccentBackgroundColor:
          Color.lerp(
            secondaryAccentBackgroundColor,
            other.secondaryAccentBackgroundColor,
            t,
          ) ??
          Colors.black,
      shadowColor:
          Color.lerp(shadowColor, other.shadowColor, t) ?? Colors.black,
      borderColor:
          Color.lerp(borderColor, other.borderColor, t) ?? Colors.black,
      startingWeekColor:
          Color.lerp(startingWeekColor, other.startingWeekColor, t) ??
          Colors.black,
      startingWeekBackgroundColor:
          Color.lerp(
            startingWeekBackgroundColor,
            other.startingWeekBackgroundColor,
            t,
          ) ??
          Colors.black,
      refinementWeekColor:
          Color.lerp(refinementWeekColor, other.refinementWeekColor, t) ??
          Colors.black,
      refinementWeekBackgroundColor:
          Color.lerp(
            refinementWeekBackgroundColor,
            other.refinementWeekBackgroundColor,
            t,
          ) ??
          Colors.black,
      transformationWeekColor:
          Color.lerp(
            transformationWeekColor,
            other.transformationWeekColor,
            t,
          ) ??
          Colors.black,
      transformationWeekBackgroundColor:
          Color.lerp(
            transformationWeekBackgroundColor,
            other.transformationWeekBackgroundColor,
            t,
          ) ??
          Colors.black,
      implementationWeekColor:
          Color.lerp(
            implementationWeekColor,
            other.implementationWeekColor,
            t,
          ) ??
          Colors.black,
      implementationWeekBackgroundColor:
          Color.lerp(
            implementationWeekBackgroundColor,
            other.implementationWeekBackgroundColor,
            t,
          ) ??
          Colors.black,
      pureHighlightColor:
          Color.lerp(pureHighlightColor, other.pureHighlightColor, t) ??
          Colors.black,
      dangerColor:
          Color.lerp(dangerColor, other.dangerColor, t) ?? Colors.black,
      dangerBackgroundColor:
          Color.lerp(dangerBackgroundColor, other.dangerBackgroundColor, t) ??
          Colors.black,
    );
  }
}
