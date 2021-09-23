import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/database/firebase/firebase_database.dart';

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
