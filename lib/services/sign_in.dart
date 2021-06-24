import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/services/auth_base.dart';



class SignIn with ChangeNotifier {
  SignIn({
    required this.auth,
    required this.email,
    required this.password,
  });

  final AuthBase auth;
  String email;
  String password;

  Future<void> submit() async {
    try {
      await auth.signInWithEmailAndPassword(email, password);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }
}
