import 'package:cubelab/l10n/home/home_localizations.dart';
import 'package:cubelab/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:cubelab/theme/app_theme.dart';
import 'package:cubelab/main.dart';

class HomePage extends MainPage {
  const HomePage({super.key});

  @override
  PageID getID() => PageID.home;

  @override
  Widget buildPage(BuildContext context) {
    AppTheme appTheme = context.appTheme;
    final t = HomeLocalizations.of(context)!;

    return Center(child: Text(t.menu_caption, style: appTheme.body));
  }
}
