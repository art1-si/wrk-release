import 'package:workout_notes_app/services/database.dart';

class ExerciseViewModel {
  ExerciseViewModel({required this.database});
  final FirestoreDatabase database;

  Stream<List<GroupByModel<Exercise>>> get groupedExercisesByType =>
      _exercises


  Stream<List<Exercise>> get _exercises =>database.exercisesStream();
}
