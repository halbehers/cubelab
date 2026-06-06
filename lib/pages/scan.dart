import 'package:cubelab/l10n/scan/scan_localizations.dart';
import 'package:cubelab/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:cubelab/theme/app_theme.dart';
import 'package:cubelab/main.dart';

class ScanPage extends MainPage {
  const ScanPage({super.key});

  @override
  PageID getID() => PageID.scan;

  @override
  Widget buildPage(BuildContext context) {
    AppTheme appTheme = context.appTheme;
    final t = ScanLocalizations.of(context)!;

    return Center(child: Text(t.menu_caption, style: appTheme.body));
  }
}
