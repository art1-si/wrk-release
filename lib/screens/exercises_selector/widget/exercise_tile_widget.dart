import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/screens/exercises_selector/services/exercise_view_model.dart';
import 'package:workout_notes_app/screens/exercises_selector/widget/exercise_list_tile.dart';
import 'package:workout_notes_app/screens/home_page/widget/back_drop_execise_selector/exercise_selector_back_drop_main.dart';
import 'package:workout_notes_app/screens/new_entry_page/services/add_exercise_log_page_view_model.dart';
import 'package:workout_notes_app/widgets/center_progress_indicator.dart';

class ExerciseTileWidget extends ConsumerWidget {
  const ExerciseTileWidget({
    Key? key,
    required this.onTap,
    required this.keyToPass,
  }) : super(key: key);
  final VoidCallback onTap;
  final GlobalKey keyToPass;
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    print("ExerciseTileWidget build");
    final exercises = watch(exerciseStreamProvider);
    return exercises.when(
      data: (data) => ExerciseSelectorBackDrop(
        child: ExerciseListTile(data: data),
        key: keyToPass,
        onTap: onTap,
        itemCount:
            (context.read(addExerciseLogProvider).selectedExercises != null)
                ? context.read(addExerciseLogProvider).selectedExercises!.length
                : data.length,
      ),
      loading: () => CenterProgressIndicator(),
      error: (e, __) => Center(
        child: Text("SOMETHING WENT WRONG\n$e"),
      ),
    );
  }
}
