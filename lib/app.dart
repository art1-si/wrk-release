import 'package:flutter/material.dart';

import 'package:workout_notes_app/provider/day_selector_provider.dart';
import 'package:workout_notes_app/provider/provider_of_quick_add_button.dart';
import 'package:workout_notes_app/screens/home_page/front_page.dart';

import 'package:workout_notes_app/screens/home_page/home_page.dart';
import 'package:workout_notes_app/screens/home_page/landing_page.dart';
import 'package:workout_notes_app/services/database.dart';
import 'package:workout_notes_app/services/providers.dart';
import 'package:workout_notes_app/theme/themes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      builder: (context, Widget? child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child!,
        );
      },
      showPerformanceOverlay: false,
      theme: ThemesData().defualt,
      home: LandingPage(),
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
