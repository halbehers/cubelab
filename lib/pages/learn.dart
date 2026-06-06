import 'package:cubelab/l10n/learn/learn_localizations.dart';
import 'package:cubelab/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:cubelab/theme/app_theme.dart';
import 'package:cubelab/main.dart';

class LearnPage extends MainPage {
  const LearnPage({super.key});

  @override
  PageID getID() => PageID.learn;

  @override
  Widget buildPage(BuildContext context) {
    AppTheme appTheme = context.appTheme;
    final t = LearnLocalizations.of(context)!;

    return Center(child: Text(t.menu_caption, style: appTheme.body));
  }
}
