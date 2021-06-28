import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/data_models/exercise.dart';
import 'package:workout_notes_app/data_models/group_by_model.dart';
import 'package:workout_notes_app/services/database.dart';
import 'package:workout_notes_app/services/providers.dart';

final exerciseViewModelProvider = ChangeNotifierProvider(
  (ref) => ExerciseViewModel(
    database: ref.watch(databaseProvider),
  ),
);
final exerciseStreamProvider = StreamProvider((ref) {
  final exerciseModelProvider = ref.watch(exerciseViewModelProvider);
  return exerciseModelProvider.groupedExercisesByType;
});

class ExerciseViewModel with ChangeNotifier {
  ExerciseViewModel({required this.database});
  final FirestoreDatabase database;

  Stream<List<GroupByModel<Exercise>>> get groupedExercisesByType =>
      database.groupByValue<Exercise>(
          data: _exercises,
          groupByValue: (exercise) => exercise.exerciseType,
          titleBuilder: (exercise) => exercise.exerciseType);

  Stream<List<Exercise>> get _exercises => database.exercisesStream();
}
