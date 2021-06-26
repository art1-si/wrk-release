import 'package:email_password_sign_in_ui/email_password_sign_in_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const emailPasswordSignInPage = '/email-password-sign-in-page';
}

class AppRouter {
  static Route<dynamic>? onGenerateRoute(
      RouteSettings settings, FirebaseAuth firebaseAuth) {
    final args = settings.arguments;
    switch (settings.name) {
      case AppRoutes.emailPasswordSignInPage:
        return MaterialPageRoute(
          builder: (_) => EmailPasswordSignInPage.withFirebaseAuth(
            firebaseAuth,
            onSignedIn: args as void Function(),
          ),
          settings: settings,
          fullscreenDialog: true,
        );
    }
  }
}
