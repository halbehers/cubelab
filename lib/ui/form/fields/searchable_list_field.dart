import 'package:cubelab/l10n/settings/settings_localizations.dart';
import 'package:flutter/material.dart';
import 'package:cubelab/main.dart';
import 'package:cubelab/theme/app_theme.dart';
import 'package:cubelab/theme/h_icon.dart';
import 'package:cubelab/theme/icon_path.dart';

class SearchableListItem<T> {
  const SearchableListItem({required this.label, required this.value});

  final String label;
  final T value;
}

class SearchableListField<T> extends StatelessWidget {
  const SearchableListField({
    super.key,
    required this.label,
    required this.initialValue,
    required this.onValueChanged,
    required this.items,
  });

  final String label;
  final SearchableListItem<T> initialValue;
  final void Function(T value)? onValueChanged;
  final List<SearchableListItem<T>> items;

  @override
  Widget build(BuildContext context) {
    AppTheme appTheme = context.appTheme;

    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (context) => _SearchableListPage(
            label: label,
            initialValue: initialValue,
            onChanged: (value) => onValueChanged?.call(value),
            items: items,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 16.0,
          children: [
            Flexible(
              flex: 2,
              child: Text(
                label,
                style: appTheme.body,
                overflow: TextOverflow.clip,
              ),
            ),
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: Wrap(
                alignment: WrapAlignment.end,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 16.0,
                children: [
                  Text(initialValue.label, style: appTheme.subduedBody),
                  const HIcon(
                    iconPath: IconPath.arrowRight,
                    size: IconSize.small,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchableListPage<T> extends StatefulWidget {
  const _SearchableListPage({
    super.key,
    required this.label,
    required this.initialValue,
    required this.onChanged,
    required this.items,
  });

  final String label;
  final SearchableListItem<T> initialValue;
  final void Function(T value) onChanged;
  final List<SearchableListItem<T>> items;

  @override
  State<_SearchableListPage<T>> createState() => _SearchableListPageState<T>();
}

class _SearchableListPageState<T> extends State<_SearchableListPage<T>> {
  late T _selectedValue;
  late List<SearchableListItem<T>> _results;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue.value;
    _results = widget.items.toList();
  }

  void _onSearch(String input) {
    _results.clear();

    setState(() {
      if (input.isEmpty) {
        _results = widget.items.toList();
      } else {
        _results = widget.items
            .where(
              (item) => item.label.toLowerCase().contains(input.toLowerCase()),
            )
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final t = SettingsLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: appTheme.backgroundColor,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Padding(
            padding: EdgeInsets.all(12.0),
            child: HIcon(iconPath: IconPath.arrowLeft),
          ),
        ),
        title: Text(widget.label, style: appTheme.h2),
        backgroundColor: appTheme.backgroundColor,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 32.0,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: appTheme.highlightedBackgroundColor,
                border: BoxBorder.all(color: appTheme.borderColor),
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: appTheme.shadowColor,
                    blurRadius: 7,
                    spreadRadius: -3,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                textAlignVertical: TextAlignVertical.center,
                autofocus: true,
                decoration: InputDecoration(
                  icon: Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: HIcon(
                      iconPath: IconPath.search,
                      size: IconSize.small,
                      color: appTheme.subduedTextColor,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  hintStyle: appTheme.subduedBody,
                ),
                style: appTheme.body,
                onChanged: _onSearch,
              ),
            ),
          ),
          Expanded(
            child: _results.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(32.0),
                    // TODO
                    child: Text("No results", style: appTheme.subduedBody),
                  )
                : ListView.builder(
                    itemBuilder: (context, index) {
                      final item = _results[index];
                      final bool isSelected = item.value == _selectedValue;

                      return _SearchableListSettingItemRow(
                        isSelected: isSelected,
                        item: item,
                        isFirst: index == 0,
                        onChanged: (T value) {
                          setState(() {
                            _selectedValue = value;
                          });
                          widget.onChanged(value);
                        },
                      );
                    },
                    itemCount: _results.length,
                  ),
          ),
        ],
      ),
    );
  }
}

class _SearchableListSettingItemRow<T> extends StatelessWidget {
  const _SearchableListSettingItemRow({
    super.key,
    required this.isSelected,
    required this.item,
    required this.onChanged,
    this.isFirst = false,
  });

  final bool isSelected;
  final SearchableListItem<T> item;
  final void Function(T value) onChanged;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    AppTheme appTheme = context.appTheme;

    return GestureDetector(
      onTap: () {
        onChanged(item.value);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
        decoration: BoxDecoration(
          color: isSelected ? appTheme.secondaryColor : null,
          border: !isFirst
              ? BoxBorder.fromLTRB(top: BorderSide(color: appTheme.borderColor))
              : null,
        ),
        child: Row(
          children: [
            Flexible(
              flex: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: HIcon(
                  iconPath: isSelected ? IconPath.check : IconPath.empty,
                  color: appTheme.invertedTextColor,
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0,
                ),
                child: Text(
                  item.label,
                  style: isSelected ? appTheme.invertedBody : appTheme.body,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
