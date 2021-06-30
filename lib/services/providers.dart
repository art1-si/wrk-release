import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/data_models/exercise_log.dart';
import 'package:workout_notes_app/provider/day_selector_provider.dart';
import 'package:workout_notes_app/screens/home_page/service/entries_view_model.dart';
import 'package:workout_notes_app/screens/new_entry_page/services/add_exercise_log_page_view_model.dart';
import 'package:workout_notes_app/services/database.dart';

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final authStateChangesProvider = StreamProvider<User?>(
    (ref) => ref.watch(firebaseAuthProvider).authStateChanges());

final databaseProvider = Provider<FirestoreDatabase>((ref) {
  final auth = ref.watch(authStateChangesProvider);
  print(auth.data?.value?.email);
  if (auth.data?.value?.uid != null) {
    print("hello");
    return FirestoreDatabase(uid: auth.data!.value!.uid);
  }
  print("ops...");

  throw UnimplementedError();
});

final exerciseLogStream = StreamProvider.autoDispose<List<ExerciseLog>>((ref) {
  final database = ref.watch(databaseProvider);
  final date = ref.watch(selectedDateProvider);
  final seletedExercise = ref.watch(addExerciseLogProvider);
  final vm = EntriesViewModel(
    database: database,
    toDate: date.daySelected,
    byExerciseID: seletedExercise.selectedExercise.id,
  );
  return vm.getEntriesByExercise;
});
