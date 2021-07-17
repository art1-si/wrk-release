import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/data_models/exercise.dart';
import 'package:workout_notes_app/data_models/group_by_model.dart';
import 'package:workout_notes_app/screens/exercises_selector/services/exercise_view_model.dart';
import 'package:workout_notes_app/screens/exercises_selector/widget/animated_tile.dart';
import 'package:workout_notes_app/screens/new_entry_page/add_exercise_to_log.dart';
import 'package:workout_notes_app/screens/new_entry_page/services/add_exercise_log_page_view_model.dart';
import 'package:workout_notes_app/widgets/center_progress_indicator.dart';

class ExerciseTileWidget extends ConsumerWidget {
  const ExerciseTileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    print("ExerciseTileWidget build");
    final exercises = watch(exerciseStreamProvider);
    return exercises.when(
      data: (data) => _ExerciseListTile.create(context, data: data),
      loading: () => CenterProgressIndicator(),
      error: (e, __) => Center(
        child: Text("SOMETHING WENT WRONG\n$e"),
      ),
    );
  }
}

class _ExerciseListTile extends ConsumerWidget {
  static Widget create(BuildContext context,
      {required List<GroupByModel<Exercise>> data}) {
    print("exerciseListTile.create is working");
    return _ExerciseListTile(data: data);
  }

  const _ExerciseListTile({Key? key, required this.data}) : super(key: key);
  final List<GroupByModel<Exercise>> data;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final exercises = watch(addExerciseLogProvider);

    if (exercises.selectedExercises != null) {
      return Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () =>
                  context.read(addExerciseLogProvider).selectExercises(null),
              child: SizedBox(
                height: 70,
                width: 50,
                child: Center(
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: exercises.selectedExercises!.length,
              itemBuilder: (context, index) {
                return AnimatedTile(
                  index: index,
                  title: exercises.selectedExercises![index].exerciseName,
                  onTap: () {
                    context
                        .read(addExerciseLogProvider)
                        .setSelectedExerciseIndex(index);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddExerciseToLog(),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(
        vertical: 8,
      ),
      itemCount: data.length,
      itemBuilder: (context, index) {
        return AnimatedTile(
          index: index,
          title: data[index].title,
          onTap: () {
            context
                .read(addExerciseLogProvider)
                .selectExercises(data[index].data);
          },
        );
      },
    );
  }
}
