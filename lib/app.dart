import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_notes_app/provider/day_selector_provider.dart';
import 'package:workout_notes_app/provider/provider_of_quick_add_button.dart';

import 'package:workout_notes_app/screens/home_page/home_page.dart';
import 'package:workout_notes_app/theme/themes.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DaySelectorModel>(
            create: (context) => DaySelectorModel()),
        ChangeNotifierProvider(
          create: (BuildContext context) => ProviderOfQuickAddButton(false, ""),
        )
      ],
      child: MaterialApp(
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: MyBehavior(),
            child: child,
          );
        },
        showPerformanceOverlay: false,
        theme: ThemesData().defualt,
        home: MyHomePage(),
      ),
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
