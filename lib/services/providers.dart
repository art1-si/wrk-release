import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/database/database.dart';
import 'package:workout_notes_app/database/firebase/firebase_database.dart';
import 'package:workout_notes_app/database/sqlite/sqlite_service.dart';

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final authStateChangesProvider = StreamProvider<User?>(
    (ref) => ref.watch(firebaseAuthProvider).authStateChanges());

final databaseProvider = Provider.autoDispose<Database>((ref) {
  bool _offline = true;
  if (!_offline) {
    final auth = ref.watch(authStateChangesProvider);

    if (auth.data?.value?.uid != null) {
      return FirestoreDatabase(uid: auth.data!.value!.uid);
    }
    print("ops...");
  } else {
    return ref.watch(sqlDatabase);
  }

  throw UnimplementedError();
});
