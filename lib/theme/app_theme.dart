import 'package:flutter/material.dart';

class AppThemeData {
  final Color backgroundDark;
  final Color background;
  final Color backgroundLight;
  final Color primary;
  final Color primaryDark;
  final Color accentPrimary;
  final Color accentNegative;
  final Color accentSecendery;
  final Color accentPositive;
  final Color divider;

  const AppThemeData({
    required this.backgroundDark,
    required this.background,
    required this.backgroundLight,
    required this.primary,
    required this.primaryDark,
    required this.accentPrimary,
    required this.accentNegative,
    required this.accentSecendery,
    required this.accentPositive,
    required this.divider,
  });
}

class AppTheme extends InheritedWidget {
  const AppTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  final AppThemeData data;

  static AppThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<AppTheme>();
    if (theme != null) {
      return theme.data;
    } else {
      throw StateError("Could not find ancestor widget");
    }
  }

  @override
  bool updateShouldNotify(AppTheme oldWidget) => data != oldWidget.data;
}

class Themes {
  static const AppThemeData theme = AppThemeData(
    backgroundDark: Color(0xff0E1114),
    background: Color(0xff12151A),
    backgroundLight: Color(0xff15191F),
    primary: Color(0xff1F262E),
    primaryDark: Color(0xff1A1F26),
    accentPrimary: Color(0xff6886e6),
    accentNegative: Color(0xffFF4B58),
    accentSecendery: Color(0xff556ccd),
    accentPositive: Color(0xffFFA43A),
    divider: Colors.white12,
  );
}
