import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/data_models/exercise.dart';
import 'package:workout_notes_app/data_models/group_by_model.dart';
import 'package:workout_notes_app/screens/exercises_selector/services/exercise_view_model.dart';
import 'package:workout_notes_app/screens/new_entry_page/add_exercise_to_log.dart';
import 'package:workout_notes_app/screens/new_entry_page/services/add_exercise_log_page_view_model.dart';
import 'package:workout_notes_app/widgets/center_progress_indicator.dart';

class ExerciseTileWidget extends ConsumerWidget {
  const ExerciseTileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
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
    final _exercises = context.read(addExerciseLogProvider);
    _exercises.selectExercisesWithoutNotify(null);
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
          ElevatedButton(
            onPressed: () =>
                context.read(addExerciseLogProvider).selectExercises(null),
            child: Text("Go Back"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: exercises.selectedExercises!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    exercises.selectedExercises![index].exerciseName,
                    style: Theme.of(context).textTheme.headline6,
                  ),
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
      itemCount: data.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            data[index].title,
            style: Theme.of(context).textTheme.headline6,
          ),
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
