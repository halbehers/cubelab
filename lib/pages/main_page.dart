import 'package:cubelab/l10n/home/home_localizations.dart';
import 'package:cubelab/l10n/learn/learn_localizations.dart';
import 'package:cubelab/l10n/scan/scan_localizations.dart';
import 'package:cubelab/l10n/settings/settings_localizations.dart';
import 'package:cubelab/theme/h_icon.dart';
import 'package:cubelab/theme/icon_path.dart';
import 'package:flutter/material.dart';
import 'package:cubelab/theme/app_theme.dart';
import 'package:cubelab/main.dart';
import 'package:go_router/go_router.dart';

enum PageID {
  home("home"),
  scan("scan"),
  learn("learn"),
  settings("settings");

  const PageID(this.id);

  final String id;
}

class ButtonStackItem {
  const ButtonStackItem({
    required this.id,
    required this.iconPath,
    this.caption,
  });

  final String id;
  final IconPath iconPath;
  final String? caption;
}

enum ButtonStackSize { small, medium, large }

abstract class MainPage extends StatelessWidget {
  const MainPage({super.key});

  bool _hasCaption(ButtonStackItem item) => item.caption != null;

  List<ButtonStackItem> computeNavigationItems(BuildContext context) {
    final tHome = HomeLocalizations.of(context)!;
    final tScan = ScanLocalizations.of(context)!;
    final tLearn = LearnLocalizations.of(context)!;
    final tSettings = SettingsLocalizations.of(context)!;

    return [
      ButtonStackItem(
        id: PageID.home.id,
        iconPath: IconPath.calendar,
        caption: tHome.menu_caption,
      ),
      ButtonStackItem(
        id: PageID.scan.id,
        iconPath: IconPath.largeGrid,
        caption: tScan.menu_caption,
      ),
      ButtonStackItem(
        id: PageID.learn.id,
        iconPath: IconPath.list,
        caption: tLearn.menu_caption,
      ),
      ButtonStackItem(
        id: PageID.settings.id,
        iconPath: IconPath.gear,
        caption: tSettings.menu_caption,
      ),
    ];
  }

  PageID getID();

  Widget buildPage(BuildContext context);

  List<Widget> buildNavigationButtons(BuildContext context) {
    AppTheme appTheme = context.appTheme;
    final items = computeNavigationItems(context);

    void onSelectionChanged(String id) {
      PageID newSelectedPage = PageID.values.firstWhere(
        (view) => view.id == id,
      );
      context.go('/${newSelectedPage.id}');
    }

    return items
        .map(
          (item) => Expanded(
            child: GestureDetector(
              onTap: () => onSelectionChanged(item.id),
              behavior: HitTestBehavior.opaque,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  HIcon(
                    iconPath: item.iconPath,
                    isActive: getID().id == item.id,
                    size: IconSize.medium,
                  ),
                  if (_hasCaption(item))
                    Padding(
                      padding: const EdgeInsetsGeometry.only(top: 4),
                      child: Text(
                        item.caption!,
                        style: getID().id == item.id
                            ? appTheme.smallTextSecondary
                            : appTheme.smallText,
                      ),
                    ),
                ],
              ),
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    AppTheme appTheme = context.appTheme;

    final bottomInset = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: appTheme.backgroundColor,
      body: Column(
        children: [
          Expanded(child: buildPage(context)),
          Container(
            padding: EdgeInsets.only(bottom: bottomInset, top: 12.0),
            decoration: BoxDecoration(color: appTheme.secondaryBackgroundColor),
            child: Row(children: buildNavigationButtons(context)),
          ),
        ],
      ),
    );
  }
}
