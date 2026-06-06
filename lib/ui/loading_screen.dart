import 'package:flutter/material.dart';
import 'package:cubelab/l10n/general/general_localizations.dart';
import 'package:cubelab/main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final t = GeneralLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: appTheme.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(t.app_name, style: appTheme.h1),
            LoadingAnimationWidget.beat(
              color: appTheme.disabledTextColor,
              size: 64,
            ),
            Text(t.app_loading, style: appTheme.body),
          ],
        ),
      ),
    );
  }
}
