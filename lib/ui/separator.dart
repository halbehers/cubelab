import 'package:flutter/material.dart';
import 'package:cubelab/main.dart';

class Separator extends StatelessWidget {
  const Separator({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Container(
      height: 1,
      decoration: BoxDecoration(color: appTheme.borderColor),
    );
  }
}
