import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/data_models/exercise.dart';
import 'package:workout_notes_app/data_models/group_by_model.dart';
import 'package:workout_notes_app/database/database.dart';
import 'package:workout_notes_app/services/providers.dart';

final exerciseViewModelProvider = ChangeNotifierProvider(
  (ref) => ExerciseViewModel(
    database: ref.watch(databaseProvider),
  ),
);
// ignore: top_level_function_literal_block
final exerciseStreamProvider = StreamProvider.autoDispose((ref) {
  final exerciseModelProvider = ref.watch(exerciseViewModelProvider);
  return exerciseModelProvider.groupedExercisesByType;
});
final exerciseStream = StreamProvider.autoDispose((ref) {
  final exerciseModelProvider = ref.watch(exerciseViewModelProvider);

  return exerciseModelProvider.exercises;
});

class ExerciseViewModel with ChangeNotifier {
  ExerciseViewModel({required this.database});
  bool showExercisesForSelectedType = false;
  final Database database;

  Stream<List<GroupByModel<Exercise>>> get groupedExercisesByType {
    return database.groupByValue<Exercise>(
      data: exercises,
      groupByValue: (exercise) => exercise.exerciseType,
      titleBuilder: (exercise) => exercise.exerciseType,
      dataID: (exercise) => exercise.id,
    );
  }

  Stream<List<Exercise>> get exercises => database.exercisesStream();
}
