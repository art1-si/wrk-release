import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/screens/exercises_selector/services/exercise_view_model.dart';
import 'package:workout_notes_app/screens/exercises_selector/widget/exercise_tile_widget.dart';

class TypeSelectorPage extends StatelessWidget {
  const TypeSelectorPage({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          "Exercises",
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: ExerciseTileWidget(),
    );
  }
}
