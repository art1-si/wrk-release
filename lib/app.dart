import 'package:flutter/material.dart';

import 'package:workout_notes_app/routing/app_routes.dart';

import 'package:workout_notes_app/screens/home_page/landing_page.dart';
import 'package:workout_notes_app/services/providers.dart';
import 'package:workout_notes_app/theme/themes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseAuth = context.read(firebaseAuthProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, Widget? child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child!,
        );
      },
      showPerformanceOverlay: false,
      theme: ThemesData().defualt,
      home: LandingPage(),
      onGenerateRoute: (settings) =>
          AppRouter.onGenerateRoute(settings, firebaseAuth),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
