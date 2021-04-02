import 'package:flutter/material.dart';

import 'package:workout_notes_app/plan_page/workout_plans_page.dart';
import 'package:workout_notes_app/screens/home_page/home_page.dart';

class FrontPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("FrontPage build");
    return PageView(
      children: [
        MyHomePage(),
        WorkoutPlansPage(),
      ],
    );
  }
}