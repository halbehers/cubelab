import 'package:cubelab/l10n/scan/scan_localizations.dart';
import 'package:cubelab/pages/main_page.dart';
import 'package:cubelab/scan/camera.dart';
import 'package:cubelab/scan/cube_state_form.dart';
import 'package:cubelab/ui/buttons/button.dart';
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

    return Column(
      children: [
        Center(child: Text(t.menu_caption, style: appTheme.body)),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: const Camera(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: Button(
            text: t.enter_manually,
            type: ButtonType.outlined,
            onPressed: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return CubeStateForm(onClose: () => Navigator.pop(context));
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
