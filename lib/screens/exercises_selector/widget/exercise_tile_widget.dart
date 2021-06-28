import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/data_models/exercise.dart';
import 'package:workout_notes_app/data_models/group_by_model.dart';
import 'package:workout_notes_app/screens/exercises_selector/services/exercise_view_model.dart';
import 'package:workout_notes_app/widgets/center_progress_indicator.dart';

class ExerciseTileWidget extends ConsumerWidget {
  const ExerciseTileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final exercises = watch(exerciseStreamProvider);
    return exercises.when(
      data: (data) => _ExerciseListTile(data: data),
      loading: () => CenterProgressIndicator(),
      error: (e, __) => Center(
        child: Text("SOMETHING WENT WRONG\n$e"),
      ),
    );
  }
}

class _ExerciseListTile extends StatelessWidget {
  const _ExerciseListTile({Key? key, required this.data}) : super(key: key);
  final List<GroupByModel<Exercise>> data;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Text(data[index].title);
      },
    );
  }
}
