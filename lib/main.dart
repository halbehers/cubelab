import 'package:cubelab/l10n/home/home_localizations.dart';
import 'package:cubelab/l10n/learn/learn_localizations.dart';
import 'package:cubelab/l10n/scan/scan_localizations.dart';
import 'package:cubelab/l10n/settings/settings_localizations.dart';
import 'package:cubelab/pages/learn.dart';
import 'package:cubelab/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cubelab/l10n/general/general_localizations.dart';
import 'package:cubelab/pages/home.dart';
import 'package:cubelab/pages/scan.dart';
import 'package:cubelab/providers/settings_provider.dart';
import 'package:cubelab/theme/app_theme.dart';
import 'package:cubelab/theme/theme_colors.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  runApp(const MyApp());
}

AppTheme lightAppTheme = AppTheme(
  backgroundColor: ThemeColors.grey[100]!,
  highlightedBackgroundColor: ThemeColors.white,
  textColor: ThemeColors.grey[600]!,
  invertedTextColor: ThemeColors.white,
  subduedTextColor: ThemeColors.grey[400]!,
  disabledTextColor: ThemeColors.grey[300]!,
  iconColor: ThemeColors.grey[500]!,
  iconActiveColor: ThemeColors.turquoise[500]!,
  primaryColor: ThemeColors.blue[500]!,
  primaryBackgroundColor: ThemeColors.blue[200]!,
  secondaryColor: ThemeColors.turquoise[500]!,
  secondaryBackgroundColor: ThemeColors.turquoise[200]!,
  accentColor: ThemeColors.yellow[600]!,
  accentBackgroundColor: ThemeColors.yellow[300]!,
  secondaryAccentColor: ThemeColors.purple[500]!,
  secondaryAccentBackgroundColor: ThemeColors.purple[300]!,
  shadowColor: ThemeColors.grey[200]!,
  borderColor: ThemeColors.grey[200]!,
  startingWeekColor: ThemeColors.red[500]!,
  startingWeekBackgroundColor: ThemeColors.red[300]!,
  refinementWeekColor: ThemeColors.grey[400]!,
  refinementWeekBackgroundColor: ThemeColors.grey[200]!,
  transformationWeekColor: ThemeColors.blue[400]!,
  transformationWeekBackgroundColor: ThemeColors.blue[200]!,
  implementationWeekColor: ThemeColors.yellow[500]!,
  implementationWeekBackgroundColor: ThemeColors.yellow[300]!,
  pureHighlightColor: ThemeColors.pureWhite,
  dangerColor: ThemeColors.red[600]!,
  dangerBackgroundColor: ThemeColors.red[200]!,
  cubeBlueColor: ThemeColors.cubeBlue,
  cubeGreenColor: ThemeColors.cubeGreen,
  cubeRedColor: ThemeColors.cubeRed,
  cubeYellowColor: ThemeColors.cubeYellow,
  cubeOrangeColor: ThemeColors.cubeOrange,
  cubeWhiteColor: ThemeColors.cubeWhite,
);

AppTheme darkAppTheme = AppTheme(
  backgroundColor: ThemeColors.grey[700]!,
  highlightedBackgroundColor: ThemeColors.grey[600]!,
  textColor: ThemeColors.white,
  invertedTextColor: ThemeColors.grey[600]!,
  subduedTextColor: ThemeColors.grey[200]!,
  disabledTextColor: ThemeColors.grey[400]!,
  iconColor: ThemeColors.grey[100]!,
  iconActiveColor: ThemeColors.turquoise[200]!,
  primaryColor: ThemeColors.blue[200]!,
  primaryBackgroundColor: ThemeColors.blue[500]!,
  secondaryColor: ThemeColors.turquoise[300]!,
  secondaryBackgroundColor: ThemeColors.turquoise[500]!,
  accentColor: ThemeColors.yellow[400]!,
  accentBackgroundColor: ThemeColors.yellow[500]!,
  secondaryAccentColor: ThemeColors.purple[300]!,
  secondaryAccentBackgroundColor: ThemeColors.purple[500]!,
  shadowColor: ThemeColors.grey[400]!,
  borderColor: ThemeColors.grey[500]!,
  startingWeekColor: ThemeColors.red[300]!,
  startingWeekBackgroundColor: ThemeColors.red[500]!,
  refinementWeekColor: ThemeColors.grey[200]!,
  refinementWeekBackgroundColor: ThemeColors.grey[400]!,
  transformationWeekColor: ThemeColors.blue[200]!,
  transformationWeekBackgroundColor: ThemeColors.blue[400]!,
  implementationWeekColor: ThemeColors.yellow[300]!,
  implementationWeekBackgroundColor: ThemeColors.yellow[500]!,
  pureHighlightColor: ThemeColors.pureBlack,
  dangerColor: ThemeColors.red[300]!,
  dangerBackgroundColor: ThemeColors.red[600]!,
  cubeBlueColor: ThemeColors.cubeBlue,
  cubeGreenColor: ThemeColors.cubeGreen,
  cubeRedColor: ThemeColors.cubeRed,
  cubeYellowColor: ThemeColors.cubeYellow,
  cubeOrangeColor: ThemeColors.cubeOrange,
  cubeWhiteColor: ThemeColors.cubeWhite,
);

extension BuildContextExtension on BuildContext {
  AppTheme get appTheme {
    return Theme.of(this).extension<AppTheme>()!;
  }
}

final _router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomePage()),
    GoRoute(
      path: '/home',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const HomePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurveTween(
                curve: Curves.easeInOutCirc,
              ).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/scan',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const ScanPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurveTween(
                curve: Curves.easeInOutCirc,
              ).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/learn',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const LearnPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurveTween(
                curve: Curves.easeInOutCirc,
              ).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/settings',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const SettingsPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurveTween(
                curve: Curves.easeInOutCirc,
              ).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SettingsProvider(),
      builder: (context, child) {
        final SettingsProvider provider = Provider.of<SettingsProvider>(
          context,
        );

        return MaterialApp.router(
          title: 'CubeLab',
          themeMode: provider.themeMode,
          locale: provider.settingLocale.locale,
          theme: ThemeData(
            fontFamily: "Brandon",
            extensions: <ThemeExtension<dynamic>>[lightAppTheme],
          ),
          darkTheme: ThemeData(
            fontFamily: "Brandon",
            extensions: <ThemeExtension<dynamic>>[darkAppTheme],
          ),
          routerConfig: _router,
          debugShowMaterialGrid: false,
          localizationsDelegates: [
            ...GeneralLocalizations.localizationsDelegates,
            ...HomeLocalizations.localizationsDelegates,
            ...ScanLocalizations.localizationsDelegates,
            ...LearnLocalizations.localizationsDelegates,
            ...SettingsLocalizations.localizationsDelegates,
          ],
          supportedLocales: [
            ...GeneralLocalizations.supportedLocales,
            ...HomeLocalizations.supportedLocales,
            ...ScanLocalizations.supportedLocales,
            ...LearnLocalizations.supportedLocales,
            ...SettingsLocalizations.supportedLocales,
          ],
        );
      },
    );
  }
}
