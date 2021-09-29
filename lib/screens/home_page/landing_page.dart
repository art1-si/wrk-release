import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/constants/offline_mode.dart';
import 'package:workout_notes_app/screens/home_page/home_page.dart';
import 'package:workout_notes_app/screens/home_page/sign_in_page.dart';
import 'package:workout_notes_app/widgets/auth_widget.dart';

class LandingPage extends ConsumerWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return OfflineMode.offline
        ? MyHomePage()
        : AuthWidget(
            nonSignedInBuilder: (_) => Consumer(builder: (context, watch, _) {
              return SignInPage();
            }),
            signedInBuilder: (_) => MyHomePage(),
          );
  }
}
