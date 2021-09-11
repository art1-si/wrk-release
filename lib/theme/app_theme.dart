import 'package:flutter/material.dart';

class AppThemeData {
  final Color background;
  final Color primary;
  final Color accentPrimary;
  final Color accentNegative;
  final Color accentSecendery;
  final Color accentPositive;
  final Color divider;

  const AppThemeData({
    required this.background,
    required this.primary,
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
    background: Color(0xff12151A),
    primary: Color(0xff191D24),
    accentPrimary: Color(0xff6886e6),
    accentNegative: Color(0xffF03A47),
    accentSecendery: Color(0xff556ccd),
    accentPositive: Color(0xffffa038),
    divider: Colors.white12,
  );
}
