import 'package:flutter/material.dart';
import 'package:workout_notes_app/theme/app_theme.dart';

class CreateNewExercise extends StatelessWidget {
  const CreateNewExercise({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.of(context).background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Exercise name"),
          TextFormField(),
          Text("Exercise Type"),
          TextFormField(),
        ],
      ),
    );
  }
}
