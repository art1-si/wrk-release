import 'package:firebase_auth/firebase_auth.dart';
import 'package:workout_notes_app/data_models/user.dart';

abstract class AuthBase {
  Stream<UserModel?> get onAuthStateChanged;
  Future<UserModel?> currentUser();
  Future<UserModel?> signInWithEmailAndPassword(String email, String password);
  Future<UserModel> createUserWithEmailAndPassword(
      String email, String password);
  Future<UserModel?> signInAnonymously();
  Future<void> signOut();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  UserModel? _userFromFirebase(User? user) {
    if (user == null) {
      return null;
    }
    return UserModel(uid: user.uid);
  }

  @override
  Future<UserModel> createUserWithEmailAndPassword(
      String email, String password) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(authResult.user)!;
  }

  @override
  Future<UserModel> currentUser() async {
    final user = _firebaseAuth.currentUser;
    return _userFromFirebase(user)!;
  }

  @override
  Stream<UserModel?> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  @override
  Future<UserModel?> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<UserModel?> signInWithEmailAndPassword(
      String email, String password) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
