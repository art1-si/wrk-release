import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/data_models/user.dart';
import 'package:workout_notes_app/screens/home_page/home_page.dart';
import 'package:workout_notes_app/screens/home_page/sign_in_page.dart';
import 'package:workout_notes_app/screens/onboarding/onboarding_page.dart';
import 'package:workout_notes_app/screens/onboarding/onboarding_view_model.dart';
import 'package:workout_notes_app/services/providers.dart';
import 'package:workout_notes_app/widgets/auth_widget.dart';

class LandingPage extends ConsumerWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return AuthWidget(
      nonSignedInBuilder: (_) => Consumer(builder: (context, watch, _) {
        final didCompleteOnBoarding = watch(onboardingViewModelProvider);
        return didCompleteOnBoarding ? OnboardingPage() : SignInPage();
      }),
      signedInBuilder: (_) => MyHomePage(),
    );
  }
}
