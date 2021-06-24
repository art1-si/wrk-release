import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/data_models/user.dart';
import 'package:workout_notes_app/screens/home_page/home_page.dart';
import 'package:workout_notes_app/screens/home_page/sign_in_page.dart';
import 'package:workout_notes_app/services/providers.dart';

class LandingPage extends ConsumerWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _auth = watch(auth);
    return StreamBuilder<UserModel?>(
      stream: _auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot<UserModel?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          UserModel? _user = snapshot.data;
          if (_user == null) {
            return SignInPage();
          }
          return MyHomePage();
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
